#!/bin/bash

echo "all arguments passed in script : $@"
echo "all arguments passed in script : $*"
echo "show the script name : $0"
echo "current home folder of script : $HOME"
echo "current working directory of script : $PWD"
echo "who is running the script : $USER"
echo "PID of running script : $$"
sleep 10 &
echo "PID last command of script : $!"