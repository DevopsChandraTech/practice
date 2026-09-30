#!/bin/bash
# check given number lessthan or equal or greaterthan 10

NUMBER=$1
if [ $NUMBER -lt 10 ]; then
    echo "given number $NUMBER is lessthan 10"
elif [ $NUMBER -eq 10 ]; then
    echo "given number $NUMBER is equal to 10"
else
    echo "given number $NUMBER is greaterthan 10"
fi