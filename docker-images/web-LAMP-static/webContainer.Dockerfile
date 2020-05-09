FROM php:7.4.5-apache

RUN apt-get update -y && \
    apt-get upgrade -y
