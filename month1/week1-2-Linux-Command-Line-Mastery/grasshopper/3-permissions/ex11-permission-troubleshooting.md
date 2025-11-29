# Exercise 11: Permission Troubleshooting


## Common Problems and Solutions
cat > permission-troubleshooting.txt << 'EOF'
=== Permission Troubleshooting Guide ===

PROBLEM: "Permission denied" when reading file
CHECK: ls -l filename
SOLUTION: chmod u+r filename (add read permission)

PROBLEM: "Permission denied" when executing script
CHECK: ls -l script.sh
SOLUTION: chmod +x script.sh (add execute permission)

PROBLEM: Can't modify file you own
CHECK: ls -l filename
SOLUTION: chmod u+w filename (add write permission)

PROBLEM: Can't cd into directory
CHECK: ls -ld dirname
SOLUTION: chmod u+x dirname (directories need execute to enter)

PROBLEM: Can't list directory contents
CHECK: ls -ld dirname
SOLUTION: chmod u+r dirname (directories need read to list)

PROBLEM: Can't delete file in directory you don't own
CHECK: ls -ld directory
SOLUTION: Need write permission on directory, not the file

PROBLEM: Script runs but can't create files
CHECK: umask
SOLUTION: umask 0022 (set appropriate default permissions)
EOF

cat permission-troubleshooting.txt
