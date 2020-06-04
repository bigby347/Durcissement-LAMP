FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        nano \
        curl \
        vim

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

COPY config/sites-available /etc/apache2/sites-available
COPY config/conf-available /etc/apache2/conf-available
COPY config/fail2ban/filter.d /etc/fail2ban/filter.d
COPY config/fail2ban/jail.local /etc/fail2ban/
COPY Regles_Security_et_Evasive.sh /usr/local/bin/
COPY Test.pl /usr/share/doc/libapache2-mod-evasive/examples/


RUN a2enmod evasive security2 proxy proxy_http
RUN service apache2 restart

#active les différentes configurations 
RUN a2ensite 001-web-app1.conf
RUN a2ensite 002-dvwa-app.conf

RUN chmod +x /usr/local/bin/Regles_Security_et_Evasive.sh
RUN /usr/local/bin/Regles_Security_et_Evasive.sh

CMD /usr/sbin/apache2ctl -D FOREGROUND

