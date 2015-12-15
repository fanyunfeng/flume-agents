bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

CONF=$1

#load config
. ${bin}/../etc/java.sh
. ${bin}/../etc/config.sh


#
cd ${bin}

#create directory
if [ ! -d logs ]; then
    mkdir logs
fi

#
exec ${FLUME_HOME}/bin/flume-ng agent --conf ${FLUME_HOME}/conf --conf-file ${bin}/${CONF} --name a1 -Dflume.root.logger=DEBUG,LOGFILE
