# Make new image from debian buster version
FROM debian:buster

# Update apt
RUN apt-get update \
&& apt-get upgrade -y

# Install NGINX
RUN apt-get -y install nginx

# Install MySQL
RUN apt-get -y install mariadb-server

# Istall PHP
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline

# Install Tools
RUN apt-get -y install wget

# Install Openssl
RUN apt-get -y install openssl

COPY ./srcs/start.sh ./
COPY ./srcs/nginx.config ./
COPY ./srcs/config.inc.php ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/autoindexoff.sh ./
COPY ./srcs/autoindexon.sh ./

CMD bash ./start.sh
