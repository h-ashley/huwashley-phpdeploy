FROM ubuntu:18.04
MAINTAINER Huw Ashley <huw@altusitservices.com>

RUN apt-get -qq update && apt-get -qq install git wget libssl-dev build-essential software-properties-common
RUN add-apt-repository ppa:git-ftp/ppa && apt-get update && apt-get -qq install git-ftp
RUN wget https://www.libssh2.org/download/libssh2-1.8.0.tar.gz
RUN tar -xvzf libssh2-1.8.0.tar.gz
RUN cd libssh2-1.8.0 && ./configure && make && make install
RUN wget https://curl.haxx.se/download/curl-7.54.0.tar.bz2
RUN tar -xvjf curl-7.54.0.tar.bz2
RUN cd curl-7.54.0 && ./configure --with-libssh2=/usr/local && make && make install
RUN ldconfig

RUN apt-get update
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -yq php-cli php-mbstring php-xml php-zip php-soap
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y npm
RUN npm install --global cross-env

RUN mkdir -p ~/.ssh

