FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        nano \
        curl

RUN apt-get install -y apache2
RUN apt-get install -y fail2ban
RUN apt-get install -y libapache2-mod-evasive
RUN apt-get install -y libapache2-mod-security2

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/www/html
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80
EXPOSE 443

COPY config/ /etc/apache2

RUN a2enmod evasive security2 proxy proxy_http

#active 001-reverse-proxy.conf
RUN a2ensite 001-reverse-proxy.conf

CMD /usr/sbin/apache2ctl -D FOREGROUND 

