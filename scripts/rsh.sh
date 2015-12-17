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
    echo "run bash script on Remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file /driver/sourc/dir/file
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

    local rTmpDir=/c/opt/tmp

    local path=`toDosPath $3`
    local rTmpHostDir=\\\\$2\\`toDosRath ${rTmpDir}`
    local src=`toDosPath $3`

    local fileName=`basename $3`

#BAT file
cat << EOF > ${file}
REM ECHO OFF

REM mkdir ${rTmpHostDir}
REM xcopy `toDosPath ${src}` ${rTmpHostDir}

REM `toDosPath ${rTmpDir}`\\${fileName}
EOF
}

runOnHosts $*

