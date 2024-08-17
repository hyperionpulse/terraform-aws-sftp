#!/bin/sh

mkdir -p /scripts
cd /scripts
touch script.sh

cd

sudo mkdir -p /tf_user/sftp_user/sftp_user
sudo groupadd user
sudo useradd -g sftp_user -d /home/user -s /sbin/nologin sftp_user
sudo passwd sftp_user

sudo mkdir -p /home/user/.ssh
sudo chown sftp_user:sftp_user /home/sftp_user/
sudo chown sftp_user:sftp_user /home/sftp_user/.ssh
sudo touch /home/sftp_user/.ssh/authorized_keys
sudo chown sftp_user:sftp_user /home/sftp_user/.ssh/authorized_keys

sudo chown sftp_user:sftp_user /tf_user/sftp_user/sftp_user
sudo service sshd restart
# modify the /etc/ssh/sshd_config in Match Users to add the sftp_user and you should be good to go!
