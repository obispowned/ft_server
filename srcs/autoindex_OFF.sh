rm /etc/nginx/sites-enabled/myconf.nginx.conf
ln -s /etc/nginx/sites-available/myconf.off.nginx.conf /etc/nginx/sites-enabled/
mv /tmp/index.html /var/www/html/
service nginx restart
