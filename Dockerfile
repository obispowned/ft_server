FROM debian:buster

	#metadata input
MAINTAINER agutierr <agutierr@student.42madrid.com>

	#Folders
WORKDIR /tmp
COPY srcs/config.inc.php ./
COPY srcs/wp-config.php ./
COPY srcs/myconf.nginx.conf ./
COPY srcs/runbbdd.sh ./


RUN mkdir /turnoff	

	#Actualizacion e instalacion de utilidades
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install apt-utils -y
RUN apt-get install -y wget
RUN apt-get install -y unzip zip
RUN apt-get install -y vim 

	#instalacion php
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php7.3-curl php7.3-mbstring 

	#instalacion de nginx y configuracion
RUN apt-get install -y nginx
RUN rm /etc/nginx/sites-enabled/default
RUN mv /tmp/myconf.nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/myconf.nginx.conf /etc/nginx/sites-enabled/
RUN rm /var/www/html/*.html
COPY /srcs/info.php /var/www/html/
COPY /srcs/home.html /var/www/html/


	#instalacion de protocoloSSL, permiso y acceso
RUN apt-get install -y openssl
RUN openssl genrsa -out /etc/ssl/private/nginx.key 4096
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42Madrid/CN=127.0.0.1" -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 775 /var/www/*

	#mysql mariadb
RUN apt-get install -y mariadb-server


	#wordpress y permisos
RUN wget -c https://wordpress.org/latest.tar.gz && tar xvzf *.tar.gz && mv wordpress /var/www/html/
RUN tar xvzf *.tar.gz
RUN rm *.tar.gz
RUN chown -R www-data.www-data -R /var/www/html/wordpress/*
RUN mv /tmp/wp-config.php /var/www/html/wordpress/
	
	#phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.zip && unzip *.zip && mv phpMyAdmin-5.0.2-all-languages /var/www/html/
RUN rm *.zip
RUN mv /var/www/html/phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
RUN mv /tmp/config.inc.php /var/www/html/phpmyadmin/
RUN chmod 775 -R /var/www/html/phpmyadmin && chown -R www-data:www-data /var/www/html/phpmyadmin

EXPOSE 80 443

CMD bash 
ENTRYPOINT ["/bin/sh", "/tmp/runbbdd.sh", "/bin/sh"]
