#!/bin/bash

# read NUM

# if (($NUM % 2 == 0)); then
#     echo "given number $NUM is even."
# else
#     echo "given number is not an even."
# fi

# check the number is greater than 10

NUMBER=$1

if [ $NUMBER -gt 10 ]; then
    echo "given number $NUMBER is greaterthan 10"
elif [ $NUMBER -eq 10 ]; then
    echo "given number $NUMBER is equals to 10."
else    
    echo "given number $NUMBER is lessthan 10."
fi
