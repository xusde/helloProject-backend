FROM registry.cn-hangzhou.aliyuncs.com/xx_blog/openjdk:21-jdk
LABEL authors="peng"
COPY target/helloProject-0.0.1-SNAPSHOT.jar /app/helloProj.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app/helloProj.jar"]