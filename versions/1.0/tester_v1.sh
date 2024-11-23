#!/bin/sh

cd "$(dirname "$0")"
scripts_dir="./user_scripts"
out_dir="./user_outputs"
exp_dir="./expected_output"

expected_output="$(ls "$exp_dir" | head -n 1)"

check_file()
{
    local file="$1"
    basename=$(basename "$file")

    case "$file" in
        *.c)
            gcc "$file" -o "$basename.out"
            if [ $? -eq 0 ]; then
                ./"$basename.out" > "$out_dir/$basename.output"
                rm "$basename.out"
            else
                echo "$basename \033[1m\033[4m\033[31mdoes not compile!\033[0m"
            fi
            ;;
        *.cpp)
            g++ "$file" -o "$basename.out"
            if [ $? -eq 0 ]; then
                ./"$basename.out" > "$out_dir/$basename.output"
                rm "$basename.out"
            else
                echo "$basename \033[1m\033[4m\033[31mdoes not compile!\033[0m"
            fi
            ;;
        *.py)
            python3 "$file" > "$out_dir/$basename.output"
            ;;
        *)
            ./$file > "$out_dir/$basename.output"
    esac
}

check_diff()
{
    file1="$1"
    file2="$2"
    basename="$3"

    if diff $file1 $file2 > /dev/null; then
        echo "$basename is \033[1m\033[4m\033[32mVALID!\033[0m"
    else
        echo "$basename is \033[1m\033[4m\033[31mKO\033[0m"
    fi
}


for file in "$scripts_dir"/*; do
    check_file "$file"
done

for file in "$out_dir"/*; do
    basename=$(basename "$file" .output)
    check_diff "$file" "$exp_dir/$expected_output" "$basename"
done
