bin=`which $0`
bin=`dirname ${bin}`
bin=`cd "$bin"; pwd`

#load config
. ${bin}/../etc/config.sh

#
su  ${HADOOP_USER} -c "FLUME_JAVA_OPTS="-Xmx2g" ${FLUME_HOME}/bin/flume-ng agent --conf ${FLUME_HOME}/conf --conf-file ${bin}/agents.conf --name a1 -Dflume.root.logger=DEBUG,LOGFILE"
