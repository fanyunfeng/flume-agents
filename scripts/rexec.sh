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
#args: $1=file $2=host $3=command
function genBat(){
    local file=${TMPDIR}/$1
    local host=$2
    local command=$3

    shift 3


    echo "REM ECHO OFF" > ${file}
    echo "${command} \\\\${host} $*" >> ${file}
    
    echo "exit" >> ${file}
}

function runBat(){
	unix2dos -q ${TMPDIR}/$1
	
	cmd /K ${TMPDIR}\\$1
}

if [ $# -lt 3 ]; then
    echo "Windows Platform Deploy Tools"
    echo 
    echo "help:"
    echo $0 host.file /driver/sourc/dir /driver/destination/dir
    echo

    exit
fi

if [ ! -d ${TMPDIR} ]; then
    mkdir ${TMPDIR}
fi

hosts=$1
shift

tmpfilename=rexec.bat

grep "^#\|^[ \t]*$" -v ${hosts} | while IFS=" " read host os servcie; do
    echo ${host} ${os}
  
    if [ -z "${host}" ]; then
        continue
    fi

    #name=`formatIp $host`

    genBat ${tmpfilename} $host $*

    runBat ${tmpfilename}
done
