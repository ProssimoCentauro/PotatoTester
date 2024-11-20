#!/bin/sh

scripts_dir="./user_scripts"
out_dir="./user_outputs"
exp_dir="./expected_output"

expected_output="$(ls "$exp_dir" | head -n 1)"

check_file()
{
    local file="$1"

    case "$file" in
        *.c)
            basename=$(basename "$file")
            gcc "$file" -o "$basename.out"
            if [ $? -eq 0 ]; then
                ./"$basename.out" > "$out_dir/$basename.output"
                rm "$basename.out"
            else
                echo "$basename.c \033[1m\033[4m\033[31mdoes not compile!\033[0m"
            fi
            ;;
        *.py)
            basename=$(basename "$file")
            python3 "$file" > "$out_dir/$basename.output"
            ;;
        *)
            basename=$(basename "$file")
            ./$file > "$out_dir/$basename.output"
    esac
}

for file in "$scripts_dir"/*; do
    check_file "$file"
done

for file in "$out_dir"/*; do
    basename=$(basename "$file" .output)
    if diff $file $exp_dir/$expected_output > /dev/null; then
        echo "$basename is \033[1m\033[4m\033[32mVALID!\033[0m"
    else
        echo "$basename is \033[1m\033[4m\033[31mKO\033[0m"
    fi
done
