# Creates a compact diff between two reflect json files
java -classpath `dirname $0`/../spring-native-tools/target/spring-native-tools-*.jar org.springframework.nativex.support.ReflectionJsonStrip $1 $2
