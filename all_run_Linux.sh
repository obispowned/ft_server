sudo docker build -t img_con /home/obis/Escritorio/ft_server
sudo docker run -it -p 80:80 -p 443:443 --name container img_con
