FROM bitnami/minideb:latest
MAINTAINER Candido Tominaga <candido1212@gmail.com>
LABEL Description="Lightweight JBOSS EAP Server docker container installed on Debian MINI"

#ENV LANG UTF-8

RUN apt-get update && apt-get install -y unzip curl openjdk-8-jdk-headless

RUN adduser --disabled-password --home /home/jboss -uid 1000 --add_extra_groups jboss
ENV EAP_VERSION 6.4
ENV EAP_HOME /home/jboss
ENV EAP_CP_USER admin
ENV EAP_CP_PASS admin@@admin
ENV AMBIENTE_UPP LOCAL
ENV SIGLA_APP_UPP PIC
ENV SIGLA_APP_LOW pic

ENV DS_NOME_JNDI	aaa-ds
ENV DS_POOL_NAME	aaa
ENV DS_HOST	dbmira
ENV DS_PORTA	1521
ENV DS_INSTANCIA mira
ENV DS_POOL_MIN	1
ENV DS_POOL_MAX	5
ENV DS_USUARIO aaa
ENV DS_SENHA bbb

# Download EAP
# https://github.com/candido1212/eap/archive/eap-6.4.zip
# RUN curl -L https://github.com/candido1212/eap/archive/${EAP_VERSION}.zip --output ${EAP_VERSION}.zip
COPY 6.4.zip /
RUN unzip ${EAP_VERSION}.zip && rm -f ${EAP_VERSION}.zip
RUN mv -f /eap-${EAP_VERSION}/jboss-eap/* ${EAP_HOME} && rm -fr /eap-${EAP_VERSION}

RUN chmod +x ${EAP_HOME}/bin/*.sh
#COPY standalone.xml ${EAP_HOME}/standalone/configuration/standalone.xml

# Add a user in administration realm
#RUN sh ${EAP_HOME}/bin/add-user.sh ${EAP_CP_USER} ${EAP_CP_PASS} --silent

RUN mkdir -p ${EAP_HOME}/modules/system/layers/base/com/copel /resources

# volume mappings
VOLUME ${EAP_HOME}/standalone/deployments ${EAP_HOME}/standalone/log \
	 ${EAP_HOME}/standalone/configuration \
	 ${EAP_HOME}/modules/system/layers/base/com/copel \
	 /resources


RUN ln -sf ${EAP_HOME}/standalone/deployments /deployments && ln -sf ${EAP_HOME}/standalone/log /logs
RUN chmod 777 ${EAP_HOME}/standalone/log

RUN chown -R jboss ${EAP_HOME}

# Expose ports
EXPOSE 8080 9990

#USER jboss

# start JBoss
ENTRYPOINT $EAP_HOME/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0




