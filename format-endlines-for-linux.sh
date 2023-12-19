#!/bin/bash

find . -type f -not -path '*/.git/*' -print0 | \
    xargs -0 -P8 -I {} sh -c 'echo "Fixing Endlines for {}"; sed -i "s/\r//" "{}"'

