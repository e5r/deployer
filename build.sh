#!/usr/bin/env bash
set -ou pipefail

# Copyright (c) E5R Development Team. All rights reserved.
# Licensed under the Apache License, Version 2.0. More license information in LICENSE.txt.

exists()
{
    if which $1 &>/dev/null; then
        return 0;
    else
        return 1
    fi
}

MAIN=./src/main.py

if ! exists pyinstaller; then
    echo "PyInstaller not installed!"
    echo "Run:"
    echo "  $ pip install -r requirements.txt"
    exit 1
fi

pyinstaller --onefile --console -n deployer ${MAIN}

if [ $? != 0 ]; then
    echo "Build failed."
    exit $?
fi

echo "To test, exec: ./dist/deployer"

