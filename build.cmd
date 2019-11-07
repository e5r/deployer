@echo off

:: Copyright (c) E5R Development Team. All rights reserved.
:: Licensed under the Apache License, Version 2.0. More license information in LICENSE.txt.

set MAIN=.\src\main.py

where pyinstaller 2>nul >nul
IF ERRORLEVEL 1 (
    echo PyInstaller not installed!
    echo Run:
    echo ^ ^ C:^\^> pip install -r requirements.txt
    exit /b 1
)

pyinstaller --onefile --console -n deployer %MAIN%
IF ERRORLEVEL 1 (
    echo Build failed.
    exit /b %ERRORLEVEL%
)

echo To test, exec: .\dist\deployer.exe

