#/bin/bash

ssh-keygen 
cat ~/.ssh/id_rsa.pub | ssh admin@192.168.119.94 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh admin@192.168.119.165 'cat >> ~/.ssh/authorized_keys'

git config --global user.email admin@hc360.com
git config --global user.name admin
