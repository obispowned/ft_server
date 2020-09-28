docker build -t img_con /Users/agutierr/Desktop/ft_server/
docker run -it -p 80:80 -p 443:443 --name container img_con
