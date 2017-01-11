#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


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


#generate BAT file
#$1=file $2=host others
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2

    echo ${file}

#BAT file
cat << EOF > ${file}
psexec \\\\${host} -c `toDosPath ${file}.R.bat`
EOF

#evn file
cat << EOF > ${file}.R.bat
REM ECHO OFF

setx -m JAVA_HOME "C:\Program Files\Java\jre7"
setx -m CLASSPATH ".;C:\Program Files\Java\jre7\lib\tools.jar"
setx -m FLUME_HOME "c:\opt\apache-flume-1.6.0-bin"
EOF

    unix2dos -q ${file}.R.bat
}

runOnHosts $*

