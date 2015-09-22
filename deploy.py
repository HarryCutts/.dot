#!/usr/bin/python

from __future__ import print_function
try: raw_input
except NameError: raw_input = input

import sys
import os
from os.path import expanduser, join
import shutil

home_path = expanduser('~')
link_templates_path = expanduser('~/.dot/link-templates')

home = os.listdir(home_path)
link_templates = os.listdir(link_templates_path)

valid_choices = ['r', 's', 'b', '']

for file_name in link_templates:
    if file_name[0] == '.': continue

    target_path = join(home_path, '.' + file_name)

    if '.'+file_name in home:
        prompt = "There is already a file named ." + file_name + ". Replace, skip, or back up? [r/S/b] "
        choice = raw_input(prompt).lower()
        while choice not in valid_choices:
            print("Please enter either 'r', 's', or 'b', or press ENTER to skip.")
            choice = raw_input(prompt).lower()

        if choice == 'r':
            shutil.copy2(join(link_templates_path, file_name), target_path)
            print("Replaced ." + file_name)
        elif choice == 's' or choice == '':
            print("Skipped ." + file_name)
            continue
        elif choice == 'b':
            # TODO: handle the `.old` file existing as well
            shutil.move(target_path, target_path + '.old')
            shutil.copy2(join(link_templates_path, file_name), target_path)
            print("Backed up ." + file_name, "to ." + file_name + '.old')

    else:
        shutil.copy2(join(link_templates_path, file_name), target_path)

## Special cases ##
# lesskey
os.system('lesskey ~/.dot/files/lesskey')
