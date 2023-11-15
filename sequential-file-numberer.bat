@echo off

ECHO.
ECHO ############################################################
ECHO ##                                                        ## 
ECHO ##            Sequential File Numberer                    ##
ECHO ##            Version 1.0.0 15/11/2023                    ##
ECHO ##                                                        ##
ECHO ## https://github.com/declan1080/sequential-file-numberer ##
ECHO ##                                                        ## 
ECHO ############################################################
ECHO.

setlocal EnableDelayedExpansion

REM Display the menu
ECHO Select an option:
ECHO 1. Rename files in current directory
ECHO 2. Rename files in a specific directory
set /p option=Enter option number: 

REM Check the selected option and execute the corresponding code
if !option! == 1 (
    set "dir=%cd%"
) else if !option! == 2 (
    set /p dir=Enter the directory path: 
) else (
    ECHO Invalid option selected.
    pause
    exit /b
)

REM Get the prefix from the user
set /p prefix=(Optional) Enter the prefix: 

REM Initialize the counter
set /a counter=1

REM Loop through each file in the directory
for %%f in (%dir%\*) do (
    REM Get the extension of the file
    set "ext=%%~xf"

    REM Check if the file is not the script file
    if not "%%~nxf" == "sequential-file-numberer.bat" (
        REM Rename the file with the prefix, the counter, and the original extension
        ren "%%f" "!prefix!!counter!!ext!"

        REM Increment the counter
        set /a counter+=1
    )
)
pause
endlocal