#!/bin/bash

echo "all arguments run into the script : $@"
echo "all arguments run into the script : $*"
echo "how many arguments passed into script : $#"
echo "current script name is : $0"
echo "home directory of the script : $HOME"
echo "current user of the script : $USER"
echo "currect working directory of the script : $PWD"
echo "PID of the script : $$"
sleep 10 &
echo "PID of the last command : $!"
