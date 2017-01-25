#!/bin/bash

#
source /etc/profile

env | grep HADOOP

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

#load config
. ${bin}/../etc/config.sh

#
if [ ! -d ${HADOOP_MOUNTPOINT}/search/events ]; then
	/usr/local/bin/jnirun.hadoop /usr/local/bin/fuse_dfs hdfs://hadoop2cluster ${HADOOP_MOUNTPOINT}
fi

if [ ! -d ${HADOOP_MOUNTPOINT}/search/events ]; then
	echo "can not access hadoop."
	exit 1
fi

echo LOG --- ${HADOOP_USER}

#rm log & empty directory
su - ${HADOOP_USER} -c "find -L ${HADOOP_MOUNTPOINT}/search/events -atime +3 -a -type f -exec rm -v -rf {} \;"
su - ${HADOOP_USER} -c "find -L ${HADOOP_MOUNTPOINT}/search/events -empty -a -type d -delete"

umount ${HADOOP_MOUNTPOINT}
