@echo off
echo Setting up environment...

set "JAVA_HOME=C:\Program Files\Java\jdk-23"
echo Using Java at %JAVA_HOME%

echo Starting the application...
java -jar target\theater-management-0.0.1-SNAPSHOT.war

pause
