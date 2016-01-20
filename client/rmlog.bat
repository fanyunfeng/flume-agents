REM @ECHO OFF

forfiles /p e:\logs /s /m *.COMPLETED /d -7 /c "cmd /c del @path /f"
forfiles /p f:\logs /s /m *.COMPLETED /d -7 /c "cmd /c del @path /f"