#!/bin/bash

read "please enter the number : NUMBER"

if [ $($NUMBER % 2) -eq 0 ]; then
    echo "given number $NUMBER is divided by 2"
else
    echo "given number $NUMBER not divided by2"
fi