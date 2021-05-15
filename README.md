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
add to file /etc/docker/daemon.json
{
  "ipv6": true,
  "fixed-cidr-v6": "ffff:ffff:ffff:100::/64",
  "dns": ["8.8.4.4","8.8.8.8"],
  "ip-forward": true
}
```


The system is accessible from: https://<YOUR_SERVER_IP>:6080
