#!/bin/bash

echo "all arguments passed into the script : $@"
echo "all arguments passed into the script : $*"
echo "how many arguments passed into the script : $#"
echo "name of the script : $0"
echo "current working directory of the script : $PWD"
echo "who is running the script : $USER"
echo "home folder of Current script : $HOME"
echo "process id of current script : $$"
sleep 10 & # running in the baground
echo "PID of last command : $!"
