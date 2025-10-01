@echo off
REM Este archivo es generado automáticamente - NO EDITAR MANUALMENTE
echo Deploying WAR file...
set "SOURCE=G:\Mi unidad\Proyectos\0-Github copilot\2 workshop-migracion\java-workshop-samples\jsp-classic-war\target\jsp-classic-war-1.0.0.war"
set "DEST=C:\Desarrollo\apache-tomcat-10.1.5\apache-tomcat-10.1.5\webapps\jsp-classic-war.war"
echo Source: %SOURCE%
echo Destination: %DEST%
copy "%SOURCE%" "%DEST%" /Y
if %errorlevel% == 0 (
    echo WAR deployed successfully
) else (
    echo ERROR: Failed to deploy WAR file
)
