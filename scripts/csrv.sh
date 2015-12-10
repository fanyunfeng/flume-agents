#!/bin/bash

bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

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

function genBat(){
		echo "REM ECHO OFF" > $3
		echo "psexec \\\\$1 -c c:\\opt\\rkits\\instsrv.exe hc.flume c:\\opt\\rkits\\srvany.exe" >> $3
		
		echo "REG ADD \\\\$1\\HKLM\SYSTEM\\CurrentControlSet\\Services\\hc.flume\\Parameters /v AppDirectory /d c:\\opt\\flume-agents\\client /f" >> $3
		echo "REG ADD \\\\$1\\HKLM\SYSTEM\\CurrentControlSet\\Services\\hc.flume\\Parameters /v AppParameters /d $2.conf /f" >> $3
		echo "REG ADD \\\\$1\\HKLM\SYSTEM\\CurrentControlSet\\Services\\hc.flume\\Parameters /v Application /d c:\\opt\\flume-agents\\client\\start.bat /f" >> $3
		
		echo "exit" >> $3
}

mkdir tmp

grep "^#\|^[ \t]*$" -v ${bin}/hosts.list | while IFS=" " read host os servcie; do
  echo ${host} ${os}
  
  if [ -z "${host}" ]; then
    continue
  fi

	name=`formatIp $host`
	
	
	genBat $host $name tmp/gen.$name.csrv.bat
	
	unix2dos -q tmp/gen.$name.csrv.bat
	
	cmd /K tmp\\gen.$name.csrv.bat
	
done
