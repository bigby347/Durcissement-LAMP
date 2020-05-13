FROM php:7.4.5-apache

COPY config/sites-available /etc/apache2/sites-available
COPY config/conf-available /etc/apache2/conf-available
COPY app /home/dev/app

RUN apt-get update -y && \
    apt-get upgrade -y

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y \
    git \
    nano \
    curl \
    vim

RUN docker-php-ext-install mysqli

EXPOSE 80
EXPOSE 443

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/www/
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN ln -s /home/dev/app /var/www/website

RUN a2ensite 001-website.conf
RUN a2enconf docker-php.conf

WORKDIR /var/www/website