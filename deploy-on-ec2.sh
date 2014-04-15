#!/bin/sh

echo "Pulling code from GitHub"
cd ~/Projects/FEDU
git pull
echo "Building FEDU project"
grails war
cp ~/Projects/FEDU/target/FEDU-0.1.war ~/Programs/jetty/webapps/root.war

echo "Killing running Jetty"
killall java

JETTY_HOME="/home/ubuntu/Programs/jetty"
JAVA_OPTIONS="-XX:MaxPermSize=256m -Xms1024m -Xmx2048m"
NEWRELIC_OPTIONS=-javaagent:$JETTY_HOME/newrelic/newrelic.jar
echo "Starting Jetty server"
cd $JETTY_HOME
rm nohup.out
# nohup java -jar start.jar &
nohup java $JAVA_OPTIONS $NEWRELIC_OPTIONS -jar start.jar --module=https,deploy &

