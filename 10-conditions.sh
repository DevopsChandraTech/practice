# check if given number is even or not
echo "please enter the number:"
read NUMBER

if [ $(($NUMBER / 2)) -eq 0 ]; then
    echo "Given number $NUMBER is Even."
else
    echo "Given number is not an Even"
fi

