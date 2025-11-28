# Exercise 4: Understanding /etc/shadow


## Task 4.1: View /etc/shadow (Requires sudo)
# Try without sudo (will fail)
cat /etc/shadow
# Permission denied (security!)

# View with sudo
sudo cat /etc/shadow

# View just your user's entry
sudo grep "^nikola:" /etc/shadow

# Format:
# username:encrypted_password:last_change:min:max:warn:inactive:expire


## Task 4.2: Understand Password Aging
# Check password status for your user
sudo passwd -S nikola
# Shows: Status, last change, min days, max days, warning, inactive

# Check for user 'root'
sudo passwd -S root

# Your task: Document the output
sudo passwd -S nikola > shadow-info.txt


## Task 4.3: Password Field Meanings
# Create reference document
cat > shadow-reference.txt << 'EOF'
=== /etc/shadow Field Meanings ===

Field 1: Username
Field 2: Encrypted password
  - $6$ = SHA-512 encryption
  - ! or * = Account locked
  - Empty = No password required
Field 3: Last password change (days since Jan 1, 1970)
Field 4: Min days before password can be changed
Field 5: Max days before password must be changed
Field 6: Warning days before password expires
Field 7: Days of inactivity before account locked
Field 8: Account expiration date
Field 9: Reserved for future use
EOF

cat shadow-reference.txt
