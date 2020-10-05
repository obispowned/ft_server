rm /etc/nginx/sites-enabled/myconf.nginx.conf
ln -s /etc/nginx/sites-available/myconf.off.nginx.conf /etc/nginx/sites-enabled/
service nginx restart
