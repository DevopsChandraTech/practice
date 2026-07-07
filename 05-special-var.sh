#!/bin/bash

echo "all arguments passed into script : $@"
echo "all arguments passed into script : $*"
echo "how many arguments passed into script : $#"
echo "who is running the Script : $USER"
echo "current working directroy of script : $PWD"
echo "home folder of current script : $HOME"
echo "PID of current script : $?"

sleep 10&
echo "PID of last command of current script : $$"