#!/bin/bash

opera notify -e validation_trigger_DockerEngine
opera notify -e validation_trigger_SwarmManager
opera notify -e validation_trigger_SwarmWorker
opera notify -e validation_trigger_Postgres
# opera notify -e validation_trigger_Solr
opera notify -e validation_trigger_NFSServer
opera notify -e validation_trigger_scaleOut_PostgresCluster
cat /home/ubuntu/opera-root/git-project/IGS_types/validation.log




















# ### 1.1 test if docker engine is running ###########
# docker_engine_success=false
# if curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null
# then
#   echo "Docker Enginee is Running."
# else
#   echo "Docker Enginee is Not running."
# fi

# ### 1.2 test if docker container can be created ###########
# run the hello-world image
# if docker run hello-worldt &> /dev/null; then
#     echo "Success! Docker container creation is functioning well."
# else
#     echo "Failure! Docker container creation is NOT functioning well."
# fi



### 2. test if swarm manager is running ###########
# swarm_manager_success=false

# # use "docker info" to get the swarm status
# swarm_status=$(docker info --format '{{.Swarm.LocalNodeState}}')

# if [ "$swarm_status" = "active" ]; then
#     # "docker node ls" can only bu executed in manager
#     if docker node ls &> /dev/null; then
#         echo "Success! This node has been initialized as Swarm Manager"
#         swarm_manager_success=true
#     else
#         echo "Failure! This node has FAILED to initialize as Swarm Manager"
#     fi
# else
#     echo "Failure! This node is not a Swarm instance"
# fi

# #!/bin/bash
# ## test if swarm worker is running ########### 
# echo "########### Validating the Swarm Worker status ###########"
# swarm_worker_success=false
# ip_addr=$(ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+')
# echo "on machine $ip_addr:"
# # use "docker info" to get the swarm status
# swarm_status=$(docker info --format '{{.Swarm.LocalNodeState}}')

# if [ "$swarm_status" = "active" ]; then
#     # "docker node ls" can only bu executed in manager
#     if docker node ls &> /dev/null; then
#         echo "Failure! This node has FAILED to initialize as Swarm Worker"
#     else
#         echo "Success! This node has been initialized as Swarm Worker"
#         swarm_worker_success=true
#     fi
# else
#     echo "Failure! This node is not a Swarm instance"
# fi

### 3. test if NFS Server is running ########### 