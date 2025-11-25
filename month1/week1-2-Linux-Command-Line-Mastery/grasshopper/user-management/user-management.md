# User Management

## Users and Groups
In any multi-user operating system, managing users and groups is a fundamental concept. 
This is a core part of the basics of linux, designed for access control and permissions. 
When a process runs, it does so as the user who started it. 
Likewise, file access and ownership are dependent on permissions, preventing one user from accessing another's private documents.

## root
In Linux, certain administrative tasks require elevated privileges. 
These privileges belong to a special account known as the root user in Linux. 
While you can log in directly as root, it is often safer and more manageable to gain superuser access temporarily.

## /etc/passwd
In Linux, usernames are human-readable labels, but the system identifies users with a unique User ID (UID). 
The mapping between usernames and UIDs is stored in the /etc/passwd file, a critical component for user management.

## /etc/shadow
The /etc/shadow file is a critical component in Linux systems for storing sensitive user authentication information. 
Unlike the world-readable /etc/passwd file, it requires superuser privileges to access, 
providing a secure location for password data.

## /etc/group
In Linux, managing permissions for multiple users is streamlined through the use of groups. 
The central file for this is /etc/group, which defines the groups on the system and their members.

## User Management Tools
While many enterprise environments rely on dedicated systems for identity management, understanding the fundamentals of Linux user 
management directly on a single machine is a crucial skill. 
Several utilities serve as the command-line tool for managing accounts in Linux, allowing for efficient administration 
from the terminal.


