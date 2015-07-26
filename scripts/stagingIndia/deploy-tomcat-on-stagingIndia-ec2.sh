#!/bin/sh

TOMCAT_HOME="/home/ubuntu/Programs/tomcat"
CROWDERA_HOME="/home/ubuntu/Projects/Crowdera"
CATALINA_OPTS="-d64 -Xms2048M -Xmx2048M -XX:NewSize=1024m -XX:MaxNewSize=1024m -XX:PermSize=1024m -XX:MaxPermSize=1024m -XX:+DisableExplicitGC"
export CATALINA_OPTS

echo "Pulling code from GitHub"
cd $CROWDERA_HOME
git checkout production
git pull
echo "Building Crowdera project"
grails -Dgrails.env=stagingIndia war

echo "Stop tomcat"
cd $TOMCAT_HOME
./bin/catalina.sh stop -force
killall java

rm -rf $TOMCAT_HOME/logs/*
rm -rf $TOMCAT_HOME/webapps/ROOT
cp $CROWDERA_HOME/target/Crowdera-0.1.war $TOMCAT_HOME/webapps/ROOT.war

echo "Starting tomcat server"
cd $TOMCAT_HOME
./bin/startup.sh
