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

REM Get the directory path from the user
set /p dir=Enter the directory path: 

REM Get the prefix from the user
set /p prefix=(Optional) Enter the prefix: 

REM Initialize the counter
set /a counter=1

REM Loop through each file in the directory
for %%f in (%dir%\*) do (
    REM Get the extension of the file
    set "ext=%%~xf"

    REM Rename the file with the prefix, the counter, and the original extension
    ren "%%f" "!prefix!!counter!!ext!"

    REM Increment the counter
    set /a counter+=1
)
pause
endlocal