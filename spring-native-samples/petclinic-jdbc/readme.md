Spring Boot famous Petclinic sample with JDBC persistence.

To build and run the native application packaged in a lightweight container with `default` mode:
```
mvn spring-boot:build-image
docker-compose up
```

This is a proof of concept to observe how PGO improves the performance of workloads when compared to the standard native image using Petclinic and Springboot apps

The tools, techniques and results are shown below 
With throughput using Jmeter JMX for pet clinic

A) Regular Native Image

```
Amitpals-MacBook-Pro-2:petclinic-jdbc adhillon$ ./build.sh 
=== Building petclinic-jdbc sample ===
Packaging petclinic-jdbc with Maven
Unpacking petclinic-jdbc-0.0.1-SNAPSHOT.jar
Compiling petclinic-jdbc with GraalVM Version 20.2.0 (Java Version 1.8.0_261)
SUCCESS
Testing executable 'petclinic-jdbc'
SUCCESS
Build memory: 7.64GB
Image build time: 492.6s
RSS memor
: 64.0M
Image size: 106.2M
```

1st Run Startup time: 0.372 (JVM running for 0.406)\
2nd Run Startup time: 0.253 (JVM running for 0.256)\
3rd Run Startup time: 0.14 (JVM running for 0.143)\
4th Run Startup time: 0.11 (JVM running for 0.113)

![image](https://github.com/amitpal-source/spring-native/blob/master/spring-native-samples/petclinic-jdbc/Screenshot%202020-09-28%20at%2009.28.24.png)

A) After PGO 1st Run

```
Amitpals-MacBook-Pro-2:petclinic-jdbc adhillon$ ./build.sh 
=== Building petclinic-jdbc sample ===
Packaging petclinic-jdbc with Maven
Unpacking petclinic-jdbc-0.0.1-SNAPSHOT.jar
Compiling petclinic-jdbc with GraalVM Version 20.2.0 (Java Version 1.8.0_261)
SUCCESS
Testing executable 'petclinic-jdbc'
SUCCESS
Build memory: 7.01GB
Image build time: 507.8s
RSS memory: 62.8M
Image size: 95.0M
```
Startup time: 0.411 (JVM running for 0.449)

B) After PGO 2nd Run

```
Amitpals-MacBook-Pro-2:petclinic-jdbc adhillon$ ./build.sh 
=== Building petclinic-jdbc sample ===
Packaging petclinic-jdbc with Maven
Unpacking petclinic-jdbc-0.0.1-SNAPSHOT.jar
Compiling petclinic-jdbc with GraalVM Version 20.2.0 (Java Version 1.8.0_261)
SUCCESS
Testing executable 'petclinic-jdbc'
SUCCESS
Build memory: 6.77GB
Image build time: 523.4s
RSS memory: 62.8M
Image size: 95.1M
```
1st Run Startup time: 0.4 (JVM running for 0.448)\
2nd Run Startup time: 0.1 (JVM running for 0.102)\
3rd Run Startup time: 0.206 (JVM running for 0.208)\
4th Run Startup time: 0.109 (JVM running for 0.111)\
5th Run Startup time: 0.105 (JVM running for 0.107)








