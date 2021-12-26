#!/bin/bash

#Shell script to build jar file

version=$(sed -n 's/^ *"version" *: *//p' openapi.yaml | grep -oP '"\K[^"]+')

mkdir $version

#sudo npm install @openapitools/openapi-generator-cli -g
#sudo openapi-generator-cli version-manager set 5.3.0
#sudo npm install @openapitools/openapi-generator-cli -D

cp openapi.yaml $version/

openapi-generator-cli generate -g spring -i $version/openapi.yaml -c config.json -o spring-boot-codegenerator

cd spring-boot-codegenerator

mvn clean test compile package


#rl -vSf -u "admin:password" -X PUT -T target/spring-boot-codegenerator-1.0.0.jar 'http://192.168.1.67:8082/artifactory/artifactsjar/spring-boot-codegenerator-1.0.0.jar'

curl -vSf -u "admin:password" -X PUT -T "target/spring-boot-codegenerator-$version.jar" "http://192.168.1.67:8082/artifactory/artifactsjar/spring-boot-codegenerator-$version.jar"
