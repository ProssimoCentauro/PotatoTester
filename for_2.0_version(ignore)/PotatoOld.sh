#!/bin/bash

user_dir="./user_scripts"
exp_dir="./expected_files"


declare -a user_scripts_arr=()
declare -a positions_arr=()

create_arr()
{
    local file="$1"
    local file_name=$("$file" | sed 's/[^a-zA-Z0-9_]//g')
    local arr_name="arr_$file_name"
}

for file in "$user_dir"/*; do
    if [ -f "$file" ]; then
        user_scripts_arr+=("$file")
    fi
done

for file in "$exp_dir"; doù


for file in "${user_scripts_arr[@]}"; do
    echo "$(basename "$file")"
done


#for file in "$exp_dir"/*; do


#select_expected_output()
#{
#    for arg in "$@"; do
#
#}


#ls user_scripts
#if diff "expected_outputs/test" "expected_outputs/test2" > /dev/null; then
#    echo "\033[1;4;32mVALID!\033[0m"
#fi
