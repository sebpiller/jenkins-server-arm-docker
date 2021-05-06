FROM debian:buster
LABEL arch="arm|arm64"
ENV DEBIAN_FRONTEND=noninteractive

ARG tcversion=9.0.45
ARG jenkinsversion=2.291

ARG tomcat=https://downloads.apache.org/tomcat/tomcat-9/v$tcversion/bin/apache-tomcat-$tcversion.tar.gz
ARG jenkins=https://get.jenkins.io/war/$jenkinsversion/jenkins.war

ADD $tomcat .
ADD $jenkins .

RUN \
    ls -lah && \
    tar -xvzf apache-tomcat-$tcversion.tar.gz && \
    mv apache-tomcat-$tcversion /tomcat && \
    rm -rf /tomcat/webapps/* && \
    mv jenkins.war /tomcat/webapps/ROOT.war && \
    rm -rf /tmp/*

COPY ./default-start.sh /default-start.sh
RUN chmod +x /default-start.sh

CMD [ "/bin/sh", "-c", "/default-start.sh && sleep infinity" ]