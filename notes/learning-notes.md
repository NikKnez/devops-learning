# DevOps Commands and Notes

# DevOps Learning Notes

Personal reference for commands, concepts, and troubleshooting.

---

## Linux Commands Reference

### Navigation & Files (Daily Use)
```bash
cd [dir]              # Change directory
ls -la                # List all files with details
pwd                   # Print working directory
mkdir -p [dir]        # Create directory (with parents)
rm -rf [dir]          # Remove directory (CAREFUL!)
cp -r [src] [dst]     # Copy recursively
mv [src] [dst]        # Move or rename
touch [file]          # Create empty file
cat [file]            # View file
less [file]           # View file with scrolling
```

### File Editing
```bash
nano [file]           # Simple editor (what I use)
vim [file]            # Advanced editor (learning basics)
```

### Search & Filter
```bash
grep "text" [file]    # Search text in files
find . -name "*.sh"   # Find files by name
wc -l [file]          # Count lines
head -n 10 [file]     # First 10 lines
tail -n 10 [file]     # Last 10 lines
tail -f [file]        # Follow file (for logs)
```

### Permissions
```bash
chmod +x [file]       # Make executable
chmod 755 [file]      # rwxr-xr-x permissions
chown user:group      # Change owner
sudo [command]        # Run as root
```

### Process Management
```bash
ps aux                # List all processes
top                   # Real-time process viewer
htop                  # Better top (need to install)
kill [PID]            # Stop process
pkill [name]          # Stop process by name
systemctl start nginx # Start service
systemctl stop nginx  # Stop service
systemctl status nginx # Check service status
systemctl restart nginx # Restart service
```

### System Info
```bash
df -h                 # Disk space
du -sh [dir]          # Directory size
free -h               # Memory usage
uptime                # System uptime
uname -a              # System info
date                  # Current date/time
```

### Network
```bash
curl [url]            # Make HTTP request
wget [url]            # Download file
ping [host]           # Test connectivity
ssh user@host         # Remote login
ip addr               # Show IP addresses
netstat -tulpn        # Network connections
```

---

## Bash Scripting Basics

### Script Structure
```bash
#!/bin/bash
# Description of what script does

# Variables
VAR="value"
DATE=$(date +%Y-%m-%d)

# Conditionals
if [ condition ]; then
    # do something
fi

# Loops
for item in list; do
    # do something
done
```

### Important Concepts
- `$1, $2, $3` = Command line arguments
- `$?` = Exit code of last command (0 = success)
- `$#` = Number of arguments
- `$@` = All arguments

### Conditionals
- `[ -z "$VAR" ]` = True if empty
- `[ -n "$VAR" ]` = True if NOT empty
- `[ -f "$FILE" ]` = True if file exists
- `[ -d "$DIR" ]` = True if directory exists
- `[ $A -eq $B ]` = Equal (numbers)
- `[ $A -ne $B ]` = Not equal (numbers)

### Redirection
- `> file` = Redirect output (overwrite)
- `>> file` = Redirect output (append)
- `2> file` = Redirect errors
- `2>&1` = Redirect errors to output
- `> /dev/null` = Discard output

---

## Git Commands

### Daily Workflow
```bash
git status            # Check what changed
git add .             # Stage all changes
git add [file]        # Stage specific file
git commit -m "msg"   # Commit with message
git push origin main  # Push to GitHub
git pull origin main  # Pull from GitHub
```

### Repository Setup
```bash
git init              # Initialize repo
git clone [url]       # Clone repo
git remote add origin [url]  # Add remote
```

### Branch Management
```bash
git branch            # List branches
git branch [name]     # Create branch
git checkout [branch] # Switch branch
git merge [branch]    # Merge branch
```

---

## Nginx Basics

### Commands
```bash
sudo systemctl start nginx    # Start nginx
sudo systemctl stop nginx     # Stop nginx
sudo systemctl restart nginx  # Restart nginx
sudo systemctl status nginx   # Check status
```

### File Locations
- Config: `/etc/nginx/nginx.conf`
- Sites: `/etc/nginx/sites-available/`
- Web root: `/var/www/html/`
- Logs: `/var/log/nginx/`

### Deploy Static Site
```bash
sudo cp -r [files] /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo systemctl restart nginx
```

---

## Docker (Month 4 - TBD)

Coming soon when I learn Docker...

---

## Terraform (Month 5 - TBD)

Coming soon when I learn Terraform...

---

## AWS (Month 3 - TBD)

Coming soon when I learn AWS...

---

## Common Mistakes & Fixes

### Mistake: Permission Denied
```bash
# Problem: Can't execute script
# Fix: Make it executable
chmod +x script.sh
```

### Mistake: File Not Found
```bash
# Problem: Wrong directory
# Fix: Check where you are
pwd
ls -la
```

### Mistake: Service Won't Start
```bash
# Check logs for errors
sudo systemctl status [service]
journalctl -xe
```

### Mistake: Git Push Rejected
```bash
# Pull first, then push
git pull origin main
git push origin main
```

---

## Learning Progress

### Week 0
- ✅ Linux basics (cd, ls, mkdir, rm, cp, mv)
- ✅ File permissions (chmod, chown)
- ✅ Bash scripting basics (backup script, git automation)
- ✅ Nginx setup and static site deployment
- ✅ Git workflow (add, commit, push)

### Month 1 (TBD)
- Linux command line mastery
- Git advanced features
- Bash scripting intermediate

---

## Useful Resources

### Linux
- Linux Journey: https://linuxjourney.com/
- OverTheWire Bandit: https://overthewire.org/wargames/bandit/

### Git
- Git Immersion: http://gitimmersion.com/
- Learn Git Branching: https://learngitbranching.js.org/

### DevOps
- AWS Skill Builder: https://skillbuilder.aws/
- FreeCodeCamp YouTube (DevOps courses)

---

## Quick Troubleshooting Checklist

When something doesn't work:

1. Check if service is running: `systemctl status [service]`
2. Check logs: `journalctl -xe` or `/var/log/`
3. Check permissions: `ls -la`
4. Check if file exists: `ls [file]`
5. Google the exact error message
6. Check if you're in correct directory: `pwd`

---

Last updated: 2025-11-21
