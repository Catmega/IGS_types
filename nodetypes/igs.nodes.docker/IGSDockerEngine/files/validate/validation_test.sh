#!/bin/bash
### 1.1 test if docker engine is running ###########
echo "######## Docker Enginee validation ########"
ip_addr=$(ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+')
echo "on machine $ip_addr:"
docker_engine_success=false
if curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null
then
  echo "Docker Enginee is Running."
else
  echo "Docker Enginee is Not running."
fi

### 1.2 test if docker container can be created ###########
run the hello-world image
if docker run hello-world &> /dev/null; then
    echo "Success! Docker container creation is functioning well."
else
    echo "Failure! Docker container creation is NOT functioning well."
fi
