@ECHO OFF
@REM start flume-ng

REM echo "%JAVA_HOME%/bin" >> c:\opt\flume-agents\client\out.txt
REM echo "%FLUME_HOME%\bin\flume-ng agent --conf %FLUME_HOME%\conf --conf-file %1 --name a1" > c:\opt\flume-agents\client\out.txt

set MONCONF="-Dflume.monitoring.type=ganglia -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649"
REM set LOGCONF="-Dflume.root.logger=DEBUG,LOGFILE"

set CONF="%LOGCONF% %MONCONF%"

%FLUME_HOME%\bin\flume-ng agent --conf %FLUME_HOME%\conf --conf-file %1 --name a1 %CONF%
