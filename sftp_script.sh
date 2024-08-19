#!/bin/sh


sudo mkdir -p /tf_user/sftp_username/sftp_username
sudo groupadd sftp_username
sudo useradd -g sftp_username -d /home/user -s /sbin/nologin sftp_username
sudo passwd sftp_username

sudo mkdir -p /home/user/.ssh
sudo chown sftp_username:sftp_username /home/sftp_username/
sudo chown sftp_username:sftp_username /home/sftp_username/.ssh
sudo touch /home/sftp_username/.ssh/authorized_keys
sudo chown sftp_username:sftp_username /home/sftp_username/.ssh/authorized_keys

sudo chown sftp_username:sftp_username /tf_user/sftp_username/sftp_username
sudo service sshd restart
# modify the /etc/ssh/sshd_config in Match Users to add the sftp_username and you should be good to go!
