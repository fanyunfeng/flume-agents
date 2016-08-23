#!/bin/bash
export PATH=/usr/bin:$PATH

cd /usr/local/flume-agents

sed -i -e 's/192\.168\.60\.23/10\.8\.5\.12/' /etc/hosts
sed -i -e 's/192\.168\.60\.24/10\.8\.5\.13/' /etc/hosts
sed -i -e 's/192\.168\.60\.210/10\.8\.5\.14/' /etc/hosts
sed -i -e 's/192\.168\.60\.211/10\.8\.5\.15/' /etc/hosts
sed -i -e 's/192\.168\.60\.212/10\.8\.5\.16/' /etc/hosts
sed -i -e 's/192\.168\.60\.213/10\.8\.5\.17/' /etc/hosts
sed -i -e 's/192\.168\.60\.214/10\.8\.5\.18/' /etc/hosts
sed -i -e 's/192\.168\.60\.215/10\.8\.5\.19/' /etc/hosts
sed -i -e 's/192\.168\.60\.216/10\.8\.5\.20/' /etc/hosts
sed -i -e 's/192\.168\.60\.217/10\.8\.5\.21/' /etc/hosts
sed -i -e 's/192\.168\.60\.218/10\.8\.5\.22/' /etc/hosts
sed -i -e 's/192\.168\.60\.219/10\.8\.5\.23/' /etc/hosts
sed -i -e 's/192\.168\.60\.220/10\.8\.5\.24/' /etc/hosts
sed -i -e 's/192\.168\.60\.221/10\.8\.5\.25/' /etc/hosts

git checkout master
