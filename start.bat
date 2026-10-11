@echo off
setlocal enabledelayedexpansion

echo Starting CodeRush...
set "APP_NAME=CodeRush"
set "SCRIPT_DIR=%~dp0"
set "PROJECT_SRC=%SCRIPT_DIR%src\main\java"
set "PROJECT_WEBAPP=%SCRIPT_DIR%src\main\webapp"

set "TOMCAT_HOME=%CATALINA_HOME%"
if not defined TOMCAT_HOME set "TOMCAT_HOME=C:\apache-tomcat-9.0.121"

if not exist "%TOMCAT_HOME%\bin\startup.bat" (
    for %%D in (
        "C:\apache-tomcat-9.0.121"
        "C:\Users\VEDANT\Downloads\apache-tomcat-9.0.121-windows-x64\apache-tomcat-9.0.121"
    ) do (
        if exist "%%~D\bin\startup.bat" set "TOMCAT_HOME=%%~D"
    )
)

echo Launching Tomcat from: %TOMCAT_HOME%
if not exist "%TOMCAT_HOME%\bin\startup.bat" (
    echo [ERROR] Could not find Tomcat. Set CATALINA_HOME or update the TOMCAT_HOME path in this script.
    pause
    exit /b 1
)

if not exist "%PROJECT_WEBAPP%" (
    echo [ERROR] Could not find project webapp folder: %PROJECT_WEBAPP%
    pause
    exit /b 1
)

powershell -NoProfile -Command "$p = Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'java.exe' -and $_.CommandLine -like '*org.apache.catalina.startup.Bootstrap*' }; if ($p) { Write-Host 'Stopping stale Tomcat process...'; $p | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue } }" >nul 2>&1

timeout /t 3 >nul

set "TARGET_WEBAPP=%TOMCAT_HOME%\webapps\%APP_NAME%"
if exist "%TARGET_WEBAPP%" (
    echo Removing existing deployment...
    rmdir /s /q "%TARGET_WEBAPP%"
)

mkdir "%TARGET_WEBAPP%" >nul 2>&1
mkdir "%TARGET_WEBAPP%\WEB-INF\classes" >nul 2>&1

echo Deploying the current project files into Tomcat...
xcopy /E /I /Y "%PROJECT_WEBAPP%\*" "%TARGET_WEBAPP%\" >nul

set "SERVLET_JAR="
for %%J in ("%TOMCAT_HOME%\lib\servlet-api.jar") do set "SERVLET_JAR=%%~fJ"
set "MYSQL_JAR="
for %%J in ("%TOMCAT_HOME%\lib\mysql-connector*.jar") do set "MYSQL_JAR=%%~fJ"

if not exist "%SERVLET_JAR%" (
    echo [ERROR] servlet-api.jar was not found in %TOMCAT_HOME%\lib
    pause
    exit /b 1
)

if not exist "%MYSQL_JAR%" (
    echo [ERROR] MySQL JDBC driver was not found in %TOMCAT_HOME%\lib
    pause
    exit /b 1
)

echo Compiling Java servlets and models...
set "JAVA_FILES="
for /r "%PROJECT_SRC%" %%F in (*.java) do set "JAVA_FILES=!JAVA_FILES! "%%~fF""

javac -cp "%SERVLET_JAR%;%MYSQL_JAR%" -d "%TARGET_WEBAPP%\WEB-INF\classes" %JAVA_FILES%
if errorlevel 1 (
    echo [ERROR] Java compilation failed. Check the source files for errors.
    pause
    exit /b 1
)

echo Compiled app classes successfully.
call "%TOMCAT_HOME%\bin\startup.bat"

echo Waiting for the server to spin up...
timeout /t 6 >nul

echo Opening CodeRush in your browser...
start "" "http://localhost:8080/%APP_NAME%/"
