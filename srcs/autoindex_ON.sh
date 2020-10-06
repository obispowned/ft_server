rm /etc/nginx/sites-enabled/myconf.off.nginx.conf
ln -s /etc/nginx/sites-available/myconf.nginx.conf /etc/nginx/sites-enabled/
mv /var/www/html/index.html /tmp
service nginx restart
