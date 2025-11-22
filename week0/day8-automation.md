# Day 8: Deployment Automation

## What I Built

Automated deployment script for Python_AI-University statuc website.

## Script Features

1. **Backup**: Creates backup before deploying (for safety)
2. **Clone**: Fatches latest repo from GitHub
3. **Deploy**: Copies files to nginx web root
4. **Permissions**: Sets correct ownership and permissions
5. **Restart**: Restarts nginx service
6. **Cleanup**: Removes temporary files
7. **Coloured output**: Easy to read progress

## What I Learned

- Variables in bash scripts
- Colour codes for terminal output
- Error handling with 'set -e'
- Conditional check with 'if'
- Exit codes ('$?)
- Creating backups programmatically
- Full deployment automation

## Commands Used

# Clone repository
git clone [url] [directory]

# Copy Files
cp -r [source] [destination]

# Set permissions
chown -R www-data:www-data [directory]
chmod -R 755 [directory]

# Service management
systemctl restart nginx


## Comparison: Manual vs Automated

**Manual Deployment (Day 7):**
- 8-10 commands
- 5-10 minutes
- Easy to make mistakes
- No backup created
- Have to remember exact steps

**Automated Deployment (Day 8):**
- 1 command: './deploy-python-ai-university.sh'
- 10-20 seconds
- Consistent every time
- Automatic backup
- Documented in script


## How to Use
cd /home/nikola/devops-learning/scripts
./deploy-python-ai-university.sh


## Improvements Made

- Added coloured output for better readability
- Created automatic backups before deployment
- Added error handling (exit on failure)
- Cleanup of temporary files
- Clear success/failure messages


## Future Enhacements

- Add command line arguments (different repos)
- Add rollback capability
- Add health check after deployment
- Log deployments to file
- Send notifications on completion


# Note to Myself

DevOps Engineers do:
- Take manual processes
- Automate them
- Make them reliable
- Make them repeatable
- Document everything

Learn more advanced automation.









 
