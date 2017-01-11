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
	
if [ ${RUNSHELL} = CMD ]; then
	COMMAND=${TMPDIR}/$1
	COMMAND=`toDosLocalPath ${COMMAND}`
	
	cmd.exe //C "$COMMAND"
	rm ${TMPDIR}/$1
elif [ ${RUNSHELL} = PSEXEC ]; then
#PSEXEC

#BAT file
cat << EOF > ${TMPDIR}/$1.R.bat
psexec \\\\${2} -f -c `toDosPath ${TMPDIR}/$1`
EOF

	unix2dos -q ${TMPDIR}/$1.R.bat
	
	COMMAND=${TMPDIR}/$1.R.bat 
	COMMAND=`toDosLocalPath ${COMMAND}`
	
	cmd.exe //C "$COMMAND"
	
	rm ${TMPDIR}/$1
	rm ${TMPDIR}/$1.R.bat
elif [ ${RUNSHELL} = PSEXECSH ]; then
#PSEXECSH
    local rTmpDir=/c/opt/tmp

    local rTmpHostDir=\\\\$2\\`toDosRath ${rTmpDir}`

    local fullFileName=`cat ${TMPDIR}/$1`
    local fileName=`basename ${fullFileName}`

		local remoteFullFileName=${rTmpDir}/${fileName}
    local remoteFullDosFileName=`toDosPath ${remoteFullFileName}`

#BOOT BAT run by psexec
cat << EOF > ${TMPDIR}/$1.R.bat
"C:\Program Files (x86)\Git\bin\sh.exe" ${remoteFullFileName}
REM del ${remoteFullDosFileName}
EOF

    unix2dos -q ${TMPDIR}/$1.R.bat

#BAT file
cat << EOF > ${TMPDIR}/$1.U.bat
REM ECHO OFF

REM upload shell script
mkdir ${rTmpHostDir}
xcopy `toDosPath ${fullFileName}` ${rTmpHostDir} /Y

REM run bat on Remote Host
psexec \\\\${host} -f -c `toDosPath ${TMPDIR}/$1.R.bat`
EOF

#START
	unix2dos -q ${TMPDIR}/$1.U.bat
	
	COMMAND=${TMPDIR}/$1.U.bat 
	COMMAND=`toDosLocalPath ${COMMAND}`
	
	cmd.exe //C "$COMMAND"
	
#	rm ${TMPDIR}/$1
#	rm ${TMPDIR}/$1.U.bat
#	rm ${TMPDIR}/$1.R.bat
fi
}

function runOnHosts(){
    grep "^#\|^[ \t]*$" -v ${HOSTLIST} | while IFS=" " read host os servcie; do
        echo -------------------
        echo ${host} ${os}
      
        if [ -z "${host}" ]; then
            continue
        fi

        genBat ${tmpfilename} $host $*

        runBat ${tmpfilename} ${host}
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

RUNSHELL=CMD
