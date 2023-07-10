##
## Build stage
##
#FROM maven:3.9.3 AS build
#COPY src /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package
#
##
## Package stage
##
#FROM openjdk:20
#COPY --from=build /home/app/target/test-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
#ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]
#
# Build stage
#
FROM maven:3.9.3 AS build

ARG DB_URL
ARG DB_USERNAME
ARG DB_PASSWORD

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:20
COPY --from=build /home/app/target/test-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]