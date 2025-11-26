#!/bin/bash

# User Management Script
# Author: Nikola Knezevic

echo "=== User Management Tool ==="
echo ""
echo "1. Create new user"
echo "2. Delete user"
echo "3. Add user to group"
echo "4. List all users"
echo "5. List user info"
echo "6. Exit"
echo ""

read -p "Select option (1-6): " option

case $option in
     1)
        read -p "Enter username: " username
        read -p "Create home directory? (y/n): " create_home
        if [ "$create_home" = "y" ]; then
            sudo useradd -m -s /bin/bash "$username"
        else
            sudo useradd -s /bin/bash "$username"
        fi

        echo "User $username created"
        read -p "Set password? (y/n): " set_pass

	if [ "$set_pass" = "y" ]; then
	    sudo passwd "$username"
	fi
	;;

     2)
	read -p "Enter username to delete: " username
	read -p "Delete home directory? (y/n): " del_home

	if [ "$del_home" = "y" ]; then
	    sudo userdel -r "$username"
	else
	    sudo userdel "$username"
	fi

	echo "User $username deleted"
	;;

     3)
	read -p "Enter username: " username
	read -p "Enter group name: " groupname
	sudo usermod -aG "$groupname" "$username"
	echo "User $username added to group $groupname"
	;;

     4)
	echo "=== All Users ==="
	awk -F: '$3 >= 100 {print $1, "UID:", $3}' /etc/passwd
	;;

     5)
	read -p "Enter username: " username
	echo "=== User Info: $username ==="
	id "$username"
	echo "Groups:"
	groups "$username"
	echo "Home directory:"
	grep "^$username:" /etc/passwd | cut -d: -f6
	echo "Shell:"
	grep "^$username:" /etc/passwd | cut -d: -f7
	;;

     6)
	echo "Exiting..."
	exit 0
	;;

     *)
	echo "Invalid option"
	exit 1
	;;
esac









































