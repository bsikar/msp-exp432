#!/bin/bash

# Check if .clang-format file exists in the current directory
if [ ! -f .clang-format ]; then
    echo ".clang-format file not found in the base directory."
    exit 1
fi

# Find and format all .h and .c files using parallel execution
find . -type f ! -path "./keil-ide/*" ! -path "./examples/*" \( -name "*.h" -o -name "*.c" \) -print0 | \
    xargs -0 -P8 -I {} sh -c 'echo "Formatting {}"; clang-format -i "{}"'

find . -type f ! -path "./keil-ide/*" ! -path "./examples/*" \( -name "*.s" \) -print0 | \
    xargs -0 -P8 -I {} sh -c 'echo "Formatting {}"; asmfmt -w "{}"'


echo "Formatting complete."
