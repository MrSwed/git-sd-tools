#!/bin/bash

export LANGUAGE=en_US

if [ "$1" == "changed" ]; then
 $0 2>&1 |  grep -vE '\[up to date\]|^Fetching origin$|^From.*$'
else
 find -L ./ -name .git -printf "\n%h\n" -execdir git fetch --all -v --progress \; -execdir git pull --ff-only --tag --all \;
fi
