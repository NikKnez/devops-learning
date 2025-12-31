# Git for DevOps - Real-World Patterns


## DevOps-specific Git workflows
mkdir git-devops-patterns
cd git-devops-patterns
git init


## Pattern 1: Environment branches
# Create environment-specific branches
cat > README.md << 'EOF'
# Multi-Environment Deployment

This repo demonstrates Git workflows for multiple environments.

## Branch Strategy
- `main` - Production
- `staging` - Staging environment
- `develop` - Development environment
- `feature/*` - Feature branches

## Deployment Flow
feature → develop → staging → main (production)
EOF

git add README.md
git commit -m "Initial commit"
git branch -M main

# Create "git-devops-patterns" repo on GitHub
git remote add origin git@github.com:NikKnez/git-devops-patterns.git
git push -u origin main

# Create environment branches
git checkout -b develop
git push origin develop

git checkout -b staging
git push origin staging

git checkout main
git push origin main

# Feature workflow
git checkout develop
git checkout -b feature/add-monitoring

cat > monitoring.yml << 'EOF'
# Monitoring configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: monitoring-config
data:
  scrape_interval: "15s"
  environment: "dev"
EOF

git add monitoring.yml
git commit -m "feat(monitoring): add monitoring config for dev"
git push -u origin feature/add-monitoring

# Merge to develop
git checkout develop
git merge feature/add-monitoring
git push origin develop

# Update for staging
git checkout staging
git merge develop

# Update environment-specific values
cat > monitoring.yml << 'EOF'
# Monitoring configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: monitoring-config
data:
  scrape_interval: "30s"
  environment: "staging"
EOF

git add monitoring.yml
git commit -m "config(monitoring): adjust for staging environment"
git push origin staging

# Promote to production
git checkout main
git merge staging

cat > monitoring.yml << 'EOF'
# Monitoring configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: monitoring-config
data:
  scrape_interval: "60s"
  environment: "production"
EOF

git add monitoring.yml
git commit -m "config(monitoring): production-ready configuration"
git tag v1.0.0
git push origin main
git push origin v1.0.0


## Pattern 2: Infrastructure as Code with Git
# Create Terraform structure
mkdir -p terraform/{dev,staging,prod}

# Development environment
cat > terraform/dev/main.tf << 'EOF'
# Development infrastructure

variable "environment" {
  default = "dev"
}

resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t3.micro"  # Small for dev
  
  tags = {
    Name        = "web-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
EOF

git add terraform/
git commit -m "infra(terraform): add dev environment"

# Staging environment
cat > terraform/staging/main.tf << 'EOF'
# Staging infrastructure

variable "environment" {
  default = "staging"
}

resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t3.small"  # Medium for staging
  
  tags = {
    Name        = "web-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
EOF

git add terraform/staging/
git commit -m "infra(terraform): add staging environment"

# Production environment
cat > terraform/prod/main.tf << 'EOF'
# Production infrastructure

variable "environment" {
  default = "prod"
}

resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t3.medium"  # Larger for production
  
  tags = {
    Name        = "web-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    CostCenter  = "production"
  }
}
EOF

git add terraform/prod/
git commit -m "infra(terraform): add production environment"
git push origin main


## Pattern 3: Git hooks for automation (pre-commit checks)
# Create Git hooks directory structure
mkdir -p .githooks

cat > .githooks/pre-commit << 'EOF'
#!/bin/bash
# Pre-commit hook: Run checks before allowing commit

echo "Running pre-commit checks..."

# Check for common mistakes
if git diff --cached --name-only | grep -q "\.sh$"; then
    echo "Checking shell scripts..."
    for file in $(git diff --cached --name-only | grep "\.sh$"); do
        if [ -f "$file" ]; then
            # Check if script is executable
            if [ ! -x "$file" ]; then
                echo "❌ ERROR: $file is not executable"
                echo "   Run: chmod +x $file"
                exit 1
            fi
            
            # Check for bash syntax errors
            if ! bash -n "$file" 2>/dev/null; then
                echo "❌ ERROR: Syntax error in $file"
                exit 1
            fi
        fi
    done
    echo "✓ Shell scripts OK"
fi

# Check for secrets
if git diff --cached | grep -iE "(password|secret|api_key|token).*=.*['\"]"; then
    echo "❌ ERROR: Possible secret detected in commit!"
    echo "   Remove sensitive data before committing"
    exit 1
fi
echo "✓ No secrets detected"

# Check for large files
for file in $(git diff --cached --name-only); do
    if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if [ "$size" -gt 1048576 ]; then  # 1MB
            echo "❌ ERROR: $file is larger than 1MB"
            echo "   Consider using Git LFS or excluding from repo"
            exit 1
        fi
    fi
done
echo "✓ No large files"

echo "✅ All pre-commit checks passed!"
exit 0
EOF

chmod +x .githooks/pre-commit

# Configure Git to use custom hooks directory
git config core.hooksPath .githooks

git add .githooks/
git commit -m "ci: add pre-commit hooks for code quality"


## Test the pre-commit hook:
# Test 1: Non-executable script (should fail)
cat > test-script.sh << 'EOF'
#!/bin/bash
echo "test"
EOF

git add test-script.sh
git commit -m "Test commit"
# Should fail with error about missing executable permission

chmod +x test-script.sh
git add test-script.sh
git commit -m "Add test script"
# Should pass now

# Test 2: Detecting secrets (should fail)
cat > config.txt << 'EOF'
api_key="sk-1234567890abcdef"
EOF

git add config.txt
git commit -m "Add config"
# Should fail with secret detection error

# Fix it
cat > config.txt << 'EOF'
api_key="${API_KEY}"  # Set via environment variable
EOF

git add config.txt
git commit -m "Add config with env var"
# Should pass


## Pattern 4: Semantic commit messages (enforced by hook)
cat > .githooks/commit-msg << 'EOF'
#!/bin/bash
# Enforce conventional commit format

commit_msg=$(cat "$1")

# Check if commit message follows conventional format
if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .{1,}$"; then
    echo "❌ ERROR: Commit message doesn't follow conventional format"
    echo ""
    echo "Format: <type>(<scope>): <subject>"
    echo ""
    echo "Types:"
    echo "  feat:     New feature"
    echo "  fix:      Bug fix"
    echo "  docs:     Documentation changes"
    echo "  style:    Code style changes (formatting, etc)"
    echo "  refactor: Code refactoring"
    echo "  test:     Adding or updating tests"
    echo "  chore:    Maintenance tasks"
    echo "  perf:     Performance improvements"
    echo "  ci:       CI/CD changes"
    echo "  build:    Build system changes"
    echo "  revert:   Reverting previous changes"
    echo ""
    echo "Examples:"
    echo "  feat(api): add user authentication endpoint"
    echo "  fix(database): resolve connection timeout issue"
    echo "  docs(readme): update installation instructions"
    echo ""
    echo "Your commit message:"
    echo "  $commit_msg"
    exit 1
fi

echo "✅ Commit message format OK"
exit 0
EOF

chmod +x .githooks/commit-msg

git add .githooks/commit-msg
git commit -m "ci: add commit message format validation"
