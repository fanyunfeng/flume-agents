#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

TMPDIR=tmp

function formatIp(){
	number=`echo $1 | sed -e 's/\\./ /g'`
	
	ip=
	for i in $number; do
		if [ $i -lt 10 ]; then
			ip=$ip.00$i
		elif [ $i -lt 100 ]; then
			ip=$ip.0$i
		else
			ip=$ip.$i
		fi
	done
	
	echo ${ip:1}
}

function toDosPath(){
    echo $1 | sed -e 's|^\/\(.\?\)\/|\1:\/|;s|/$||;s|/|\\|g'
}

function toDosRath(){
    echo $1 | sed -e 's|^\/\(.\?\)\/|\1$\/|;s|/$||;s|/|\\|g'
}

#
#args: $1=file $2=host $3=source $4=dest
function genBat(){
    local file=${TMPDIR}/$1
    local rpath=`toDosRath $4`
    local dest=\\\\$2\\${rpath}
    local src=`toDosPath $3`

    echo "REM ECHO OFF" > ${file}
    echo "mkdir ${dest}" >> ${file}
    echo "xcopy ${src} ${dest} /E /F /H /Y" >> ${file}
    
    echo "exit" >> ${file}
}

function runBat(){
	unix2dos -q ${TMPDIR}/$1
	
	cmd /K ${TMPDIR}\\$1
}

if [ $# -lt 3 ]; then
    echo $0 host.file /driver/sourc/dir /driver/destination/dir
    exit
fi

if [ ! -d ${TMPDIR} ]; then
    mkdir ${TMPDIR}
fi

hosts=$1
shift

grep "^#\|^[ \t]*$" -v ${hosts} | while IFS=" " read host os servcie; do
    echo ${host} ${os}
  
    if [ -z "${host}" ]; then
        continue
    fi

    #name=`formatIp $host`

    genBat rcp.bat $host $*

    runBat rcp.bat
done
