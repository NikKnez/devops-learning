# User Management Notes

### View Users
- `cat /etc/passwd` - All users
- `whoami` - Current user
- `id` - Current user details
- `id username` - Specific user details

### Create Users
- `sudo useradd username` - Create user
- `sudo useradd -m username` - Create with home directory
- `sudo passwd username` - Set password

### Modify Users
- `sudo usermod -aG group user` - Add to group
- `sudo usermod -s /bin/bash user` - Change shell
- `sudo usermod -l newname oldname` - Rename user

### Delete Users
- `sudo userdel username` - Delete user
- `sudo userdel -r username` - Delete user and home directory

### Groups
- `groups username` - Show user's groups
- `sudo groupadd groupname` - Create group
- `sudo groupdel groupname` - Delete group

## Important Files
- `/etc/passwd` - User database
- `/etc/shadow` - Encrypted passwords
- `/etc/group` - Group database

## What I Learned
[Learned to create and delete users and groups. Also learned to check security issues.]

## Mistakes Made
[Biggest problems encourted with sudo, mainly forgot to type sudo, also some typos and learned not to rush.]
