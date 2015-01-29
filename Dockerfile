FROM debian:wheezy

# Install basic required tools
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  wget \
  zip \
  openjdk-7-jdk \
  ant

# Install PHP5 and PHP QA Tols
COPY php-qa.sh /usr/local/bin/php-qa.sh

RUN echo "deb http://packages.dotdeb.org wheezy-php56 all" > /etc/apt/sources.list.d/dotdeb.list && curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update && apt-get install -y \
  php5-cli \
  php5-fpm \
  php5-dev \
  php5-mysql \
  php5-mcrypt \
  php5-gd \
  php5-curl \
  php-pear \
  && php-qa.sh

RUN rm -rf /var/lib/apt/lists/* 

ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-angent-port.groovy

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war -o /usr/share/jenkins/jenkins.war

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

USER jenkins
COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

# When building an image, copy plugins.sh and pluginslist.sh to the container directory
# Then run plugins.sh and pluginslist.txt as a parameter to download the latest plugin version specified in the pluginslist.txt
COPY plugins.sh /usr/local/bin/plugins.sh
COPY pluginslist.txt $JENKINS_HOME/pluginslist.txt
RUN plugins.sh $JENKINS_HOME/pluginslist.txt
