#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

if [ $# -lt 1 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "create schedule on Remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file /driver/path/file
    echo

    exit
fi

. ${bin}/tools.sh
. ${bin}/config.sh


#generate BAT file
#$1=file $2=host others
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2

    local commandFile=$3

#BAT file
cat << EOF > ${file}
REM ECHO OFF
schtasks /delete /tn hc.flume.rmfiles /F /s ${host}
exit
EOF
}

runOnHosts $*

