# Introduction to Python for DevOps

## Why Python for DevOps?

### Advantages over Bash

**Bash is great for:**
- Simple file operations
- Command chaining
- Quick one-liners
- System administration tasks

**Python is better for:**
- Complex logic and data structures
- API interactions
- JSON/YAML/XML parsing
- Cross-platform compatibility
- Error handling
- Code reusability
- Large projects

### Real DevOps Use Cases

**Infrastructure Automation:**
- AWS SDK (boto3)
- Azure SDK
- Google Cloud SDK
- Terraform helpers

**Configuration Management:**
- Ansible (written in Python)
- Salt (written in Python)
- Custom automation scripts

**Monitoring & Alerting:**
- Prometheus exporters
- Custom metrics collectors
- Log parsers
- Alert managers

**CI/CD:**
- Jenkins plugins
- GitLab CI helpers
- Custom deployment scripts
- Test automation

**Container & Orchestration:**
- Docker SDK
- Kubernetes client
- Container management scripts

## Python vs Bash - Side by Side

### Example 1: File Operations

**Bash:**
```bash
#!/bin/bash
if [ -f "config.txt" ]; then
    content=$(cat config.txt)
    echo "File exists: $content"
else
    echo "File not found"
fi
```

**Python:**
```python
#!/usr/bin/env python3
import os

if os.path.exists("config.txt"):
    with open("config.txt", "r") as f:
        content = f.read()
    print(f"File exists: {content}")
else:
    print("File not found")
```

### Example 2: API Call

**Bash (with curl):**
```bash
#!/bin/bash
response=$(curl -s "https://api.github.com/users/torvalds")
name=$(echo $response | jq -r '.name')
echo "Name: $name"
```

**Python:**
```python
#!/usr/bin/env python3
import requests

response = requests.get("https://api.github.com/users/torvalds")
data = response.json()
print(f"Name: {data['name']}")
```

### Example 3: JSON Processing

**Bash:**
```bash
#!/bin/bash
json='{"users":[{"name":"John","age":30},{"name":"Jane","age":25}]}'
echo $json | jq -r '.users[] | select(.age > 26) | .name'
```

**Python:**
```python
#!/usr/bin/env python3
import json

data = {
    "users": [
        {"name": "John", "age": 30},
        {"name": "Jane", "age": 25}
    ]
}

for user in data["users"]:
    if user["age"] > 26:
        print(user["name"])
```

### Example 4: Error Handling

**Bash:**
```bash
#!/bin/bash
if curl -f https://api.example.com/data > output.json; then
    echo "Success"
else
    echo "Failed"
    exit 1
fi
```

**Python:**
```python
#!/usr/bin/env python3
import requests

try:
    response = requests.get("https://api.example.com/data")
    response.raise_for_status()
    with open("output.json", "w") as f:
        f.write(response.text)
    print("Success")
except requests.exceptions.RequestException as e:
    print(f"Failed: {e}")
    exit(1)
```

## What You'll Learn (Week 3-4)

### Week 3: Python Basics (Days 45-51)
- Variables, data types (strings, numbers, lists, dictionaries)
- Control flow (if/else, for, while)
- Functions
- File operations
- Basic error handling

### Week 4: Python for Automation (Days 52-60)
- Working with JSON, YAML, CSV
- HTTP requests (requests library)
- Command-line arguments
- Email notifications
- Log file parsing
- Automation scripts

## Python Setup

### Check Python Installation
```bash
# Check if Python 3 is installed
python3 --version

# Should show: Python 3.x.x
```

### If Python not installed (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install -y python3 python3-pip python3-venv
```

### Virtual Environments (Best Practice)
```bash
# Create virtual environment
python3 -m venv ~/venvs/devops

# Activate
source ~/venvs/devops/bin/activate

# Now python points to virtual env
which python

# Install packages (only in this environment)
pip install requests

# Deactivate
deactivate
```

### First Python Script
```bash
# Create hello.py
cat > hello.py << 'EOF'
#!/usr/bin/env python3
"""
My first Python script
"""

def main():
    print("Hello, DevOps!")
    print("Python version:", end=" ")
    import sys
    print(sys.version.split()[0])

if __name__ == "__main__":
    main()
EOF

Make executable
chmod +x hello.py

# Run
./hello.py
# Or
python3 hello.py
```

## Python Resources for Week 3-4

### Primary Resources:
1. **Python for Everybody** - https://www.py4e.com/
   - Chapters 1-10
   - Excellent for beginners
   - Practical examples

2. **Automate the Boring Stuff** - https://automatetheboringstuff.com/
   - Chapters 1-11
   - DevOps-relevant examples
   - Free online

3. **Real Python** - https://realpython.com/
   - Specific tutorials as needed
   - High quality content

### Supplementary:
- Python official docs: https://docs.python.org/3/
- Python Cheat Sheet: https://www.pythoncheatsheet.org/
- Learn Python interactive: https://www.learnpython.org/

## Week 3-4 Study Plan

### Days 45-47: Basics
- Variables and data types
- Strings, numbers, booleans
- Lists and tuples
- Dictionaries

### Days 48-50: Control Flow
- If/elif/else
- For loops
- While loops
- Break, continue

### Days 51-53: Functions & Modules
- Defining functions
- Parameters and return values
- Importing modules
- Creating modules

### Days 54-56: File Operations
- Reading files
- Writing files
- JSON/YAML processing
- CSV handling

### Days 57-60: Automation
- HTTP requests
- Command-line arguments
- Error handling
- Final automation projects

## Preparation Tasks for Tomorrow

1. **Verify Python installation:**
```bash
python3 --version
pip3 --version
```

2. **Create workspace:**
```bash
mkdir -p ~/devops-learning/month2/week3-4/python-basics
cd ~/devops-learning/month2/week3-4/python-basics
```

3. **Create virtual environment:**
```bash
python3 -m venv ~/venvs/devops
source ~/venvs/devops/bin/activate
pip install --upgrade pip
```

4. **Test installation:**
```bash
python3 -c "print('Ready for Python!')"
```

5. **Bookmark resources:**
- Python for Everybody: https://www.py4e.com/
- Automate the Boring Stuff: https://automatetheboringstuff.com/

## Key Differences: Bash vs Python

| Feature | Bash | Python |
|---------|------|--------|
| Syntax | Complex, special chars | Clean, readable |
| Data structures | Arrays only | Lists, dicts, sets, tuples |
| Error handling | Exit codes | try/except blocks |
| JSON/YAML | External tools (jq) | Built-in libraries |
| API calls | curl + parsing | requests library |
| Cross-platform | Linux/Unix mainly | Linux, macOS, Windows |
| Code reuse | Difficult | Easy (modules) |
| Learning curve | Medium | Easy |
| Best for | System tasks | Complex logic |

## When to Use What?

**Use Bash when:**
- Simple file operations
- Chaining Linux commands
- Quick one-off tasks
- System administration
- Already in shell environment

**Use Python when:**
- Complex data processing
- API integrations
- Cross-platform scripts
- Large projects
- Need proper error handling
- Working with JSON/YAML
- Need code reusability

**In DevOps, you'll use both:**
- Bash for quick tasks
- Python for automation
- Combine when needed
