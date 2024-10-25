#!/usr/bin/env python3
import sys
import os
from platform import system
import argparse

parser=argparse.ArgumentParser()
parser.add_argument("--force", action="store_true", help="Overwrite existing target files if they exist")
args=parser.parse_args()

home_dir = os.path.expanduser("~")
if(system() == "Windows"):
    nvim_config_dir = f"{home_dir}/AppData/Local/nvim"
elif(system() == "Linux"):
    nvim_config_dir = f"{home_dir}/.config/nvim"
else:
    raise Exception("Unknown platform")

def create_symlink(link, target):
    print(f"Symlinking {link} -> {target}...")
    if os.path.lexists(link) and args.force:
        print(f"\t{link} already exists. Overwriting it.")
        os.unlink(link)
        os.symlink(f"{target}",f"{link}") 
        print("\tDone")
    elif os.path.lexists(link):
        print(f"\t{link} already exists.")
    else:
        os.symlink(f"{target}",f"{link}") 
        print("\tDone")

create_symlink(link = f"{nvim_config_dir}/init.vim", 
               target = f"{home_dir}/dotfiles/init.vim")

