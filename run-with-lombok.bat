@echo off
echo Starting QuickFlicks with Lombok agent...

REM Set Java home to the detected Java installation
set "JAVA_HOME=C:\Program Files\Java\jdk-23"
echo Using Java at %JAVA_HOME%

REM Create data directory if it doesn't exist
if not exist "data" mkdir data

REM Clean and package the application
call mvnw.cmd clean package -DskipTests

REM Run the application with Lombok agent
java -javaagent:lombok-1.18.30.jar -jar target\theater-management-0.0.1-SNAPSHOT.war

echo Application stopped.
