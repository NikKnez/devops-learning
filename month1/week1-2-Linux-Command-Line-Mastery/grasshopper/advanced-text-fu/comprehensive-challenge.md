# Comprehensive Challenge: Log File Analysis


cat > server.log << 'EOF'
2025-01-15 10:23:45 INFO User alice logged in
2025-01-15 10:24:12 ERROR Failed login attempt for user bob
2025-01-15 10:25:33 INFO User charlie logged in
2025-01-15 10:26:48 ERROR Database connection failed
2025-01-15 10:27:55 INFO User alice logged out
2025-01-15 10:28:02 ERROR Failed login attempt for user bob
2025-01-15 10:29:14 INFO User diana logged in
2025-01-15 10:30:22 ERROR Disk space low
EOF

# Challenge 1: Extract all ERROR lines
grep ERROR server.log

# Challenge 2: Count number of errors
grep -c ERROR server.log

# Challenge 3: Extract usernames from login events
grep "logged in" server.log | awk '{print $5}'

# Challenge 4: Find unique error messages
grep ERROR server.log | cut -d' ' -f4- | sort | uniq

# Challenge 5: Count failed login attempts
grep "Failed login" server.log | wc -l

# Challenge 6: Replace ERROR with CRITICAL
sed 's/ERROR/CRITICAL/g' server.log

# Challenge 7: Create summary report
echo "=== Log Summary ===" > summary.txt
echo "Total lines: $(wc -l < server.log)" >> summary.txt
echo "ERROR count: $(grep -c ERROR server.log)" >> summary.txt
echo "INFO count: $(grep -c INFO server.log)" >> summary.txt
cat summary.txt
