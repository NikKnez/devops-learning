# Exercise 9: Complete Permission Matrix


## Create Reference Chart
cat > complete-permissions.txt << 'EOF'
=== Complete Linux Permission Reference ===

BASIC PERMISSIONS (rwx):
r (4) = Read
w (2) = Write  
x (1) = Execute

SPECIAL PERMISSIONS:
setuid (4000) = Run as file owner
setgid (2000) = Run as file group (files) or inherit group (directories)
sticky (1000) = Only owner can delete

NUMERIC FORMAT:
[special][owner][group][other]

Examples:
0644 = -rw-r--r--  (normal file)
0755 = -rwxr-xr-x  (executable/directory)
0777 = -rwxrwxrwx  (everyone full access - dangerous)
4755 = -rwsr-xr-x  (setuid executable)
2755 = -rwxr-sr-x  (setgid executable)
1777 = drwxrwxrwt  (sticky directory like /tmp)
6755 = -rwsr-sr-x  (setuid + setgid)

COMMANDS:
chmod = Change permissions
chown = Change owner
chgrp = Change group
umask = Set default permissions for new files

SYMBOLIC chmod:
u = user/owner
g = group
o = others
a = all

+ = add permission
- = remove permission
= = set exact permission

Examples:
chmod u+x file        # Add execute for owner
chmod g-w file        # Remove write for group
chmod o=r file        # Set others to read-only
chmod a+x file        # Add execute for all
chmod u=rwx,go=rx fi  # Set exact permissions
EOF

cat complete-permissions.txt
