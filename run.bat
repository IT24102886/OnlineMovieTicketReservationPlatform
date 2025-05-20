@echo off
echo Setting up environment...

REM Set Java home to the detected Java installation
set "JAVA_HOME=C:\Program Files\Java\jdk-23"
echo Using Java at %JAVA_HOME%



REM Compile and run the application
echo Building the application...
call .\mvnw.cmd clean package -DskipTests

if %ERRORLEVEL% NEQ 0 (
    echo Build failed. Please check the error messages above.
    goto :end
)

echo Starting the application...
call .\mvnw.cmd spring-boot:run

:end
pause
