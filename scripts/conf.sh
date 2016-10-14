#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

echo #################################
echo set env
${bin}/setenv.sh $*

echo #################################
echo create service
${bin}/csrv2.sh $1


#echo #################################
#echo create schedule 
#${bin}/rsch.sh $1 /c/opt/flume-agents/client/wrmfile.bat
