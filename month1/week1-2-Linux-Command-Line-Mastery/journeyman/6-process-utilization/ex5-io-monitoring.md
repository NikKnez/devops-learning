# Exercise 5: I/O Monitoring


## Task 5.1: I/O Monitoring Guide
cat > io-monitoring.txt << 'EOF'
=== I/O Monitoring Guide ===

Why Monitor I/O?
- Disk is slowest component
- I/O bottlenecks kill performance
- High CPU "wait" means I/O problem

I/O Types:
- Block I/O: Disk reads/writes
- Network I/O: Network traffic
- Filesystem I/O: File operations

Key Metrics:
1. IOPS - I/O Operations Per Second
2. Throughput - MB/s read/write
3. Latency - Time per operation
4. Queue depth - Waiting operations
5. %util - How busy disk is

Tools:

1. iostat (sysstat package)
   - Disk I/O statistics
   - Per-device breakdown
   - Historical data

2. iotop
   - Like top but for I/O
   - Shows which process does I/O
   - Real-time

3. vmstat
   - System-wide I/O
   - Block in/out
   - Quick overview

4. sar
   - Historical I/O data
   - Trends over time

5. lsof
   - What files are open
   - Which process uses what

Commands:

# Disk I/O stats
iostat                  # Overview
iostat -x 1             # Extended, update every second
iostat -xz 1            # Hide zero-activity devices

# Process I/O
iotop                   # Interactive (needs sudo)
iotop -o                # Only show active I/O
iotop -P                # Show processes, not threads

# System I/O
vmstat 1                # bi/bo columns (blocks in/out)
sar -b                  # Historical I/O

# Disk usage
df -h                   # Space usage
du -sh /var/log         # Directory size
lsof | grep deleted     # Deleted files still open

iostat Output Explained:
tps     - Transfers per second (IOPS)
kB_read/s  - Read throughput
kB_wrtn/s  - Write throughput
kB_read    - Total read
kB_wrtn    - Total written

Extended iostat (-x):
rrqm/s  - Read requests merged
wrqm/s  - Write requests merged
r/s     - Reads per second
w/s     - Writes per second
rkB/s   - KB read per second
wkB/s   - KB written per second
avgrq-sz - Average request size
avgqu-sz - Average queue size
await   - Average wait time (ms)
r_await - Read wait time
w_await - Write wait time
svctm   - Service time (deprecated)
%util   - Utilization (busy %)

Good vs Bad I/O:

Good Disk:
- %util: <80%
- await: <10ms (SSD), <30ms (HDD)
- avgqu-sz: <2

Bad Disk (Bottleneck):
- %util: >90% (saturated)
- await: >100ms (slow)
- avgqu-sz: >10 (queue building up)

Troubleshooting High I/O:

1. Find which process:
   sudo iotop -o
   
2. Find what files:
   lsof -p PID
   
3. Check disk health:
   sudo smartctl -a /dev/sda
   
4. Check filesystem:
   df -i (inodes)
   du -sh /* (usage)

Common I/O Issues:

1. Log files filling disk:
   du -sh /var/log/*
   logrotate manually
   
2. Process writing constantly:
   iotop shows culprit
   Check if necessary
   
3. Swap thrashing:
   free -h (swap usage)
   vmstat (si/so columns)
   Add RAM or increase swap

4. Filesystem full:
   df -h (find filesystem)
   du -sh /* (find directory)
   ncdu / (interactive)
EOF

cat io-monitoring.txt


## Task 5.2: I/O Monitoring Practice
# Create I/O test script
cat > io-test.sh << 'EOF'
#!/bin/bash

echo "=== I/O Monitoring Demo ==="
echo ""

echo "Creating I/O load..."
# Write test
dd if=/dev/zero of=/tmp/testfile bs=1M count=100 2>&1 | grep copied

# Read test
dd if=/tmp/testfile of=/dev/null bs=1M 2>&1 | grep copied

# Cleanup
rm /tmp/testfile

echo ""
echo "I/O test completed"
EOF

chmod +x io-test.sh

# Create I/O monitor report
cat > io-monitor.sh << 'EOF'
#!/bin/bash

echo "=== I/O Monitoring Report ==="
date
echo ""

echo "1. Disk Space:"
df -h | grep -E "Filesystem|^/dev"
echo ""

echo "2. Disk I/O Stats:"
if command -v iostat &> /dev/null; then
    iostat -x 1 2 | tail -n +4
else
    echo "   iostat not installed (sudo apt install sysstat)"
fi
echo ""

echo "3. System I/O (vmstat):"
if command -v vmstat &> /dev/null; then
    echo "   bi/bo = blocks in/out per second"
    vmstat 1 3 | tail -2
else
    echo "   vmstat not available"
fi
echo ""

echo "4. Open Files Count:"
echo "   $(lsof 2>/dev/null | wc -l) files open system-wide"
echo ""

echo "5. Largest Directories in /var:"
sudo du -sh /var/* 2>/dev/null | sort -rh | head -5
EOF

chmod +x io-monitor.sh
./io-monitor.sh > io-report.txt
cat io-report.txt
