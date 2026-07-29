#!/bin/bash

NUMBER=$1

if [ $(($NUMBER%2)) -eq 0 ]; then
    echo "given number $1 is Even"
else
    echo "Given number $1 is not Even"
fi
