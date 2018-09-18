# vultr
Utility scripts to setup VULTR


## Setup
We install git, tmux, vim and initialise the sytem to run our bash script
cd /usr/local/src
yum install git, tmux, vim


## Install User via root

## Install docker

## Install docker-compose


## Ensure docker starts when the server restarts
We need to setup /etc/rc.local for some reason above Ubuntu 16 because of system it doesn't automatically enable this service 

Create a service:

sudo vi /etc/systemd/system/rc-local.service
Add your code there:

[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
Create and make sure /etc/rc.local is executable and add this code inside it:

sudo chmod +x /etc/rc.local

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

exit 0
Enable the service:

sudo systemctl enable rc-local
