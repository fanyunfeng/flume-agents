#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

TMPDIR=${bin}/tmp

if [ ! -d ${TMPDIR} ]; then
    mkdir -p ${TMPDIR}
fi

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

    local rpath=`toDosRath $4`
    local dest=\\\\$2\\${rpath}
    local src=`toDosPath $3`

#BAT file
cat << EOF > ${file}
REM ECHO OFF

mkdir ${dest}
xcopy ${src} ${dest} /E /F /H /Y
EOF
}

runOnHosts $*

