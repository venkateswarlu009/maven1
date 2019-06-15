#!/bin/bash

cd /var/lib/jenkins/workspace/maven/
chmod 777 release.sh
./release.sh 19.09
