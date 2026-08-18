#!/bin/bash

# check the number divided by even or not

echo "enter the number"

read "NUMBER"

if [ $((NUMBER%2)) -eq 0 ]; then
    echo "Given Number $NUMBER is Even."
else 
    echo "Given Number $NUMBER is Not Even."
fi