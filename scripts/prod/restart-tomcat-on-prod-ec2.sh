#!/bin/sh

NEWRELIC_HOME="/home/ubuntu/newrelic"
NEWRELIC_JAR=$NEWRELIC_HOME/newrelic.jar
NEWRELIC_OPTS=-javaagent:$NEWRELIC_JAR
TOMCAT_HOME="/home/ubuntu/Programs/tomcat"
CROWDERA_HOME="/home/ubuntu/Projects/Crowdera"
CATALINA_OPTS="-d64 -Xms2048M -Xmx2048M -XX:NewSize=1024m -XX:MaxNewSize=1024m -XX:PermSize=1024m -XX:MaxPermSize=1024m -XX:+DisableExplicitGC"
export CATALINA_OPTS="$CATALINA_OPTS $NEWRELIC_OPTS"

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force
killall java

rm -rf $TOMCAT_HOME/webapps/ROOT
cp $CROWDERA_HOME/target/Crowdera-0.1.war $TOMCAT_HOME/webapps/ROOT.war

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh

