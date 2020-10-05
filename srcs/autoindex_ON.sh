rm /etc/nginx/sites-enabled/myconf.off.nginx.conf
ln -s /etc/nginx/sites-available/myconf.nginx.conf /etc/nginx/sites-enabled/
service nginx restart
