#!/bin/bash

read NUM

if [ $(($NUM % 2)) -eq 0 ]; then
    echo "given number $NUM is even."
else
    echo "given number is not an even."
fi