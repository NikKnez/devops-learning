# Exercise 3: Understanding /etc/passwd

## Task 3.1: Explore /etc/passwd Structure
# View the file
cat /etc/passwd

# View with line numbers
cat -n /etc/passwd

# Your user's entry
grep "^nikola:" /etc/passwd

# Understand the format:
# username:x:UID:GID:comment:home_dir:shell


## Task 3.2: Parse /etc/passwd
# Extract just usernames
cut -d: -f1 /etc/passwd

# Extract usernames and home directories
cut -d: -f1,6 /etc/passwd

# Find users with /bin/bash shell
grep "/bin/bash$" /etc/passwd

# Find system users (UID < 1000)
awk -F: '$3 < 1000 {print $1, "UID:", $3}' /etc/passwd

# Find human users (UID >= 1000)
awk -F: '$3 >= 1000 {print $1, "UID:", $3}' /etc/passwd

# Your user's details
grep "^nikola:" /etc/passwd | awk -F: '{
    print "Username:", $1
    print "UID:", $3
    print "GID:", $4
    print "Home:", $6
    print "Shell:", $7
}'



## Task 3.3: Analyze /etc/passwd
# Count users by shell type
cut -d: -f7 /etc/passwd | sort | uniq -c | sort -rn

# Find users with no login shell
grep "nologin" /etc/passwd | cut -d: -f1

# Create report
cat > passwd-analysis.txt << 'EOF'
=== /etc/passwd Analysis ===
Total users: 
Human users (UID >= 1000): 
System users (UID < 1000): 
Users with bash shell: 
Users with no login: 
EOF

# Fill in the numbers
echo "Total users: $(cat /etc/passwd | wc -l)" >> passwd-analysis.txt
echo "Human users: $(awk -F: '$3 >= 1000' /etc/passwd | wc -l)" >> passwd-analysis.txt
echo "System users: $(awk -F: '$3 < 1000' /etc/passwd | wc -l)" >> passwd-analysis.txt

cat passwd-analysis.txt










