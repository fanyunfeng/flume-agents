#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

echo #################################
echo install Git
${bin}/git.install.sh $*

echo #################################
echo install JRE
${bin}/jre.install.sh $*

echo #################################
echo set env
${bin}/setenv.sh $*

echo #################################
echo copy file
${bin}/rcp.sh $1 /c/opt/pstools /c/opt/pstools
${bin}/rcp.sh $1 /c/opt/rkits /c/opt/rkits
${bin}/rcp.sh $1 /c/opt/nssm-2.24 /c/opt/nssm-2.24
${bin}/rcp.sh $1 /c/opt/apache-flume-1.6.0-bin /c/opt/apache-flume-1.6.0-bin
${bin}/rcp.sh $1 /c/opt/flume-agents /c/opt/flume-agents

echo #################################
echo create service
${bin}/csrv2.sh $1


#echo #################################
#echo create schedule 
#${bin}/rsch.sh $1 /c/opt/flume-agents/client/wrmfile.bat
