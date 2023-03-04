#!/bin/bash

# Install gitbook-summary
if which gitbook-summary > /dev/null
then
    printf "gitbook-summary already installed\n"
else
    # If have golang installed, use go install
    if which go > /dev/null
    then
        go install github.com/dengjiawen8955/gitbook-summary@latest
    else
        # Download binary from github.com/dengjiawen8955/gitbook-summary/bin
        set -e
        wget https://github.com/dengjiawen8955/gitbook-summary/raw/master/bin/gitbook-summary
        sudo mv gitbook-summary /usr/local/bin
        sudo chmod +x /usr/local/bin/gitbook-summary
    fi
    printf "gitbook-summary installed successfully\n"

fi

gitbook-summary -v
