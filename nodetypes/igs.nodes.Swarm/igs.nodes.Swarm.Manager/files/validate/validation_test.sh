#!/bin/bash
swarm_manager_success=false
echo "########### Validating the Swarm Manager status ###########"
# use "docker info" to get the swarm status
swarm_status=$(docker info --format '{{.Swarm.LocalNodeState}}')

if [ "$swarm_status" = "active" ]; then
    # "docker node ls" can only bu executed in manager
    if docker node ls &> /dev/null; then
        echo "Success! This node has been initialized as Swarm Manager"
        swarm_manager_success=true
    else
        echo "Failure! This node has FAILED to initialize as Swarm Manager"
    fi
else
    echo "Failure! This node is not a Swarm instance"
fi