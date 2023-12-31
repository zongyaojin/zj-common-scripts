#!/bin/bash

# Exit on failure
set -e

# Script file abolute path with filename
script_file=$(realpath "$0")
# Script file absolute path
script_absolute_path=$(dirname "$script_file")
# Script fiename
filename=$(basename "$script_file")

# Usage prompt
usage_prompt() {
    echo -e "Bash script"
    echo -e "   $script_file\n"
    echo -e "Usage:"
    echo -e "   bash $filename [options]\n"
    echo -e "Options:"
    echo -e "   -h  Print usage."
    echo -e "   -a  Requires an argument."
    echo -e "   -b  Dose not require any argument."
    echo -e "   -c  Requires an argument."
    echo -e "   -d  Does not require any argument."
}

# Invalid option or argument prompt
invalid_input_prompt() {
    echo -e "Error!"
    echo -e "   Invalid options or missing mandatory arguments.\n"
    echo -e "For more information:"
    echo -e "   bash $filename -h"
}

# Argument parsing, starts with a colon (removing it doesn't seem to have any effect...);
#   followed by options with a colon (such as a and c, require an argument),
#   or without a colon (such as b and d, do not require any arguments).
while getopts ":ha:bc:d" option; do
    case $option in
        h)
            usage_prompt
            exit
            ;;
        a)
            a_argument=$OPTARG
            ;;
        b)
            b_argument="option b doesn't need an argument"
            ;;
        c)
            c_argument=$OPTARG
            ;;
        d)
            d_argument="option d doesn't need an argument"
            ;;
        *)
            invalid_input_prompt
            exit
            ;;
    esac
done

# Shift to remove processed options
shift "$((OPTIND - 1))"

# Store the remaining arguments
remaining_arguments=$@

# Print results
echo -e "a_argument: $a_argument"
echo -e "b_argument: $b_argument"
echo -e "c_argument: $c_argument"
echo -e "d_argument: $d_argument"
echo -e ""
echo -e "remaining_arguments: $remaining_arguments"
echo -e ""
echo -e "File name: $filename"
echo -e "Script absolute path: $script_absolute_path"
echo -e "Script absolute path and filename: $script_file"
