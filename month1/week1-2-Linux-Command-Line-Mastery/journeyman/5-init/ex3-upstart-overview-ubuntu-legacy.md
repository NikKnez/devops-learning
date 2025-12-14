# Exercise 3: Upstart Overview (Ubuntu Legacy)


## Task 3.1: Understanding Upstart
cat > upstart-overview.txt << 'EOF'
=== Upstart Init System ===

What is Upstart?
- Event-based init system
- Developed by Ubuntu (Canonical)
- Used in Ubuntu 6.10 (2006) to 14.10 (2014)
- Replaced by systemd in Ubuntu 15.04+
- Asynchronous, event-driven

Key Improvements Over SysV:
- Event-based (not runlevel-based)
- Parallel service startup
- Automatic respawn of crashed services
- Better dependency handling
- Supervises processes

Upstart Concepts:

Events:
- Starting, started
- Stopping, stopped
- System events (filesystem mounted, network up)

Jobs:
- Services or tasks
- Defined in /etc/init/*.conf
- React to events

Job States:
waiting  - Waiting for start event
starting - About to start
running  - Process is running
stopping - About to stop
stopped  - Not running

Upstart Configuration:
- Location: /etc/init/
- Format: .conf files
- Declarative syntax (not shell scripts)

Basic Upstart Job:
```
# /etc/init/myservice.conf
description "My Service"
start on runlevel [2345]
stop on runlevel [016]

respawn
exec /usr/bin/myservice
```

Why Upstart Failed:
- Not adopted outside Ubuntu ecosystem
- Systemd gained more traction
- Limited tooling compared to systemd
- Ubuntu switched to systemd for compatibility

Legacy Status:
- Removed from modern Ubuntu
- Some concepts influenced systemd
- Historical interest only
EOF

cat upstart-overview.txt


## Task 3.2: Check for Upstart (None on Modern Systems)
# Check if Upstart is present (it won't be)
which initctl 2>/dev/null || echo "Upstart not present (expected on modern systems)"

# Check for Upstart config directory
ls /etc/init/*.conf 2>/dev/null || echo "No Upstart configs (systemd is used)"

# Your system uses systemd, not Upstart
echo "Current init system: $(ps -p 1 -o comm=)"

# Create historical timeline
cat > init-timeline.txt << 'EOF'
=== Init System Timeline ===

1970s-2000s: SysV Init
- Traditional Unix approach
- Runlevels
- Sequential startup
- /etc/init.d/ scripts

2006-2014: Upstart (Ubuntu)
- Event-based
- Parallel startup
- /etc/init/*.conf
- Ubuntu-specific

2010-Present: systemd
- Most Linux distributions
- Unit files
- Dependency management
- /etc/systemd/system/

Your System:
Distribution: $(lsb_release -d | cut -f2)
Init System: $(ps -p 1 -o comm=)
Version: $(systemd --version | head -1)
EOF

cat init-timeline.txt
