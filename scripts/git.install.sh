#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

TMPDIR=${bin}/tmp

if [ ! -d ${TMPDIR} ]; then
    mkdir -p ${TMPDIR}
fi

if [ $# -lt 1 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "install git on remote Windows Machine."
    echo 
    echo "usage:"
    echo $0 host.file
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

    echo ${file}

#BAT file
cat << EOF > ${file}
REM ECHO OFF
psexec \\\\${host} -c \\\\${FSERVER}\\share\\software\\windows\\Git-2.9.2-32-bit.exe /NORESTART /SILENT
EOF
}

runOnHosts $*
