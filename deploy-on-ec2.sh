#!/bin/sh

echo "Killing running Jetty"
killall java

echo "Pulling code from GitHub"
cd ~/Projects/FEDU
git pull
echo "Building FEDU project"
grails war
cp ~/Projects/FEDU/target/FEDU-0.1.war ~/Programs/jetty/webapps/root.war

echo "Starting Jetty server"
cd ~/Programs/jetty
rm nohup.out
# nohup java -jar start.jar &
nohup java -jar start.jar --module=https,deploy &
