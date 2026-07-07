#!/bin/bash

echo "pls enter your number"
read NUMBER

if [ $(($NUMBER % 2)) -eq 0 ]; then
    echo "given number $NUMBER is even."
else
    echo "given number $NUMBER not even"
fi
