#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


if [ $# -lt 3 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "run command(eg. sc \\\\host start service) on Remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file cmd args
    echo

    exit
fi


tmpfilename=`basename $0 .sh`
tmpfilename=${tmpfilename}.bat

echo ${tmpfilename}

#generate BAT file
#$1=file $2=host others
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2

    local cmd=$3
    shift 3

#BAT file
cat << EOF > ${file}
REM ECHO OFF

${cmd} \\\\${host} $*
exit
EOF
}

runOnHosts $*

