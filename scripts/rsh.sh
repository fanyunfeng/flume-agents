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
    local commandFile=$3

    local rTmpDir=/c/opt/tmp

    local rTmpHostDir=\\\\$2\\`toDosRath ${rTmpDir}`

    local fileName=`basename ${commandFile}`

#BOOT BAT run by psexec
cat << EOF > ${file}.bat
`toDosPath ${rTmpDir}`\\${fileName}
EOF

#BAT file
cat << EOF > ${file}
REM ECHO OFF

REM upload shell script
mkdir ${rTmpHostDir}
xcopy `toDosPath ${commandFile}` ${rTmpHostDir} /Y

REM run bat on Remote Host
psexec \\\\${host} -c -f `toDosPath ${file}.bat`
EOF
}

runOnHosts $*

