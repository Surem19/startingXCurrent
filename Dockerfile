FROM openjdk:8u212-jre-alpine3.9
ADD etc application/etc
ADD lib application/lib
ADD docker/logback.xml application/etc/logback.xml

EXPOSE 9000

WORKDIR /application
ENV JAVA_MEM="-Xms32m -Xmx256m"
ENTRYPOINT exec java -cp "./etc:./lib/*" -server $JAVA_MEM $JAVA_OPTS com.ripple.xcurrent.server.XCurrentServerMain
