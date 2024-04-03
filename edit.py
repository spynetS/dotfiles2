#!/usr/bin/python

import sys
import os

folder = "~/dotfiles2"
editor = "nvim"

a = sys.argv[1]
path = f"{folder}/{a}/.config/{a}"

if os.path.isfile(path):
    os.system(f"editor {path}") 
else :
    os.system(f"cd {path}; {editor} ./") 
