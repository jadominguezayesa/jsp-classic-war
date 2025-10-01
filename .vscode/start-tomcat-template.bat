@echo off
setlocal enabledelayedexpansion
set CATALINA_HOME=${config:tomcat.home}
set CATALINA_BASE=${config:tomcat.home}
echo Starting Tomcat with JPDA on port 8000...
echo CATALINA_HOME=%CATALINA_HOME%
call "%CATALINA_HOME%\bin\catalina.bat" jpda start