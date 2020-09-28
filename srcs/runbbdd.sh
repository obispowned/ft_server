#!/usr/bin/env bash

service php7.3-fpm start
service mysql start
service nginx start

echo "CREATE DATABASE wordpress" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';" | mysql -u root
mysql -u root
mysql wordpress -u root --password= < /tmp/wordpress.sql
mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql

echo "AGUTIERR -- FT_SERVER -- AGUTIERR"

bash
