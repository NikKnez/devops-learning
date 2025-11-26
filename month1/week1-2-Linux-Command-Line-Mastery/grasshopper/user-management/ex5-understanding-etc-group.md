# Exercise 5: Understanding /etc/group


## Task 5.1: Explore /etc/group Structure
# View the file
cat /etc/group

# Your primary group
grep "^nikola:" /etc/group

# Sudo group (important for DevOps)
grep "^sudo:" /etc/group

# Format:
# group_name:password:GID:user_list


## Task 5.2: Group Analysis
# Find all groups with members
awk -F: '$4 != "" {print $1 ":", $4}' /etc/group

# Find which groups user 'nikola' is in
groups nikola

# Find all members of a specific group
getent group sudo

# Count groups
cat /etc/group | wc -l

# List groups with no members
awk -F: '$4 == "" {print $1}' /etc/group | wc -l


## Task 5.3: Important System Groups
# Document important groups
cat > important-groups.txt << 'EOF'
=== Important Linux Groups ===

sudo - Can use sudo command (administrative access)
adm - Can read system logs
www-data - Web server group
docker - Can use Docker (when installed)
systemd-journal - Can read system journals
EOF

# Check which of these you belong to
for group in sudo adm www-data systemd-journal; do
    if groups nikola | grep -q $group; then
        echo "✓ Member of: $group"
    else
        echo "✗ Not in: $group"
    fi
done
