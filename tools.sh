#!/bin/bash

# description: Setup VULTR for user, create system user install  docker, docker-compose
# Environment settings

INSTALL_DIR=`echo $0 | sed 's/tools\.sh//g'`
set -x


setupSystemUserAndDocker() {

  # Update system
  apt-get update
  apt-get upgrade
  cd /usr/local/src
  apt-get -y install tmux git vim
  git clone https://github.com/magescale/vultr.git
  cd vult
  
  # Make sure to run as root
  user="$(id -un 2>/dev/null || true)"

  if [ "$user" != 'root' ]; then
    echo "Please try again as root"
    return 1
  fi
 
  # Collect hostname
  echo "Please enter the username"
  read username

  # Install Docker
  curl -sSL https://get.docker.com/ | sh

  # Create user based on hostname and Add hostname user to docker group
  useradd -m -G sudo,docker -s /bin/bash $username
  echo $username:password | chpasswd

}


installDockerCompose() {

  # Install Docker compose
  curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
  
}


installRcLocalService () {

  echo  "Create a service:"
  cp rc-local.service /etc/systemd/system/rc-local.service
  
  echo "Create and make sure /etc/rc.local is executable and add this code inside it:"
  cp rc.local /etc
  sudo chmod +x /etc/rc.local
  
  echo "Enable the service:"
  sudo systemctl enable rc-local

}


case "$1" in
  setupSystemUserDockerAndDockerCompose)
    setupSystemUserAndDocker
    installDockerCompose
    ;;
  setupSystemUserAndDocker)
    setupSystemUserAndDocker
    ;;
  installDockerCompose)
    installDockerCompose
    ;;
  installRcLocalService)
    installRcLocalService
    ;;  
  *)
echo "
SYNOPSIS
    sh tools.sh
    sh tools.sh [-- [OPTIONS...]] [-- [ENVIRONMENT...]]

DESCRIPTION
    Setup access user, install docker, docker-compose 

OPTIONS
    setupSystemUserDockerAndDockerCompose     Setup system user, install docker & docker-compose
    setupSystemUserAndDocker                  Setup system user, install docker
    installDockerCompose                      Install docker-compose
    installRcLocalService                     Install /etc/rc.local to run commands when the system is rebooted.
EXAMPLES
    # Run directly from after creating account and logging into the server via root 
    bash <(curl -sSL https://raw.githubusercontent.com/magescale/vultr/master/tools.sh) setupSystemUserDockerAndDockerCompose

    # Setup system user, docker
    sh tool.sh setupSystemUserAndDocker

    # Setup system user, docker
    sh tool.sh setupSystemUserAndDocker

    # Install Docker
    # sh tools.sh installDocker 

    # Install Docker Compose
    # sh tools.sh installDockerCompose 

"
    >&2
    exit 1
    ;;
esac

