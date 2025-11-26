# Exercise 9: Security Best Practices

## Task 9.1: Check for Users with Empty Passwords
# Check /etc/shadow for empty passwords
sudo awk -F: '$2 == "" {print $1}' /etc/shadow

# If any found, they're security risks


## Task 9.2: Find Users with UID 0 (Should Only Be Root)
# Check for UID 0 users
awk -F: '$3 == 0 {print $1}' /etc/passwd

# Should only show: root


## Task 9.3: Check Password Expiration
# List password expiration for all users
sudo bash -c 'for user in $(cut -d: -f1 /etc/passwd); do passwd -S $user 2>/dev/null; done' | grep -v "L "
