# Reference:
# https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.0/html-single/using_the_red_hat_jboss_enterprise_application_platform_docker_image/

FROM alpine:latest
MAINTAINER Candido Tominaga <candido1212@gmail.com>
LABEL Description="Lightweight JBOSS EAP Server docker container installed on Alpine Linux"

ENV LANG C.UTF-8

# update system (Alpine Linux)
RUN apk update && apk upgrade

RUN apk add bash curl

RUN rm -r /var/cache/apk/*

# Now, install openJDK
# See: https://github.com/docker-library/openjdk
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u131
ENV JAVA_ALPINE_VERSION 8.131.11-r2

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

RUN adduser -h /home/jboss -u 1000 -D jboss

ENV EAP_VERSION 6.4
ENV EAP_HOME /home/jboss
ENV EAP_CP_USER admin
ENV EAP_CP_PASS admin@@admin

# Download EAP
# https://github.com/candido1212/eap/archive/eap-6.4.zip
RUN curl -L https://github.com/candido1212/eap/archive/${EAP_VERSION}.zip --output eap.zip
RUN unzip eap.zip && rm -f eap.zip
RUN mv -f /eap-${EAP_VERSION}/jboss-eap/* ${EAP_HOME} && rm -fr /eap-${EAP_VERSION}

RUN chmod +x ${EAP_HOME}/bin/*.sh

# Add a user in administration realm
#RUN sh ${EAP_HOME}/bin/add-user.sh ${EAP_CP_USER} ${EAP_CP_PASS} --silent

# volume mappings
VOLUME ${EAP_HOME}/standalone/deployments ${EAP_HOME}/standalone/log

RUN ln -sf ${EAP_HOME}/standalone/deployments /deployments && ln -sf ${EAP_HOME}/standalone/log /logs
RUN chmod 777 ${EAP_HOME}/standalone/log

RUN chown -R jboss ${EAP_HOME}

# Expose ports
EXPOSE 8080 9990

#USER jboss

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
#CMD [${EAP_HOME}/bin/standalone.sh, "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

# start JBoss
#ENTRYPOINT $JBOSS_HOME/bin/standalone.sh -c standalone.xml