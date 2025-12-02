# Processes

## Commands Learned

### Monitoring
- `ps aux` - all processes
- `ps -ef` - all processes (different format)
- `top` / `htop` - real-time monitoring
- `pstree` - process tree

### Signals
- `kill PID` - SIGTERM (graceful)
- `kill -9 PID` - SIGKILL (force)
- `kill -STOP PID` - pause process
- `kill -CONT PID` - resume process
- `killall name` - kill by name
- `pkill pattern` - kill by pattern

### Priority
- `nice -n 10 command` - start with low priority
- `renice -n 5 -p PID` - change priority

### Job Control
- `command &` - background
- `Ctrl+Z` - suspend
- `bg` - resume in background
- `fg` - bring to foreground
- `jobs` - list jobs

## Process States
- R = Running
- S = Sleeping
- D = Uninterruptible sleep
- Z = Zombie
- T = Stopped

## Important Concepts
- Every process has PID and PPID
- Signals are IPC mechanism
- Nice values: -20 (high) to 19 (low)
- /proc filesystem exposes process info
- Job control manages foreground/background
