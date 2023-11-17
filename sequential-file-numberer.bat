@echo off

ECHO.
ECHO ############################################################
ECHO ##                                                        ## 
ECHO ##            Sequential File Numberer                    ##
ECHO ##            Version 1.0.1 16/11/2023                    ##
ECHO ##                                                        ##
ECHO ## https://github.com/declan1080/sequential-file-numberer ##
ECHO ##                                                        ## 
ECHO ############################################################
ECHO.

setlocal EnableDelayedExpansion

:menu
REM Display the menu
ECHO.
ECHO Select an option:
ECHO 1. Rename files in current directory
ECHO 2. Rename files in a specific directory
set /p option=Enter option number: 
ECHO.
REM Check the selected option and execute the corresponding code
if %option% equ 1 (
    set "dir=%cd%"
) else if %option% equ 2 (
    set /p dir=Enter the directory path: 
) else (
    ECHO Invalid option selected.
    cls
    goto menu
)

REM Check if the directory exists and the user has write access
if not exist "%dir%" (
    ECHO The directory does not exist.
    goto menu
) else (
    >nul 2>nul copy /b "%dir%\nul" "%dir%\testfile" && (
        del "%dir%\testfile"
    ) || (
        ECHO You do not have write access to the directory.
        goto menu
    )
)

REM Get the prefix from the user
set /p prefix=(Optional) Enter the prefix: 

REM Get the file type filter from the user
set /p fileTypeFilter=(Optional) Enter the file type filter (e.g. *.txt): 

REM Initialize the counter
set /a counter=1

REM Loop through each file in the directory
for %%f in ("%dir%\%fileTypeFilter%") do (
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

REM Display the number of files renamed
ECHO.
ECHO Files renamed: %counter%
goto menu
endlocal