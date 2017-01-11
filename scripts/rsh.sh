#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`


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
cat << EOF > ${file}.R.bat
"C:\Program Files (x86)\Git\bin\sh.exe" --login `toDosPath ${rTmpDir}`\\${fileName}
EOF

    unix2dos -q ${file}.R.bat

#BAT file
cat << EOF > ${file}
REM ECHO OFF

REM upload shell script
mkdir ${rTmpHostDir}
xcopy `toDosPath ${commandFile}` ${rTmpHostDir} /Y

REM run bat on Remote Host
psexec \\\\${host} -c -f `toDosPath ${file}.R.bat`
exit
EOF
}

runOnHosts $*

