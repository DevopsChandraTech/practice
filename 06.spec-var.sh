#!/bin/bash

echo "this script run and executed $(date)"

START_TIME=$(date +%s)

sleep 10

END_TIME=$(date +%s)

TOTAL_TIME=$($END_TIME - $START_TIME)

echo "the script execution total time is: $TOTAL_TIME Secs."
