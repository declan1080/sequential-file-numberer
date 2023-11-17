@echo off

ECHO.
ECHO ############################################################
ECHO ##                                                        ## 
ECHO ##            Sequential File Numberer                    ##
ECHO ##            Version 1.0.1 17/11/2023                    ##
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
set /p prefix=(Optional) Enter the prefix (e.g. GIT): 

REM Get the file type filter from the user
set /p fileTypeFilter=(Optional) Enter the file type filter (e.g. *.txt): 

REM Get the starting number from the user
set /p startNumber=(Optional) Enter the starting number (e.g 5): 

REM Initialize the counter
set /a counter=%startNumber%
ECHO.
REM Loop through each file in the directory
for %%f in ("%dir%\%fileTypeFilter%") do (
    REM Get the extension of the file
    set "ext=%%~xf"

    REM Check if the file is not the script file
    if not "%%~nxf" == "sequential-file-numberer.bat" (
        REM Preview the file name change
        ECHO Renaming "%%f" to "!prefix!!counter!!ext!"

        REM Increment the counter
        set /a counter+=1
    )
)
ECHO.
REM Ask for confirmation before renaming files
set /p confirm=Do you want to proceed with the file renaming? (Y/N): 
if /i "%confirm%"=="Y" (
    REM Loop through each file in the directory again and rename the files
    set /a counter=%startNumber%
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
) else (
    ECHO File renaming cancelled.
)

goto menu
endlocal