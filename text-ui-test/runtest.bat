@ECHO OFF

REM create bin directory if it doesn't exist
REM if not exist ..\bin mkdir ..\bin

cd ../

call gradlew shadowJar

cd text-ui-test

REM delete output from previous run
if exist ACTUAL.TXT del ACTUAL.TXT

REM compile the code into the bin folder 
REM javac  -cp ..\src -Xlint:none -d ..\bin ..\src\main\java\seedu.duke.Duke.java
IF ERRORLEVEL 1 (
    echo ********** BUILD FAILURE **********
    exit /b 1
)
REM no error here, errorlevel == 0

REM run the program, feed commands from input.txt file and redirect the output to the ACTUAL.TXT
java -jar ..\build\libs\duke-0.1.3.jar < input.txt > ACTUAL.TXT

REM compare the output to the expected output
FC ACTUAL.TXT EXPECTED.TXT
