@ECHO OFF
@REM start flume-ng

SETLOCAL ENABLEDELAYEDEXPANSION
set LOCATION=%~dp0

set IP=%~n1
REM echo %IP%


set JAVABIN="%JAVA_HOME%\bin\java"
set OPTION=-Dflume.root.logger=DEBUG,LOGFILE 
set MONITOR=-Dflume.monitoring.type=hcse.flume.HcseGangliaServer -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649 -Dflume.monitoring.hostname=%IP%
set CLASSOPTION=%FLUME_HOME%\conf
set RUNCLASS=org.apache.flume.node.Application

for %%i in (%FLUME_HOME%\lib\*.jar) do (
	set CLASSOPTION=!CLASSOPTION!;%%i
)


REM echo %CLASSOPTION%

REM 
%JAVABIN% %OPTION% %MONITOR% -cp %CLASSOPTION% %RUNCLASS% --conf-file %LOCATION%%1 --name a1

