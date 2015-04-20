#!/bin/sh

TOMCAT_HOME="/home/ubuntu/Programs/tomcat"
export JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=256m -Xms1024m -Xmx2048m"

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force
killall java

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh

