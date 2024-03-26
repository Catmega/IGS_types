# useful commands
according to https://docs.docker.com/engine/swarm/stack-deploy/
1. deploy: `docker stack deploy --compose-file {{file_name}} {{stack_name}}`
2. remove: `docker stack rm {{stack_name}}`
3. inspect: `docker stack services {{stack_name}}`
4. read logs `docker services logs {{service_id}}`

# possible errors when using ansible to deploy stack
1. 
error: `jsondiff is not installed, try 'pip install jsondiff'`
community.docker.docker_stack module is relied on jsondiff
2. 
error: `"argument 'compose' is of type <class 'dict'> and we were unable to convert to list: <class 'dict'> cannot be converted to a list"`

```yaml
- name: Deploy stack
  community.docker.docker_stack:
    state: present
    name: alfstack
    compose:
      #####correct, list type#######
      - version: '3'
        services:
          web:
            image: nginx:latest
            environment:
              ENVVAR: envvar
      ###############################

      #####wrong, dict type#######
        version: '3'
        services:
            web:
            image: nginx:latest
            environment:
                ENVVAR: envvar
      ###############################
```
3. docker stack only support docker compose version 3.
4. In docker compose version 3, `mem_limit` is decrepted.

# Swarm compared to Kubenetes
## Load balancer
Docker Swarm comes with load balancer automatically.
Kubernetes needs third-party Ingress-managed load balancer.
### Swarm
https://docs.docker.com/engine/swarm/networking/

"The ingress network is a special overlay network that facilitates load balancing among a service's nodes. When any swarm node receives a request on a published port, it hands that request off to a module called IPVS. IPVS keeps track of all the IP addresses participating in that service, selects one of them, and routes the request to it, over the ingress network.

The ingress network is created automatically when you initialize or join a swarm. Most users do not need to customize its configuration, but Docker allows you to do so."

### Kubernetes

https://kubernetes.io/docs/concepts/services-networking/ingress/#prerequisites

"You must have an Ingress controller to satisfy an Ingress. Only creating an Ingress resource has no effect.
You may need to deploy an Ingress controller such as ingress-nginx."

e.g. `ingressClassName: nginx`

## Network
### Swarm
https://docs.docker.com/engine/swarm/networking/

"Overlay networks manage communications among the Docker daemons participating in the swarm. You can attach a service to one or more existing overlay networks, to enable service-to-service communication. Overlay networks are Docker networks that use the overlay network driver."

"The docker_gwbridge is a bridge network that connects the overlay networks (including the ingress network) to an individual Docker daemon's physical network. By default, each container a service is running is connected to its local Docker daemon host's docker_gwbridge network.

The docker_gwbridge network is created automatically when you initialize or join a swarm. Most users do not need to customize its configuration, but Docker allows you to do so."

### Kubernetes
....

# to assign container to specific node
## add node lable
https://docs.docker.com/engine/swarm/manage-nodes/#add-or-remove-label-metadata
`docker node update --label-add {{key}}={{value}} {{node_name}}`
## specify nodes filter in docker compose
https://stackoverflow.com/questions/55265003/does-docker-compose-support-placement-constraints-in-docker-compose-yml

https://docs.docker.com/engine/swarm/services/#placement-constraints

## inspect node's label
`docker node ls -q | xargs docker node inspect -f '{{ .ID }} [hostname={{ .Description.Hostname }}, Addr={{ .Status.Addr }}, State={{ .Status.State }}, Role={{ .Spec.Role }}, Availability={{ .Spec.Availability }}]: Arch={{ .Description.Platform.Architecture }}, OS={{ .Description.Platform.OS }}, NanoCPUs={{ .Description.Resources.NanoCPUs }}, MemoryBytes={{ .Description.Resources.MemoryBytes }}, docker_version={{ .Description.Engine.EngineVersion }}, labels={{ range $k, $v := .Spec.Labels }}{{ $k }}={{ $v }} {{end}}'`

`docker node ls -q | xargs docker node inspect -f '{{ .ID }} [hostname={{ .Description.Hostname }}, Addr={{ .Status.Addr }}, State={{ .Status.State }}, Role={{ .Spec.Role }}, Availability={{ .Spec.Availability }}]: labels={{ range $k, $v := .Spec.Labels }}{{ $k }}={{ $v }} {{end}}'`

error:
"failed to create service alfstack_content-app: Error response from daemon: rpc error: code = Unknown desc = constraint expected one operator from ==, !="
"services.content-app.deploy.placement.constraints must be a list"


error:
"msg": "Failed to update node : 400 Client Error for http+docker://localhost/v1.44/nodes/oyfos5se9uxtl5ch3h6ddgwmo/update?version=55314: Bad Request (\"invalid JSON: json: cannot unmarshal bool into Go struct field NodeSpec.Labels of type string\")"
```yaml
  - name: Merge node labels and new labels
    community.docker.docker_node:
      hostname: "{{ HOST_NAME }}"
      labels:
        {tile: frontend, isNfsClient: true} # throw error
        {tile: frontend, isNfsClient: "true"} # no error

   
```
