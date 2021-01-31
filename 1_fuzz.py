#!/usr/bin/env python2
from __future__ import print_function
import sys, socket
from time import sleep
from config import *

buffer = "A" * 100

while True:
        try:
		connect(buffer)
                sleep(1)
                buffer = buffer + "A"*100

        except:
                print("Fuzzing crashed at %s bytes" % str(len(buffer)))
                exit()
