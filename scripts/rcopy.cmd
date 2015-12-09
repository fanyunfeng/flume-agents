@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

set LOCATION=%~dp0
set HOSTFILE=%LOCATION%\hosts.list


for /f %%i in ( %HOSTFILE% ) do (
	if "%%i"=="" continue

	set host=%%i

	if "!host:~0,1!"=="#" (
		echo "common out %%i"
	) else (
		echo "xcopy to %%i:"
		mkdir \\%%i\c$%~pn1
		xcopy %1 \\%%i\c$%~pn1 /E /F /H /Y
	)
)
