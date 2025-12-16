# Exercise 4: CPU Monitoring


## Task 4.1: CPU Monitoring Tools
cat > cpu-monitoring.txt << 'EOF'
=== CPU Monitoring Comprehensive Guide ===

CPU Metrics to Monitor:
1. Usage (%) - How busy
2. Load Average - Queue depth
3. Context Switches - Task switching
4. Interrupts - Hardware/software signals
5. Per-core usage - Imbalanced load

Tools Overview:

1. top/htop
   - Real-time overview
   - Per-process CPU
   - Load average
   Press '1' in top to see per-core

2. mpstat (sysstat package)
   - Detailed CPU statistics
   - Per-core breakdown
   - Historical data

3. vmstat
   - System-wide stats
   - CPU, memory, IO together
   - Good for quick check

4. sar (System Activity Reporter)
   - Historical data
   - Trends over time
   - Requires sysstat package

5. uptime
   - Quick load check
   - 1, 5, 15 minute averages

Commands:

# Current CPU info
lscpu                   # CPU architecture
cat /proc/cpuinfo       # Detailed CPU info
nproc                   # Number of processors

# Real-time monitoring
top                     # Classic
htop                    # Better UI
mpstat 1                # Update every second
vmstat 1                # System stats every second

# CPU usage by process
ps aux --sort=-%cpu | head -10   # Top CPU processes
top -b -n 1 | head -20           # Snapshot

# Load average
uptime                  # Quick check
cat /proc/loadavg       # Raw data
w                       # Who + load

# Historical (requires sysstat)
sar -u                  # CPU usage history
sar -u 1 10             # 10 samples, 1 second apart

CPU States Breakdown:
us (user)    - Normal programs
sy (system)  - Kernel operations
ni (nice)    - Low priority programs
id (idle)    - Doing nothing
wa (iowait)  - Waiting for disk/network
hi (hirq)    - Hardware interrupts
si (sirq)    - Software interrupts
st (steal)   - Stolen by hypervisor (VMs only)

Good vs Bad CPU Usage:

Good:
- us: 30-70% (doing work)
- sy: 5-15% (reasonable kernel overhead)
- id: 20-60% (some headroom)
- wa: <5% (not IO bound)

Bad:
- us: >90% sustained (bottleneck)
- sy: >30% (kernel thrashing)
- wa: >20% (disk/network bottleneck)
- st: >5% (VM resource contention)

Load Average Rules:
- Load = 1.0 per core is 100%
- 4-core system: 4.0 = full utilization
- Load > cores = overloaded
- 1-min > 5-min > 15-min = increasing load (bad)
- 1-min < 5-min < 15-min = decreasing load (good)

Troubleshooting High CPU:

1. Identify process:
   top (press 'P' to sort by CPU)
   
2. Check if multi-threaded:
   top -H -p PID
   
3. See what it's doing:
   strace -p PID (system calls)
   
4. Check for runaway process:
   Is it supposed to use this much?
   
5. Kill or renice:
   kill PID
   renice 10 PID
EOF

cat cpu-monitoring.txt


## Task 4.2: CPU Monitoring Practice
# Install sysstat if needed for mpstat/sar
# sudo apt install -y sysstat

# Create CPU monitor script
cat > cpu-monitor.sh << 'EOF'
#!/bin/bash

echo "=== CPU Monitoring Report ==="
date
echo ""

echo "1. CPU Information:"
echo "   Cores: $(nproc)"
echo "   Architecture: $(lscpu | grep Architecture | awk '{print $2}')"
echo ""

echo "2. Load Average:"
uptime
echo ""

echo "3. CPU Usage (snapshot):"
top -b -n 1 | grep "Cpu(s)" | awk '{print "   User: " $2 ", System: " $4 ", Idle: " $8}'
echo ""

echo "4. Top 5 CPU Processes:"
ps aux --sort=-%cpu | head -6 | tail -5
echo ""

echo "5. CPU Per Core (if mpstat available):"
if command -v mpstat &> /dev/null; then
    mpstat -P ALL 1 1 | grep Average
else
    echo "   mpstat not installed (sudo apt install sysstat)"
fi
echo ""

echo "6. Context Switches (if vmstat available):"
if command -v vmstat &> /dev/null; then
    vmstat 1 2 | tail -1 | awk '{print "   " $12 " context switches/sec"}'
else
    echo "   vmstat not available"
fi
EOF

chmod +x cpu-monitor.sh
./cpu-monitor.sh > cpu-report.txt
cat cpu-report.txt
