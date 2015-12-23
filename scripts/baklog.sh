#!/bin/bash

ROOTS='/e/logs /f/logs'
SERVICES='d21 d22 cache1/search_time'

function bakup(){
  cd $1
  for I in ${SERVICES}  ; do
    SOURCE=$1/$I
    
    if [ ! -d ${SOURCE} ]; then
      continue
    fi

    BAKDIR=$1/bak/$I

    if [ ! -d ${BAKDIR} ]; then
      mkdir -p ${BAKDIR}
    fi
    find -L ${SOURCE} -regex '.*log\.[-0-9]*' -exec mv {} ${BAKDIR} \;
    #mv ${SOURCE}/*.log.* ${BAKDIR}
  done
}

for X in ${ROOTS} ; do
  if [ ! -d $X ]; then
    continue
  fi

  bakup $X
done
