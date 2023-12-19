#!/bin/bash

# Check if the MSP432P4111_HEADERS environment variable is set
if [ -z "${MSP432P4111_HEADERS}" ]; then
    echo "Error: MSP432P4111_HEADERS environment variable is not set."
    exit 1
fi

# Generate the .clangd file from the template
sed "s|{SIMPLELINK_MSP432_SDK_INSTALL_DIR}|$MSP432P4111_HEADERS|" clangd-template.yaml > .clangd

echo ".clangd file generated successfully."
