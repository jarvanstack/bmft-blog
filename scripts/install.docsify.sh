#!/bin/bash

# Install docsify
if which docsify >/dev/null
then
    printf "docsify already installed\n"
else
    npm install -g docsify-cli@latest
    printf "docsify installed successfully\n"
fi
docsify -v


