#!/bin/sh

echo "Pulling code from GitHub"
cd ~/Projects/Crowdera
git checkout production
git pull
echo "Building Crowdera project"
grails prod war
echo "Copying Crowdera war to Jetty"
cp ~/Projects/Crowdera/target/Crowdera-0.1.war ~/Programs/jetty/webapps/root.war

echo "Killing running Jetty"
killall java


JETTY_HOME="/home/ubuntu/Programs/jetty"
JAVA_OPTIONS="-XX:MaxPermSize=256m -Xms1024m -Xmx2048m"
NEWRELIC_JAR=$JETTY_HOME/newrelic/newrelic.jar
NEWRELIC_OPTIONS=-javaagent:$NEWRELIC_JAR

# Inform New Relic of a deployment
# curl -H "x-api-key:d9bd0ead04e2cd242884c8009232ecbec39578a118fec0e" -d "deployment[app_name]=Crowdera" https://api.newrelic.com/deployments.xml
#java -jar $NEWRELIC_JAR deployment

echo "Starting Jetty server"
cd $JETTY_HOME
rm nohup.out
# nohup java -jar start.jar &
nohup java $JAVA_OPTIONS $NEWRELIC_OPTIONS -jar start.jar --module=https,deploy &

