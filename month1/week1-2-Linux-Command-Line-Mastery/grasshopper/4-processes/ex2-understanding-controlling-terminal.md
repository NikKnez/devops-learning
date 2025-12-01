# Exercise 2: Understanding Controlling Terminal


## Task 2.1: What is a Controlling Terminal?
# Create explanation
cat > controlling-terminal.txt << 'EOF'
=== Controlling Terminal (TTY) ===

TTY = TeleTYpewriter (historical term for terminal)

Types:
- pts/0, pts/1, etc. = Pseudo-terminal (terminal emulator, SSH)
- tty1, tty2, etc. = Physical virtual console (Ctrl+Alt+F1-F6)
- ? = No terminal (daemon, background process)

Check your terminal:
- tty command shows your current terminal
- ps shows which terminal owns each process

Session leader:
- First process in a terminal session
- Usually your shell (bash)
EOF

cat controlling-terminal.txt


## Task 2.2: Explore Your Terminal
# What's your current terminal?
tty

# Show processes in your terminal only
ps -t $(tty)

# Show all terminals in use
who

# Show what you're doing
w

# Your current shell's PID
echo $$

# Your current shell's parent PID (terminal emulator)
ps -p $$ -o ppid=


## Task 2.3: Processes With and Without Terminals
# Processes with terminals (interactive)
ps aux | grep 'pts'

# Processes without terminals (daemons)
ps aux | grep '?'

# System daemons (no TTY)
ps aux | awk '$7 == "?"' | head -10

# Document findings
cat > terminal-analysis.txt << 'EOF'
=== Terminal Analysis ===

My terminal: 
$(tty)

Processes in my terminal:
$(ps -t $(tty))

Background processes (no terminal):
[List a few daemon processes you found]
EOF
