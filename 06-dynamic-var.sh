#!/bin/bash

START_TIME=$(date +%s) # $() executes inside the command and gives the output

sleep 10 

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME - $START_TIME))

echo "the script executed in $TOTAL_TIME Secs."
