FROM debian:buster

	#metadata input
MAINTAINER agutierr <agutierr@student.42madrid.com>


RUN mkdir /turnoff	
	#Actualizacion e instalacion de utilidades
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install apt-utils -y
RUN apt-get install -y wget
RUN apt-get install -y vim 

	#instalacion de nginx y configuracion
RUN apt-get install -y nginx
RUN rm /etc/nginx/sites-enabled/default
COPY /srcs/myconf.nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/myconf.nginx.conf /etc/nginx/sites-enabled/
RUN rm /var/www/html/*.html
COPY /srcs/home.html /var/www/html/

	#instalacion de protocoloSSL, permiso y acceso
RUN apt-get install -y openssl
RUN openssl genrsa -out /etc/ssl/private/nginx.key 4096
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42Madrid/CN=127.0.0.1" -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 775 /var/www/*

CMD service nginx start && bash

EXPOSE 80 443
