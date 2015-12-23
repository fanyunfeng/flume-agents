bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

#load config
. ${bin}/../etc/java.sh
. ${bin}/../etc/config.sh


#
cd ${bin}

#create directory
if [ ! -d logs ]; then
    mkdir logs
fi

export FLUME_JAVA_OPTS=-Xmx200m

IP=`basename $1 .conf`
MONCONF="-Dflume.monitoring.type=hcse.flume.HcseGangliaServer -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649 -Dflume.monitoring.hostname=${IP}"
LOGCONF="-Dflume.root.logger=DEBUG,LOGFILE"

CONF="--conf ${FLUME_HOME}/conf --conf-file ${bin}/$1 --name a1 ${LOGCONF} ${MONCONF}"
#
exec ${FLUME_HOME}/bin/flume-ng agent ${CONF}
