### Build
```
git clone https://github.com/gnurlan/Docker-noVNC.git
cd Docker-noVNC
docker build -t imagename .
```  

### Run
```
docker run -id -v ~/hostFolder:/root/dockFolder -p 6080:6080 -e VNC_PASSWD=<YourPassword> --cap-add=NET_ADMIN --name ContainerName imagename
```  


### ipv6
```
add to file /etc/default/docker
DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 --ipv6 --fixed-cidr-v6=someIpv6/80"
```


The system is accessible from: https://<YOUR_SERVER_IP>:6080
