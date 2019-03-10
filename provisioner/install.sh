#!/bin/sh

##variable
dir_name="tomcat9"

##Step01: Install Java Vesrsion 8
echo "--------------------------------------------------------INSTALLING JAVA-----------------------------------------------------------"
#sudo yum install java-1.8.0-openjdk

##Step02: Install Apache Tomcat 9
echo "----------------------------------------------------INSTALLING APACHE TOMCAT-------------------------------------------------------"
#sudo yum install wget
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.0.M10/bin/apache-tomcat-9.0.0.M10.tar.gz
tar xzf apache-tomcat-9.0.0.M10.tar.gz
#mkdir tomcat9
if [ -d "$dir_name" ] 
then
    echo "Directory ${dir_name} already exists." 
else
    echo "Dierectory does not exists, hence create a direcotory with name ${dir_name} . "
    mkdir /tmp/"$dir_name"
fi
mv apache-tomcat-9.0.0.M10 tomcat9
cat /dev/null > /tmp/tomcat9/apache-tomcat-9.0.0.M10/conf/tomcat-users.xml
cp ./provisioner/user.txt tomcat9/apache-tomcat-9.0.0.M10/conf/tomcat-users.xml

echo "User details are updated...... Restart tomcat9........ "

echo "--------------------------------------------------------INSTALLING JENKINS--------------------------------------------------------"
wget http://updates.jenkins-ci.org/download/war/2.7.3/jenkins.war
java -jar jenkins.war
