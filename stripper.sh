#!/bin/bash

# 
# Author: Anthony Kaparounakis for the OS Lab at dit.hua
# Task: Create a shell script that "strips" the comments of another shell script
# Usage: striper <filename> where filename is a shell script containing comments to be stripped
# # #


# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' 

# Input manipulation
ARGS=$#
readonly ARGS

FILENAME=$1
readonly FILENAME

SUFFIX="${FILENAME#*.}"
readonly SUFFIX


# Input check - if all checks are passed, it continues 
if [ $ARGS -ne 1 ] 
then
    echo ""
    echo -e "Usage: stripper ${RED}<filename.sh>${NC}"
    exit 1
fi

if [ "$SUFFIX" != "sh" ] 
then
    echo ""
    echo -e "Usage: stripper <filename${RED}.sh${NC}>"
    exit 1
fi

if [ ! -f "$FILENAME" ] 
then
    echo ""
    echo -e "Input: Non valid input. ${RED}File does not exist.${NC}"
    exit 1
fi

# All checks are passed, let's start stripping
# Use grep to strip any line beginning with a # character and pipe it's output to a new file called stripped.sh
grep -o '^[^#]*' "$FILENAME" > stripped.sh

echo ""
echo -e "${GREEN}Success!${NC} Your stripped file's name is ${RED}stripped.sh${NC} residing in this directory."
read -r -p "Do you want to open your stripped script in GNU nano? [Y/n]" NANOPROMPT

# toLowercase $NANOPROMPT for easier check
NANOPROMPT=$(echo "$NANOPROMPT" | tr '[:upper:]' '[:lower:]') # tr-anslate only ECHOES thhe result hence the "echo" command

# Switch case for every NANOPROMPT input
case $NANOPROMPT in
    
    y | ye | yes)
        nano stripped.sh
        exit 0
        ;;
    
    n | no)
        echo ""
        echo "Thank you for using stripper!"
        exit 0
        ;;
    *)
        echo ""
        echo -e "${RED}I did not get that.${NC}"
        echo "Exiting..."
        exit 0

esac
exit 1 # Last wall of defence