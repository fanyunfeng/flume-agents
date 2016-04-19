#!/bin/bash

#
source /etc/profile

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

#load config
. ${bin}/../etc/config.sh

#
if [ ! -d ${HADOOP_HOME}/search/events ]; then
	jnirun.hadoop fuse_dfs dfs://namenode1:9000 ${HADOOP_HOME}
fi

if [ ! -d ${HADOOP_HOME}/search/events ]; then
	echo "can not access hadoop."
	exit 1
fi

#rm log & empty directory
su - ${HADOOP_USER} -c "find -L ${HADOOP_HOME}/search/events -atime +7 -a -type f -exec rm -rf {} \;"
su - ${HADOOP_USER} -c "find -L ${HADOOP_HOME}/search/events -empty -a -type d -exec rm -rf {} \;"
