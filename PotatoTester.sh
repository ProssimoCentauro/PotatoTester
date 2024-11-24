resize -s 24 107 > /dev/null
stty rows 24 > /dev/null
stty cols 107 > /dev/null

print_menu()
{
    clear
    cat text_to_print/title

    echo "\n\033[1m\033[32mChoose the version of the Tester you want:\033[0m\n\n"
    echo "\033[1m\033[33m1) \033[0mVersion 1.0\n"
    echo "\033[1m\033[33m2) \033[0mVersion 2.0\n"
    echo "\033[1m\033[33mi) \033[0mversions info\n"
    echo "\033[1m\033[31me) \033[0mexit the program\n\n"
}

print_arrow()
{
    echo -n "\033[1m\033[35m_-_->\033[0m"
}

print_info()
{
    echo "The \033[1m\033[33mVersion 1.0\033[0m is for correction of multiple files that should have the same output.\n [\033[1m\033[32mFor example correcting a class of students on a single exercise\033[0m]\njust put the script files in \033[1m\033[36mversions/1.0/user_scripts\033[0m folder,\nand the expected output in \033[1m\033[36mversions/1.0/expected_output\033[0m folder.\n"

    echo "The \033[1m\033[33mVersion 2.0\033[0m is for correction of libraries or various functions.\njust put the script files in \033[1m\033[36mversions/2.0/user_scripts\033[0m folder,\nand the expected outputs in \033[1m\033[36mversions/2.0/expected_outputs\033[0m folder.\n\033[1m\033[31mThe files must have the same name!\033[0m\n [\033[1m\033[32mFor example ft_strlen.py in user_scripts and ft_strlen in expected outputs\033[0m]"

    echo -n "\n"
}

print_running_version()
{
    version="$1"

    echo "\033[1m\033[4m\033[32mRUNNING\033[0m\033[1m PotatoTester\033[0m \033[1m\033[33m"$version" Version\033[0m:\n"
}

v1="./versions/1.0/tester_v1.sh"
v2="./versions/2.0/tester_v2.sh"

print_menu
print_arrow

while true; do
    read input
    case $input in
        1)
            print_menu
            print_running_version "1.0"
            sh "$v1"
            echo -n "\n"
            print_arrow
            ;;
        2)
            print_menu
            print_running_version "2.0"
            sh "$v2"
            echo -n "\n"
            print_arrow
            ;;
        i)
            print_menu
            echo "\033[1m\033[33mPotatoTester \033[0m\033[1m\033[4m\033[35mMANUAL\033[0m:\n"
            print_info
            print_arrow
            ;;
        e)
            clear
            exit
            ;;
        *)
            echo "\033[1m\033[31mInvalid Command! \033[0m"
            sleep 1.5
            print_menu
            print_arrow
            ;;
    esac
done
