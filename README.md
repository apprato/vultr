# VULTR
Utility scripts to setup VULTR


## Setup
We install git, tmux, vim and initialise the sytem to run our bash script
cd /usr/local/src
yum install git, tmux, vim


## Install System user and docker
This will install a system user and docker
Clone out the repo and cd into the directory
sh tool.sh setupSystemUserAndDocker

## Install docker-compose
Clone out the repo and cd into the directory
sh tools.sh installDockerCompose 

## Install System user, docker and docker-compose
You can run this directly from GIT 
bash <(curl -sSL https://raw.githubusercontent.com/magescale/vultr/master/tools.sh) setupSystemUserDockerAndDockerCompose

## Ensure docker starts when the server restarts
We need to setup /etc/rc.local for some reason above Ubuntu 16 because of system it doesn't automatically enable this service 


