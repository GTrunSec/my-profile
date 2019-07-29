#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

command -v ansible-playbook >/dev/null 2>&1 || { echo >&2 "I require ansible but it's not installed.  Aborting."; exit 1; }

if [[ -z ${1+x} ]]
then
    echo "Please choose a tag to install as param:"
    ansible-playbook -i "localhost," -c local install.yml --list-tags
    exit 1
fi

echo "### LIST TASKS #################################################################"

ansible-playbook -i "localhost," -c local install.yml --list-tasks -t $1 | grep TAGS | egrep -v 'play|debug|include_role' | sed 's/\ *\(.*\)TAGS.*$/\1/'

echo "Do you want to dryrun ? (y/N)"
read ok
ok=${ok:-N}

if [[ "$ok" == "y" ]]
then
    echo "### DRYRUN ###################################################################"
    ansible-playbook -i "localhost," -c local install.yml --ask-become-pass -CD -t $1 || exit 1
fi

echo "Do you want to install ? (Y/n)"
read ok
ok=${ok:-Y}

if [[ "$ok" == "Y" ]]
then
    echo "### RUN ####################################################################"
    ansible-playbook -i "localhost," -c local install.yml --ask-become-pass -t $1 || exit 1
fi
