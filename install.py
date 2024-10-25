#!/usr/bin/env python3
from os.path import expanduser
from os import symlink
from platform import system

home_dir = expanduser("~")
if(system() == "Windows"):
    nvim_config_dir = f"{home_dir}/AppData/Local/nvim"
elif(system() == "Linux"):
    nvim_config_dir = f"{home_dir}/.config/nvim"
else:
    raise Exception("Unknown platform")

symlink(f"{home_dir}/dotfiles/init.vim",f"{nvim_config_dir}/init.vim")
