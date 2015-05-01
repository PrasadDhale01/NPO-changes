#!/bin/sh

TOMCAT_HOME="/home/ubuntu/Programs/tomcat"

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force
killall java

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh

