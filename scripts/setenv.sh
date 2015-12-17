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
    echo "set Environment Variable on remote Windows Machines."
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

setx -m JAVA_HOME "C:\Program Files\Java\jre7"
setx -m CLASSPATH ".;C:\Program Files\Java\jre7\lib\tools.jar"
setx -m FLUME_HOME "c:\opt\apache-flume-1.6.0-bin"
EOF
}

runOnHosts $*

