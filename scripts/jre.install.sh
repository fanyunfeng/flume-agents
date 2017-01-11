#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


if [ $# -lt 1 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "install jre on remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file
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

    echo ${file}

#BAT file
cat << EOF > ${file}
REM ECHO OFF
psexec \\\\${host} -c \\\\${FSERVER}\\share\\software\\jdk\\jre-7u80-windows-x64.exe /s
EOF
}

runOnHosts $*
