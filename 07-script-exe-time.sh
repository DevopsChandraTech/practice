#!/bin/bash

echo "the script started exucuted"
START_TIME=$(date +%s)

sleep 20&

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME - $START_TIME))

echo "the script executed in : $TOTAL_TIME Secs."