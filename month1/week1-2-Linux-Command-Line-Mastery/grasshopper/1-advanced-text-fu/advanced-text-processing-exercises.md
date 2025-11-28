# Advanced Text Processing Exercises


# Exercise 4: sed (Stream Editor)
cat > sed_practice.txt << 'EOF'
Hello World
Linux is great
DevOps automation
Cloud computing
EOF

# Task 4.1: Replace first occurrence
sed 's/Linux/Ubuntu/' sed_practice.txt

# Task 4.2: Replace all occurrences in line
sed 's/o/0/g' sed_practice.txt

# Task 4.3: Delete specific line
sed '2d' sed_practice.txt

# Task 4.4: Delete lines containing pattern
sed '/Cloud/d' sed_practice.txt

# Task 4.5: Replace and save to new file
sed 's/DevOps/SRE/' sed_practice.txt > sed_output.txt

# Task 4.6: Edit file in place
sed -i 's/great/awesome/' sed_practice.txt
cat sed_practice.txt


# Exercise 5: awk (Pattern Scanning)
cat > awk_practice.txt << 'EOF'
Alice 25 Engineer
Bob 30 Manager
Charlie 28 Developer
Diana 35 Designer
EOF

# Task 5.1: Print first column (names)
awk '{print $1}' awk_practice.txt

# Task 5.2: Print names and ages
awk '{print $1, $2}' awk_practice.txt

# Task 5.3: Print lines where age > 28
awk '$2 > 28' awk_practice.txt

# Task 5.4: Calculate average age
awk '{sum+=$2; count++} END {print sum/count}' awk_practice.txt

# Task 5.5: Format output
awk '{print "Name:", $1, "| Job:", $3}' awk_practice.txt


# Exercise 6: cut (Column Extraction)
cat > cut_practice.csv << 'EOF'
Name,Age,City,Job
Alice,25,NYC,Engineer
Bob,30,LA,Manager
Charlie,28,Chicago,Developer
EOF

# Task 6.1: Extract first column
cut -d',' -f1 cut_practice.csv

# Task 6.2: Extract Name and Job (columns 1 and 4)
cut -d',' -f1,4 cut_practice.csv

# Task 6.3: Extract all except first column
cut -d',' -f2- cut_practice.csv


# Exercise 7: sort and uniq
cat > sort_practice.txt << 'EOF'
banana
apple
cherry
apple
banana
date
cherry
EOF

# Task 7.1: Sort alphabetically
sort sort_practice.txt

# Task 7.2: Sort and remove duplicates
sort sort_practice.txt | uniq

# Task 7.3: Count duplicates
sort sort_practice.txt | uniq -c

# Task 7.4: Show only duplicates
sort sort_practice.txt | uniq -d


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



















