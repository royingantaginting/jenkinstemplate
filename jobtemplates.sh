#!/bin/bash

# Install PHP Job Template
JOBDIR=/usr/share/jenkins/ref/jobs/php-template
mkdir -p $JOBDIR
wget https://raw.github.com/sebastianbergmann/php-jenkins-template/master/config.xml -O $JOBDIR/config.xml
chown -R jenkins:jenkins $JOBDIR
