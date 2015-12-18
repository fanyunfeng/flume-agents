bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

#load config
. ${bin}/../etc/config.sh

#
cd ${bin}

#create directory
if [ ! -d logs ]; then
    mkdir logs
    chown ${HADOOP_USER} logs
fi

if [ ! -d cache/checkpoint ]; then
    mkdir -p cache/checkpoint
    chown ${HADOOP_USER} cache -R
fi

if [ ! -d cache/data ]; then
    mkdir cache/data
    chown ${HADOOP_USER} cache/data
fi

MONCONF="-Dflume.monitoring.type=ganglia -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649"
LOGCONF="-Dflume.root.logger=DEBUG,LOGFILE"

CONF="--conf ${FLUME_HOME}/conf --conf-file ${bin}/agents.conf --name a1 ${LOGCONF} ${MONCONF}"

#
exec su  ${HADOOP_USER} -c "FLUME_JAVA_OPTS="-Xmx2g" ${FLUME_HOME}/bin/flume-ng agent ${CONF}"
