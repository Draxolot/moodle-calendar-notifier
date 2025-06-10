@echo off
REM Modify here the script path
set "SCRIPT_PATH=C:\repoPath\windows\main.py"

for /f "delims=" %%i in ('where python') do set "PYTHON_PATH=%%i" & goto :found
:found

set "CMD=%PYTHON_PATH% %SCRIPT_PATH%"

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Moodle-calendar-notifier" /t REG_SZ /D "%CMD%" /F

echo Script successfully added to boot programs
pause