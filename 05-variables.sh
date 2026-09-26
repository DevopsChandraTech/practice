#!/bin/bash

echo "the script executed and started"
START_TIME=$(date +%s)

sleep 10

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME - $START_TIME))

echo "the script execution time is: $TOTAL_TIME Secs."
