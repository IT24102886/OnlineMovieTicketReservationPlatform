@echo off
echo Installing Lombok to local Maven repository...
call mvnw.cmd install:install-file -Dfile=lombok-1.18.30.jar -DgroupId=org.projectlombok -DartifactId=lombok -Dversion=1.18.30 -Dpackaging=jar
echo Done!
