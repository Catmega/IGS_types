# Alfresco IG Solution

## cloud platform related 
<!-- 
## Node-template: Cloud Platform Service
has capability to create Node-Resources like (Compute, Network, Storage)
### Node-template: OpenStack Cloud Platform Service
has capability via API to create
1..* Compute.Node Ubuntu.Compute ( num cpu, mem, ip addr )
1..* Virtual.Network linked to Ubuntu.Compute artifact ubuntu image version 22.04
1..* Nfs.Volume attached to Ubuntu.Compute

(haven't done yet) -->
### abstact Node-template:   igs.nodes.abstract.OSInstance:
derived_from: tosca.nodes.Compute

(requires a cloudPlatform: ......)

provides an abstract template for OS node services;

## container related 
### abstact Node-template:   igs.nodes.abstract.ContainerRuntime:
derived_from: tosca.nodes.Container.Runtime (<-tosca.nodesSoftwareComponent)

requires a host: igs.nodes.abstract.OSInstance

provides an abstract template for container runtime services        

### abstact Node-template: igs.nodes.abstract.ContainerApplication:
derived_from: tosca.nodes.Container.Runtime (<-tosca.nodesSoftwareComponent)

requires a host: igs.nodes.abstract.ContainerRuntime

requires a network: tosca.capabilities.Endpoint

provides an abstract template for container runtime services  

### concret Node-template: igs.nodes.docker.DockerEngine
derived_from: igs.nodes.abstract.ContainerRuntime

implicitly(inheritively) requires a host: igs.nodes.abstract.OSInstance

provides docker container runtime services

provides docker swarm cluster services

implements artifact ansible playbook: docker installation & configuration for Debian OS family (e.g. Ubuntu)

### concret Node-template: igs.nodes.docker.DockerApplication
derived_from: igs.nodes.abstract.ContainerRuntime

requires a host: igs.nodes.abstract.OSInstance

implicitly(inheritively) requires a network: with capability : tosca.capabilities.Endpoint

implicitly(inheritively) requires a storage: with capability : tosca.capabilities.Storage

provides docker container application virtulization services
needs concret app to further implements artifact ansible playbook: start the app according to images

## cluster related
### abstract Node-template: igs.nodes.abstract.ClusterNode
derived_from: tosca.nodes.Compute  

`“The TOSCA Compute node represents one or more real or virtual processors of software applications or services along with other essential local resources.  Collectively, the resources the compute node represents can logically be viewed as a (real or virtual) “server”.”` 

requires a runtimeHost: igs.nodes.abstract.ContainerRuntime

provides an abstract template for a virtual node inside of a cluster  
### abstract Node-template: igs.nodes.abstract.ClusterManager
derived_from: igs.nodes.abstract.ClusterNode

implicitly(inheritively) requires a runtimeHost: igs.nodes.abstract.ContainerRuntime

provides an abstract template for a virtual node inside of a cluster, whose role is a manager
### abstract Node-template: igs.nodes.abstract.ClusterWorker
derived_from: igs.nodes.abstract.ClusterNode

implicitly(inheritively) requires a runtimeHost: igs.nodes.abstract.ContainerRuntime

requires a manager: igs.nodes.abstract.ClusterManager

provides an abstract template for a virtual node inside of a cluster, whose role is a worker
### concret Node-template: igs.nodes.Swarm.Manager
derived_from: igs.nodes.abstract.ClusterManager

implicitly(inheritively) requires a runtimeHost: igs.nodes.abstract.ContainerRuntime

provides Docker Swarm manager services

implements artifact ansible playbook: initialize swarm & retrieve join token & add customized labels
### concret Node-template: igs.nodes.Swarm.Worker
provides Docker Swarm worker services

implicitly(inheritively) requires a runtimeHost: igs.nodes.abstract.ContainerRuntime

implicitly(inheritively)  requires a manager: igs.nodes.abstract.ClusterManager

implements artifact ansible playbook: use retrieved token to join the cluster & add customized labels
### concret Node-template: igs.nodes.K8S.Manager
to be added ...
### concret Node-template: igs.nodes.K8S.Worker
to be added ...