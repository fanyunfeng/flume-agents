#!/bin/bash

workdir=$1
disk=$2
instance=$3


timetag=`date +%F`


#backup
echo "cp ${workdir}/log4cxx.xml ${workdir}/log4cxx.xml.${timetag}"

#generate log4cxx config file
sed -s "s/\${disk}/${disk}/g;s/\${instance}/${instance}/g" ./client/d2/log4cxx.xml.template > log4cxx.xml
