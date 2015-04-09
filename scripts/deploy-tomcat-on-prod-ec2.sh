#!/bin/sh

NEWRELIC_HOME="/home/ubuntu/newrelic"
NEWRELIC_JAR=$NEWRELIC_HOME/newrelic.jar
NEWRELIC_OPTS=-javaagent:$NEWRELIC_JAR
TOMCAT_HOME="/home/ubuntu/Programs/tomcat"
CROWDERA_HOME="/home/ubuntu/Projects/Crowdera"
export JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=256m -Xms1024m -Xmx2048m $NEWRELIC_OPTS"


echo "Pulling code from GitHub"
cd $CROWDERA_HOME
git checkout production
git pull
echo "Building Crowdera project"
grails prod war

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force

rm -rf $TOMCAT_HOME/webapps/ROOT
cp $CROWDERA_HOME/target/Crowdera-0.1.war $TOMCAT_HOME/webapps/ROOT.war

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh
