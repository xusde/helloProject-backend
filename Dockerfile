FROM registry.cn-hangzhou.aliyuncs.com/xx_blog/openjdk:21-jdk
LABEL maintainer="xx@qq.com"
#复制打好的jar包
COPY target/*.jar /app.jar

ENV JAVA_OPTS=""
ENV PARAMS=""

EXPOSE 8001

ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar /app.jar $PARAMS" ]