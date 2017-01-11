#!/bin/bash

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

function toDosLocalPath(){
    echo $1 | sed -e 's|^/\(.\)/|\1:\\|;s|/|\\|g'
}

function runBat(){
	unix2dos -q ${TMPDIR}/$1
	
	COMMAND=${TMPDIR}/$1
	COMMAND=`toDosLocalPath ${COMMAND}`
	
	cmd.exe //C "$COMMAND"
}

function runOnHosts(){
    grep "^#\|^[ \t]*$" -v ${HOSTLIST} | while IFS=" " read host os servcie; do
        echo -------------------
        echo ${host} ${os}
      
        if [ -z "${host}" ]; then
            continue
        fi

        genBat ${tmpfilename} $host $*

        runBat ${tmpfilename}
    done
}

TMPDIR=${bin}/tmp

if [ ! -d ${TMPDIR} ]; then
    mkdir -p ${TMPDIR}
fi

tmpfilename=`basename $0 .sh`
tmpfilename=${tmpfilename}.bat

echo BAT:$tmpfilename

HOSTLIST=$1
if [ ! -e $1 ]; then
	echo $1 > ./tmp.host
	
	HOSTLIST=./tmp.host
fi

shift

echo ON:
cat ${HOSTLIST}

echo START:

