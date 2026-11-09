#!/bin/bash

echo "the script start and executed time"

START_TIME=$(date +%s)

sleep 10

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME - $START_TIME))

echo "the script executed in $TOTAL_TIME Secs."