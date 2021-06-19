#!/bin/bash

cat ./config.py | grep BADCHARS | cut -d "[" -f2 | cut -d "]" -f1 > badchars.txt
sed -i 's/0x/\\x/g' badchars.txt
sed -i 's/,//g' badchars.txt
sed -i 's/\ //g' badchars.txt
BADCHARS=$(cat ./badchars.txt)

echo ""
echo "Using mona,"
echo "-----------"
echo '!mona jmp -r esp -cpb "'$BADCHARS'"'
echo ""
