#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


if [ $# -lt 1 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "create service on Remote Windows Machines."
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
    local name=`formatIp $host`

#BAT file
cat << EOF > ${file}
REM ECHO OFF

psexec \\\\${host} c:\\opt\\nssm-2.24\\win64\\nssm.exe install hc.flume c:\\opt\\flume-agents\\client\\start.bat ${name}.conf
EOF
}

runOnHosts $*

