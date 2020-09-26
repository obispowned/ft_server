sudo docker rm -f $(sudo docker ps -qa)
sudo docker rmi -f $(sudo docker images -qa)
