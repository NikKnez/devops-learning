# Exercise 8: Real-World Scenario

## Scenario: Onboard New Developer
# Step 1: Create user account
sudo useradd -m -s /bin/bash -c "John Developer" jdeveloper

# Step 2: Set password
sudo passwd jdeveloper

# Step 3: Add to necessary groups
sudo usermod -aG sudo jdeveloper        # Admin access
sudo usermod -aG www-data jdeveloper    # Web server access

# Step 4: Verify setup
id jdeveloper
groups jdeveloper
ls -la /home/jdeveloper

# Step 5: Document
cat > new-user-jdeveloper.txt << EOF
New User Created: jdeveloper
Full Name: John Developer
UID: $(id -u jdeveloper)
Groups: $(groups jdeveloper)
Home: /home/jdeveloper
Shell: /bin/bash
Created: $(date)
EOF

cat new-user-jdeveloper.txt

# Clean up test user
sudo userdel -r jdeveloper


