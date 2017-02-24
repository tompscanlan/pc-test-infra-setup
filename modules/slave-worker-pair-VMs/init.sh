#!/bin/bash

wget https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar
java -jar swarm-client-3.3.jar -name slave1 -master http://10.126.236.186:8080 -password VMware1! -username abbasia &
