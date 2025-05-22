@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo    QuickFlicksPayment - IntelliJ IDEA Launcher
echo ===================================================
echo.

:: Check Java installation
echo Checking Java installation...
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java is not installed or not in PATH.
    echo Please install JDK 21 or higher from https://adoptium.net/
    echo.
    pause
    exit /b 1
) else (
    for /f tokens^=2-5^ delims^=.-_^" %%j in ('java -version 2^>^&1') do (
        set "jver=%%j"
        goto :breakJava
    )
    :breakJava
    if !jver! LSS 21 (
        echo [WARNING] Java version !jver! detected. This application requires Java 21 or higher.
        echo You may encounter issues with the current Java version.
    ) else (
        echo [OK] Java !jver! detected.
    )
)
echo.

:: Find IntelliJ IDEA installation
echo Checking for IntelliJ IDEA installation...
set "IDEA_EXE="

:: Check common installation paths for IntelliJ IDEA
for %%p in (
    "%PROGRAMFILES%\JetBrains\IntelliJ IDEA*\bin\idea64.exe"
    "%PROGRAMFILES(X86)%\JetBrains\IntelliJ IDEA*\bin\idea64.exe"
    "%APPDATA%\JetBrains\IntelliJ*\bin\idea64.exe"
    "%LOCALAPPDATA%\JetBrains\IntelliJ*\bin\idea64.exe"
    "%USERPROFILE%\AppData\Local\JetBrains\Toolbox\apps\IDEA-U\ch-0\*\bin\idea64.exe"
    "%USERPROFILE%\AppData\Local\JetBrains\Toolbox\apps\IDEA-C\ch-0\*\bin\idea64.exe"
) do (
    for /f "delims=" %%i in ('dir /b /s %%p 2^>nul') do (
        set "IDEA_EXE=%%i"
        goto :foundIdeaExe
    )
)

:foundIdeaExe
if not defined IDEA_EXE (
    echo [ERROR] Could not find IntelliJ IDEA installation.
    echo Please install IntelliJ IDEA from https://www.jetbrains.com/idea/download/
    echo.
    echo After installation, you can:
    echo 1. Open IntelliJ IDEA manually
    echo 2. Select "Open" and navigate to:
    echo    %~dp0
    echo 3. Select the pom.xml file and open as project
    echo.
    pause
    exit /b 1
) else (
    echo [OK] Found IntelliJ IDEA at: !IDEA_EXE!
)
echo.

:: Get the current directory (project root)
set "PROJECT_DIR=%~dp0"
set "PROJECT_DIR=%PROJECT_DIR:~0,-1%"

:: Check if the project has been opened in IntelliJ IDEA before
set "IDEA_CONFIG_DIR=%PROJECT_DIR%\.idea"
if not exist "%IDEA_CONFIG_DIR%" (
    echo [INFO] First time opening the project in IntelliJ IDEA.
    echo        You'll need to create a run configuration manually.
    set "FIRST_TIME=true"
) else (
    echo [INFO] Project has been opened in IntelliJ IDEA before.
    set "FIRST_TIME=false"
)
echo.

:: Create or update run configuration
if "%FIRST_TIME%"=="false" (
    echo Attempting to create/update run configuration...
    
    :: Check if run configurations directory exists
    if not exist "%IDEA_CONFIG_DIR%\runConfigurations" (
        mkdir "%IDEA_CONFIG_DIR%\runConfigurations"
    )
    
    :: Create Spring Boot run configuration XML
    echo Creating Spring Boot run configuration...
    (
        echo ^<component name="ProjectRunConfigurationManager"^>
        echo   ^<configuration default="false" name="QuickFlicksPayment" type="SpringBootApplicationConfigurationType" factoryName="Spring Boot"^>
        echo     ^<module name="payment" /^>
        echo     ^<option name="SPRING_BOOT_MAIN_CLASS" value="com.quickflicks.payment.QuickFlicksPaymentApplication" /^>
        echo     ^<option name="ALTERNATIVE_JRE_PATH" /^>
        echo     ^<method v="2"^>
        echo       ^<option name="Make" enabled="true" /^>
        echo     ^</method^>
        echo   ^</configuration^>
        echo ^</component^>
    ) > "%IDEA_CONFIG_DIR%\runConfigurations\QuickFlicksPayment.xml"
    
    echo [OK] Run configuration created/updated.
    echo.
)

:: Open the project in IntelliJ IDEA
echo Opening QuickFlicksPayment in IntelliJ IDEA...
echo.
start "" "!IDEA_EXE!" "%PROJECT_DIR%\pom.xml"

:: Display instructions
echo ===================================================
echo    INSTRUCTIONS FOR RUNNING THE APPLICATION
echo ===================================================
echo.
echo Once IntelliJ IDEA opens:
echo.
echo 1. Wait for the project to be imported (this may take a few minutes)
echo.

if "%FIRST_TIME%"=="true" (
    echo 2. Create a Run Configuration:
    echo    - Click on "Add Configuration" in the top-right corner
    echo    - Click the "+" button and select "Spring Boot"
    echo    - Set the Name to "QuickFlicksPayment"
    echo    - Set the Main class to "com.quickflicks.payment.QuickFlicksPaymentApplication"
    echo    - Ensure JRE is set to Java 21 or higher
    echo    - Click "Apply" and "OK"
) else (
    echo 2. Select the Run Configuration:
    echo    - In the top-right dropdown, select "QuickFlicksPayment"
    echo    - If it's not there, follow the manual configuration steps:
    echo      a. Click on "Add Configuration"
    echo      b. Click the "+" button and select "Spring Boot"
    echo      c. Set the Name to "QuickFlicksPayment"
    echo      d. Set the Main class to "com.quickflicks.payment.QuickFlicksPaymentApplication"
    echo      e. Ensure JRE is set to Java 21 or higher
    echo      f. Click "Apply" and "OK"
)
echo.
echo 3. Run the application:
echo    - Click the green "Run" button (▶) in the top-right corner
echo    - Wait for the application to start
echo.
echo 4. Access the application:
echo    - Open a web browser
echo    - Navigate to http://localhost:8081
echo.
echo ===================================================
echo.
echo Press any key to close this window...
pause > nul

endlocal
exit /b 0
