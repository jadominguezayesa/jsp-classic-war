@echo off
REM Script para actualizar rutas de Tomcat en archivos .bat
echo.
echo 🔄 Actualizando rutas de Tomcat desde settings.json...
echo.

REM Obtener rutas desde settings.json usando PowerShell
for /f "delims=" %%i in ('powershell -Command "Get-Content '.vscode\settings.json' | ConvertFrom-Json | Select-Object -ExpandProperty 'tomcat.home'"') do set TOMCAT_HOME=%%i
for /f "delims=" %%i in ('powershell -Command "Get-Content '.vscode\settings.json' | ConvertFrom-Json | Select-Object -ExpandProperty 'tomcat.webapps'"') do set TOMCAT_WEBAPPS=%%i

echo Tomcat Home: %TOMCAT_HOME%
echo Tomcat Webapps: %TOMCAT_WEBAPPS%
echo Workspace: %CD%
echo.

REM Actualizar start-tomcat.bat
echo Actualizando start-tomcat.bat...
powershell -Command "(Get-Content '.vscode\start-tomcat.bat') -replace 'set \"CATALINA_HOME=.*\"', 'set \"CATALINA_HOME=%TOMCAT_HOME%\"' -replace 'set \"CATALINA_BASE=.*\"', 'set \"CATALINA_BASE=%TOMCAT_HOME%\"' | Set-Content '.vscode\start-tomcat.bat'"

REM Actualizar stop-tomcat.bat
echo Actualizando stop-tomcat.bat...
powershell -Command "(Get-Content '.vscode\stop-tomcat.bat') -replace 'set \"CATALINA_HOME=.*\"', 'set \"CATALINA_HOME=%TOMCAT_HOME%\"' -replace 'set \"CATALINA_BASE=.*\"', 'set \"CATALINA_BASE=%TOMCAT_HOME%\"' | Set-Content '.vscode\stop-tomcat.bat'"

REM Actualizar deploy-war.bat
echo Actualizando deploy-war.bat...
powershell -Command "(Get-Content '.vscode\deploy-war.bat') -replace 'set \"SOURCE=.*\"', 'set \"SOURCE=%CD%\target\jsp-classic-war-1.0.0.war\"' -replace 'set \"DEST=.*\"', 'set \"DEST=%TOMCAT_WEBAPPS%\jsp-classic-war.war\"' | Set-Content '.vscode\deploy-war.bat'"

echo.
echo ✅ Archivos .bat actualizados correctamente!
echo.
echo Archivos modificados:
echo   - .vscode\start-tomcat.bat
echo   - .vscode\stop-tomcat.bat  
echo   - .vscode\deploy-war.bat
echo.
pause