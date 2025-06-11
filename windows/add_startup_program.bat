@echo off

REM Modify REPO_PATH variable with the absolute repository path
set REPO_PATH=C:\repo\path
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

(
echo @echo off
echo cd /d %REPO_PATH%
echo python "%REPO_PATH%\windows\main.py"
) > "%STARTUP_FOLDER%\moodle-calendar-notifier.bat"

echo Moodle Calendar Notifier has been successfully added to startup programs