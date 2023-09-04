#!/usr/bin/python

import sys
import os

folder = "~/dotfiles2"
editor = "$EDITOR"

a = sys.argv[1]
os.system(f"cd {folder}/{a}/.config/{a}; {editor} ./") 
