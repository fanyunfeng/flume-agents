#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


if [ $# -lt 2 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "run bash script on Remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file /driver/sourc/dir/file
    echo

    exit
fi

. ${bin}/tools.sh
. ${bin}/config.sh


RUNSHELL=PSEXECSH

#generate BAT file
#$1=file $2=host others
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2

    echo $3 > ${file}
}

runOnHosts $*

