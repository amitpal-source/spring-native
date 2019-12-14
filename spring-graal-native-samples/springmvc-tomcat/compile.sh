#!/usr/bin/env bash

ARTIFACT=springmvc-tomcat
MAINCLASS=com.example.tomcat.TomcatApplication
VERSION=0.0.1-SNAPSHOT
FEATURE=../../../../spring-graal-native-feature/target/spring-graal-native-feature-0.6.0.BUILD-SNAPSHOT.jar

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

rm -rf target
mkdir -p target/native-image

echo "Packaging $ARTIFACT with Maven"
../../mvnw -DskipTests package > target/native-image/output.txt

JAR="$ARTIFACT-$VERSION.jar"
rm -f $ARTIFACT
echo "Unpacking $JAR"
cd target/native-image
jar -xvf ../$JAR >/dev/null 2>&1
cp -R META-INF BOOT-INF/classes

LIBPATH=`find BOOT-INF/lib | tr '\n' ':'`
CP=BOOT-INF/classes:$LIBPATH:$FEATURE

GRAALVM_VERSION=`native-image --version`
echo "Compiling $ARTIFACT with $GRAALVM_VERSION"
native-image \
  --no-server \
  --initialize-at-build-time=org.eclipse.jdt,org.apache.el.parser.SimpleNode,javax.servlet.jsp.JspFactory,org.apache.jasper.servlet.JasperInitializer,org.apache.jasper.runtime.JspFactoryImpl -H:+JNI \
  -H:EnableURLProtocols=http,https,jar \
  -H:ReflectionConfigurationFiles=../../tomcat-reflection.json -H:ResourceConfigurationFiles=../../tomcat-resource.json -H:JNIConfigurationFiles=../../tomcat-jni.json \
  -H:ClassInitialization=org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration:run_time \
  --enable-https \
  -H:+TraceClassInitialization \
  -H:IncludeResourceBundles=javax.servlet.http.LocalStrings \
  -H:Name=$ARTIFACT \
  -H:+ReportExceptionStackTraces \
  --no-fallback \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  -Dsun.rmi.transport.tcp.maxConnectionThreads=0 \
  -DremoveUnusedAutoconfig=true \
  -cp $CP $MAINCLASS >> output.txt

if [[ -f $ARTIFACT ]]
then
  printf "${GREEN}SUCCESS${NC}\n"
  mv ./$ARTIFACT ..
  exit 0
else
  printf "${RED}FAILURE${NC}: an error occurred when compiling the native-image.\n"
  exit 1
fi
