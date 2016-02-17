
FROM ubuntu:trusty

RUN apt-get update && apt-get install -y tomcat6 wget unzip nano
RUN apt-get clean

ADD install-solr.sh /install-solr.sh
RUN chmod +x /install-solr.sh
RUN /install-solr.sh ; exit 0

RUN sed -i "s/\[localhost\]\.level = INFO/\[localhost\]\.level = WARNING/g" /var/lib/tomcat6/conf/logging.properties
RUN echo ".level = WARNING" >> /var/lib/tomcat6/conf/logging.properties

ADD run.sh /run.sh
RUN rm -R /opt/solr-tomcat/solr/solr-4.8.1/*
COPY pfad/zu/solr/daten /opt/solr-tomcat/solr/solr-4.8.1/
RUN chmod -R 775 /opt/solr-tomcat/solr/solr-4.8.1/
RUN chmod +x /run.sh

ENV TERM xterm

EXPOSE 8080
CMD ["/run.sh"]
