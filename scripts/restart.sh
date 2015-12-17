#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

echo #################################
echo update 
${bin}/rsh.sh $1 ${bin}/flume.upldate.sh


echo #################################
echo stop service
${bin}/rcmd.sh $1 sc stop hc.flume


echo #################################
echo start service
${bin}/rcmd.sh $1 sc start hc.flume

