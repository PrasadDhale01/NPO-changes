#!/bin/sh

echo "Pulling code from GitHub"
cd ~/Projects/Crowdera
git checkout production
git pull
echo "Building Crowdera project"
grails test war
echo "Copying Crowdera war to Jetty"
cp ~/Projects/Crowdera/target/Crowdera-0.1.war ~/Programs/jetty/webapps/root.war

echo "Killing running Jetty"
killall java

JETTY_HOME="/home/ubuntu/Programs/jetty"
JAVA_OPTIONS="-XX:MaxPermSize=256m -Xms1024m -Xmx2048m"

echo "Starting Jetty server"
cd $JETTY_HOME
rm nohup.out
nohup java $JAVA_OPTIONS -jar start.jar --module=https,deploy &

