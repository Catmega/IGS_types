
# Installation
make sure you have setup Python 3 in your machine
```console
$ mkdir ~/{{your_working_directory}} && cd ~/{{your_working_directory}}
$ python3 -m venv .venv && . .venv/bin/activate
(.venv) $ pip install opera==0.6.9
```
If you run into error with pip install opera, try 
```pip install pyyaml==5.3.1```, also, check the following packages to see if they are of valid version:
```
setuptools_scm >= 6.4.2
install_requires =
ansible-core >= 2.13.4
pyyaml <= 5.4.1
shtab >= 1.5.5
```
For more reference: https://github.com/xlab-si/xopera-opera
# Deployment
To deploy the Alfresco service template
``` console
$ git clone https://gitlab-as.informatik.uni-stuttgart.de/megaco/ma-jingyue2023.git
$ cd ma-jingyue2023/templates/alfresco
$ sudo su # to get root privileges to run Ansible
$ . .venv/bin/activate # change to the virtual environment of Xopera
(.venv) $ export OPERA_SSH_USER=root  # set the env var
(.venv) $ opera deploy service.yaml # deploy
```

when you see outputs like this, the services has been fully deployed:
```
[Worker_0]   Deploying my-workstation_0
[Worker_0]   Deployment of my-workstation_0 complete
[Worker_0]   Deploying ActiveMQ_0
[Worker_0]     Executing create on ActiveMQ_0
[Worker_0]   Deployment of ActiveMQ_0 complete
[Worker_0]   Deploying Share_0
[Worker_0]     Executing create on Share_0
[Worker_0]   Deployment of Share_0 complete
[Worker_0]   Deploying TransformCore_0
[Worker_0]     Executing create on TransformCore_0
[Worker_0]   Deployment of TransformCore_0 complete
[Worker_0]   Deploying ControlCenter_0
[Worker_0]     Executing create on ControlCenter_0
[Worker_0]   Deployment of ControlCenter_0 complete
[Worker_0]   Deploying ContentApp_0
[Worker_0]     Executing create on ContentApp_0
[Worker_0]   Deployment of ContentApp_0 complete
[Worker_0]   Deploying Solr_0
[Worker_0]     Executing create on Solr_0
[Worker_0]   Deployment of Solr_0 complete
[Worker_0]   Deploying Postgres_0
[Worker_0]     Executing create on Postgres_0
[Worker_0]   Deployment of Postgres_0 complete
[Worker_0]   Deploying Alfresco_0
[Worker_0]     Executing create on Alfresco_0
[Worker_0]   Deployment of Alfresco_0 complete
[Worker_0]   Deploying Proxy_0
[Worker_0]     Executing create on Proxy_0
[Worker_0]   Deployment of Proxy_0 complete
```
If you modified some code after the deployment, the command for re-deploying from the start is:
```console
(.venv) $ opera deploy -i inputs.yaml service.yaml -c
```
You can find the **topology_template** in _service.yaml_, and the **node_type** definition in the _lib_ directory.
# Undeployment
To delete the created directory:

```console
(.venv) $ opera undeploy
$ docker stop $(docker ps -a | grep "alfresco" | awk '{print $1}') # to stop all containers with name starting with "alfresco"; currently still need to manually stop the containers because the undeploy implementation hasn't been done yet
```