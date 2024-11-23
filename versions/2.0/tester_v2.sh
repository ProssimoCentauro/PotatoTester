#!/bin/sh


cd "$(dirname "$0")"
scripts_dir="./user_scripts"
out_dir="./user_outputs"
exp_dir="./expected_outputs"

check_file()
{
    local file="$1"
    local basename=$(basename "$file")

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
        return 0
    else
        echo "$basename is \033[1m\033[4m\033[31mKO\033[0m"
        return 1
    fi
}

for file in "$scripts_dir"/*; do
    check_file "$file"
done

for out in "$out_dir"/*; do
    out_basename=${out##*/}   # Leave only "hello_world.out.output"
    out_basename=${out_basename%%.*}  # Remove everything from the first dot onwards
    expanded_out_basename=$(basename "$out" .output)

    for expected in "$exp_dir"/*; do
        exp_basename=$(basename "$expected")

        if [ "$out_basename" = "$exp_basename" ]; then
            if check_diff "$out" "$expected" "$expanded_out_basename"; then
                break
            fi
        fi
    done
done
