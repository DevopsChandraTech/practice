#!/bin/bash

echo "Enter the Number"
read NUMBER

if [ $NUMBER -lt 10 ]; then
    echo "given number $NUMBER lessthan 10"
elif [ $NUMBER -eq 10 ]; then
    echo "given number $NUMBER equal to 10"
else
    echo "given number greater than 10"
fi
