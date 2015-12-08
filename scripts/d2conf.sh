#!/bin/bash

if [ $# -lt 3 ]; then
  echo "help:"
  echo "`basename $0` /disk/d2/floder/ /disk/logs/dir/ [instance id(eg. 0 1)]"
  exit
fi

workdir=$1
prefix=$2
instance=$3

timetag=`date +%F`

#append /
if [ "${workdir:-1}" != "/" ]; then
  workdir="${workdir}/"
fi

if [ "${prefix:-1}" != "/" ]; then
  prefix="${prefix}/"
fi

#to DOS path
prefix=`echo ${prefix} | sed -e 's|^\/\(.\?\)\/|\1:\/|;s|/$||'`

echo "DOS dir prefix: ${prefix} TimeTag:${timetag}"

#
bakfile=${workdir}/log4cxx.xml.${timetag}

#if [ -e ${bakfile} ]; then
  #echo "backup file already exist."

  #
  lastfile=`ls ${bakfile}.* -tv | tail -n 1`

  if [ -z "${lastfile}" ]; then
    count=1
  else
    count=${lastfile##*.}
    ((count++))
  fi

  echo $count
  #
  bakfile=${bakfile}.${count}
#fi

#backup
cp ${workdir}/log4cxx.xml ${bakfile} 

#generate log4cxx config file
sed -s "s|\${prefix}|${prefix}|g;s|\${instance}|${instance}|g" ./client/d2/log4cxx.xml.template > ${workdir}/log4cxx.xml
