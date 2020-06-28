#!/bin/bash
# Author: Captain_Crunch
# Script for adding new group and new user to the group

addNewGroup (){
    while true; do
    read -p "Enter Group Name: " new_group
    if groupadd $new_group; then
        echo -e "\x1B[01;92mNew Group Added ($new_group)\x1B[0m"
        return
    else
        echo -e "\033[1;31mPlease enter another Group Name\x1B[0m"
    fi
    done
}
addNewUser (){
    while true; do
    read -p "Enter New User: " new_user
    if useradd -g $new_group -s /bin/bash -m $new_user >&2; then
        echo "Enter Password for user ($new_user)"
        passwd $new_user
        echo -e "\x1B[01;92mNew User ($new_user) added to ($new_group) group\x1B[0m"
        createDir
        addAnotherUser
    else
        echo -e "\033[1;31mPlease enter another User Name\x1B[0m"
    fi    
    done
}
addAnotherUser (){
    read -p "Do you want want to add another user? Y/N: " anotherUser
    case $anotherUser in
    y|Y) addNewUser
    exit
    ;;
    n|N) echo "No"
    exit
    ;;
    *) echo "Invalid Entry" 
    addAnotherUser
    ;;
esac
}
createDir (){
    mkdir /$new_user
    chown $new_user:$new_group /$new_user
    chmod 1770 /$new_user
}

echo -e "\033[1;33m######### CREATE NEW GROUP ##########\x1B[0m"
addNewGroup

echo -e "\033[1;33m######### ADD NEW USER ##########\x1B[0m"
addNewUser



########################################################################
# To be added                                                          #
# Prevent user to input empty values when adding new group/user        #
########################################################################
