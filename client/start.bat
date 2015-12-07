@ECHO OFF
@REM start flume-ng

REM echo "%JAVA_HOME%/bin" >> c:\opt\flume-agents\client\out.txt
REM echo "%FLUME_HOME%\bin\flume-ng agent --conf %FLUME_HOME%\conf --conf-file %1 --name a1" > c:\opt\flume-agents\client\out.txt


%FLUME_HOME%\bin\flume-ng agent --conf %FLUME_HOME%\conf --conf-file %1 --name a1
