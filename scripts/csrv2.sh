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

#args: $1=file $2=host $3=host $2=format
function genBat(){
	local file=${TMPDIR}/$1
    echo "REM ECHO OFF" > ${file}
    echo "psexec \\\\$2 c:\\opt\\nssm-2.24\\win64\\nssm.exe install hc.flume c:\\opt\\flume-agents\\client\\start.bat $3.conf" >> ${file}

    echo "exit" >> ${file}
}

function runBat(){
	unix2dos -q ${TMPDIR}/$1
	
	cmd /K ${TMPDIR}\\$1
}

if [ $# -lt 1 ]; then
    echo "Windows Platform Deploy Tools"
    echo 
    echo "help:"
    echo $0 host.file 
    echo

    exit
fi

if [ ! -d ${TMPDIR} ]; then
    mkdir ${TMPDIR}
fi

hosts=$1
shift

tmpfilename=csrv.bat

grep "^#\|^[ \t]*$" -v ${hosts} | while IFS=" " read host os servcie; do
    echo ${host} ${os}
  
    if [ -z "${host}" ]; then
        continue
    fi

    name=`formatIp $host`
	
	
    genBat ${tmpfilename} $host $name 
	
	runBat ${tmpfilename}
done
