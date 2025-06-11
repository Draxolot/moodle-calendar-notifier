@echo off

set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

del "%STARTUP_FOLDER%\moodle-calendar-notifier.bat"

echo Moodle Calendar Notifier has been successfully removed from startup programs