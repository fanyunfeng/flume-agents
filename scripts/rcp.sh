#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


if [ $# -lt 3 ]; then
    echo "Windows Platform Deployment Tools."
    echo 
    echo "doc:"
    echo "copy files to Remote Windows Machines."
    echo 
    echo "usage:"
    echo $0 host.file /driver/sourc/dir /driver/destination/dir
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

