#!/bin/bash

NUMBER1=100
NUMBER2=200

NAME="CHANDU"

FAMILY=("Amma" "Chandu" "Anu" "Gnaipka" "Hansith")

SUM=$(($NUMBER1 + $NUMBER2 + $NAME))

echo "the sum is : $SUM"
echo "head of the family is : ${FAMILY[0]}"
echo "eledest of the family is : ${FAMILY[4]}"
