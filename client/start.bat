@ECHO OFF
@REM start flume-ng

SETLOCAL ENABLEDELAYEDEXPANSION
set LOCATION=%~dp0

set JAVABIN="%JAVA_HOME%\bin\java"
set OPTION=-Dflume.root.logger=DEBUG,LOGFILE -Dflume.monitoring.type=ganglia -Dflume.monitoring.hosts=192.168.60.124:8649,192.168.60.62:8649 
set CLASSOPTION=%FLUME_HOME%\conf
set RUNCLASS=org.apache.flume.node.Application

for %%i in (%FLUME_HOME%\lib\*.jar) do (
	set CLASSOPTION=!CLASSOPTION!;%%i
)


REM echo %CLASSOPTION%

%JAVABIN% %OPTION% -cp %CLASSOPTION% %RUNCLASS% --conf-file %LOCATION%%1 --name a1

