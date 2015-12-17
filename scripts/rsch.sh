#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

TMPDIR=${bin}/tmp

if [ ! -d ${TMPDIR} ]; then
    mkdir -p ${TMPDIR}
fi

if [ $# -lt 2 ]; then
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

hosts=$1
shift

tmpfilename=`basename $0 .sh`
tmpfilename=${tmpfilename}.cmd

echo ${tmpfilename}

#generate BAT file
#$1=file $2=host others
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2

    local commandFile=$3

#BAT file
cat << EOF > ${file}
REM ECHO OFF
schtasks /create /tn hc.flume.rmfiles /tr `toDosPath ${commandFile}` /sc DAILY /RU "System" /RP /st 00:15:00 /s ${host}
EOF
}

runOnHosts $*

