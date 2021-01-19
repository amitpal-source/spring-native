Spring Boot famous Petclinic sample with JDBC persistence.

To build and run the native application packaged in a lightweight container with `default` mode:
```
mvn spring-boot:build-image
docker-compose up
```

This is a proof of concept to observe how PGO improves the performance of workloads when compared to the standard native image using Petclinic and Springboot apps

The tools, techniques and results are shown below 
With throughput using Jmeter JMX for pet clinic

A)Regular Native Image

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



