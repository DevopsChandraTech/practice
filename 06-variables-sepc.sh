#!/bin/bash

echo "total number of arguments passed into script : $@"

echo "total number of arguments passed into script : $*"

echo "name of the current script : $0"

echo "home directory of current script : $HOME"

echo "present working directory of script : $PWD"

echo "which user running this script : $USER"

echo "PID of current script : $$"

sleep 40 & # this command running the baground of script

echo "last command PID of running script : $!"
