#! /bin/bash
printf "Warning : it will replace your actual vim configuration !\n\nProceed ? (y/n) "
read r
if [[ "$r" == "y" ]]; then
    printf "Copying vim configuration...\n\n"
    if cp -r .vim* ~/; then
        printf "done.\n\n"
    else
        printf "/!\ Error /!\ \n\n"
        exit 2
    fi
    printf "****** Headers (.c & Makefile) ******\n\nEnter your login : "
    read login
    printf "\nEnter your name : "
    read name
    printf "\nEnter your email : "
    read email
    printf "\n\nIf you want to use .c headers, add these lines in your .bashrc:"
    printf "\nexport VIM_NICK=\"$login\"\nexport VIM_NAME=\"$name\"\nexport VIM_EMAIL=\"$email\"\n\nDone.\n"
else
    exit 1
fi
exit 0
