# Exercise 7: journalctl (Systemd Journal)


## Task 7.1: Understanding journalctl
cat > journalctl-guide.txt << 'EOF'
=== systemd Journal (journalctl) ===

What is journald?
- Modern logging system
- Part of systemd
- Binary format (not text)
- Indexed and structured
- Faster than grep on text logs

Advantages:
- Boot logs preserved
- Structured metadata
- Fast filtering
- Automatic rotation
- No need for logrotate

Basic Usage:
journalctl                    # All logs
journalctl -f                 # Follow (like tail -f)
journalctl -n 50              # Last 50 entries
journalctl -p err             # Errors only
journalctl -u nginx           # Specific service
journalctl --since "1 hour ago"  # Time filtering

Priority Levels:
0 emerg
1 alert
2 crit
3 err
4 warning
5 notice
6 info
7 debug

Time Filtering:
--since "2024-01-01"
--since "1 hour ago"
--since "30 min ago"
--since today
--until "2024-01-02"

Service Filtering:
-u service-name              # Specific service
-u nginx -u mysql            # Multiple services
_SYSTEMD_UNIT=nginx.service  # Alternative syntax

Output Formats:
-o short          # Default
-o verbose        # All metadata
-o json           # JSON format
-o json-pretty    # Pretty JSON
-o cat            # Just messages

Useful Combinations:
journalctl -u nginx -f                    # Follow nginx logs
journalctl -p err --since today           # Today's errors
journalctl -b                             # Current boot
journalctl -b -1                          # Previous boot
journalctl --disk-usage                   # How much space
journalctl --vacuum-time=7d               # Keep 7 days
journalctl --vacuum-size=1G               # Keep 1GB
EOF

cat journalctl-guide.txt


## Task 7.2: Practice journalctl
# View recent journal entries
journalctl -n 50

# Follow journal (Ctrl+C to stop)
# journalctl -f

# View errors only
journalctl -p err -n 20

# View for specific service
journalctl -u ssh -n 20
journalctl -u systemd-journald -n 20

# Time-based queries
journalctl --since "1 hour ago"
journalctl --since today

# Current boot logs
journalctl -b

# Check disk usage
journalctl --disk-usage

# Create journalctl analysis
cat > journalctl-analysis.txt << EOF
=== journalctl Analysis ===

Total journal size: $(journalctl --disk-usage 2>&1 | grep -o '[0-9.]*[MGK]')

Recent entries (last 10):
$(journalctl -n 10 --no-pager)

Errors today:
$(journalctl -p err --since today --no-pager | wc -l) entries

SSH service logs:
$(journalctl -u ssh -n 5 --no-pager)
EOF

cat journalctl-analysis.txt
