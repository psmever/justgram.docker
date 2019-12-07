FROM ubuntu:latest
LABEL maintainer="psmever <psmever@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=C.UTF-8

ARG LARAVEL_ENV_FILE
ARG OS_LOCALE
ARG APACHE_CONF_DIR

ENV TZ=Asia/Seoul
ENV APACHE_CONF_DIR=/etc/apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
EXPOSE 43380
EXPOSE 9000

ADD ./config/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD ./config/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

RUN apt-get update
# System.. apt install
RUN apt-get install -y \
    apt-utils \
    language-pack-ko \
    tzdata \
    net-tools \
    curl \
    vim \
    iputils-ping \
    unzip

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN locale-gen ko_KR.UTF-8
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

# Developer apt install
RUN apt-get install -y \
    git \
    apache2 \
    mariadb-client \
    php7.4 \
    php7.4-common \
    php7.4-cli \
    libphp7.4-embed \
    php7.4-xdebug \
    php7.4-bz2 \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-curl \
    php7.4-xml \
    php7.4-gd \
    php7.4-mysql

RUN a2enmod rewrite headers
RUN a2enmod php7.4
RUN chown -R www-data:www-data /var/www

RUN mkdir -p $APACHE_RUN_DIR
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR

RUN mv ${APACHE_CONF_DIR}/apache2.conf ${APACHE_CONF_DIR}/bak_apache2.conf
RUN mv ${APACHE_CONF_DIR}/sites-available/000-default.conf ${APACHE_CONF_DIR}/sites-available/bak_000-default.conf
RUN mv ${APACHE_CONF_DIR}/ports.conf ${APACHE_CONF_DIR}/bak_ports.conf
RUN /bin/bash /usr/local/bin/entrypoint.sh
RUN touch /var/log/xdebug.log
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN git clone https://github.com/psmever/justgram.backend.git /var/www/justgram
RUN mkdir -p /var/www/justgram && cd /var/www/justgram && composer install

COPY ./config/apache2.conf ${APACHE_CONF_DIR}/apache2.conf
COPY ./config/000-default.conf ${APACHE_CONF_DIR}/sites-available/000-default.conf
COPY ./config/ports.conf ${APACHE_CONF_DIR}/ports.conf


COPY ./.laravel_env /var/www/justgram/.env

# RUN cd /var/www/justgram && php artisan passport:keys && php artisan optimize && composer dump-autoload && php artisan config:clear

RUN chown -R www-data:www-data /var/www/*

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*