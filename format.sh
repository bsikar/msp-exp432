#!/bin/bash

# Check if .clang-format file exists in the current directory
if [ ! -f .clang-format ]; then
    echo ".clang-format file not found in the base directory."
    exit 1
fi

# Find and format all .h and .c files
find . -type f \( -name "*.h" -o -name "*.c" \) \
    -exec sh -c 'echo "Formatting $1"; clang-format -i "$1"' _ {} \;

echo "Formatting complete."
