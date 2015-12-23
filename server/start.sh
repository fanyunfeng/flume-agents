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

function createCacheDir(){
	if [ ! -d $1 ]; then
	    mkdir -p $1
	    chown ${HADOOP_USER} $1
	fi
	if [ ! -d $1/checkpoint ]; then
	    mkdir -p $1/checkpoint
	    chown ${HADOOP_USER} $1/checkpoint
	fi

	if [ ! -d $1/data ]; then
	    mkdir $1/data
	    chown ${HADOOP_USER} $1/data
	fi
}

createCacheDir cache1
createCacheDir cache2
createCacheDir cache3
createCacheDir cache4

CLASSPATH=../lib/*.jar:${CLASSPATH}

export CLASSPATH

IP=`basename $1 .conf`
MONCONF="-Dflume.monitoring.type=hcse.flume.HcseGangliaServer -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649 -Dflume.monitoring.hostname=${IP}"
LOGCONF="-Dflume.root.logger=DEBUG,LOGFILE"

CONF="--conf ${FLUME_HOME}/conf --conf-file ${bin}/$1 --name a1 ${LOGCONF} ${MONCONF}"

#
exec su  ${HADOOP_USER} -c "FLUME_JAVA_OPTS="-Xmx16g" ${FLUME_HOME}/bin/flume-ng agent ${CONF}"
