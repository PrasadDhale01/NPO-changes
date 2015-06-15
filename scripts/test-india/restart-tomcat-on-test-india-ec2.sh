#!/bin/sh

TOMCAT_HOME="/home/ubuntu/Programs/tomcat"
CATALINA_OPTS="-d64 -Xms2048M -Xmx2048M -XX:NewSize=1024m -XX:MaxNewSize=1024m -XX:PermSize=1024m -XX:MaxPermSize=1024m -XX:+DisableExplicitGC"
export CATALINA_OPTS

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force
killall java

rm -rf $TOMCAT_HOME/logs/*

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh

