# Advanced GitHub Workflows + Branch Protection


## Scenario: Multi-person collaboration workflow
git checkout main
git pull origin main

# Create develop branch (common in GitFlow)
git checkout -b develop
git push origin develop

# Feature 1: You work on infrastructure
git checkout -b feature/terraform-init develop

mkdir -p config/terraform
cat > config/terraform/main.tf << 'EOF'
# Terraform configuration for basic infrastructure

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# VPC configuration will go here
EOF

cat > config/terraform/variables.tf << 'EOF'
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}
EOF

git add config/terraform/
git commit -m "feat(terraform): initialize terraform configuration

- Add provider configuration
- Add basic variable definitions
- Prepare for VPC setup"

git push origin feature/terraform-init


## Create PR to develop (not main)
## Simulate teammate's work:
# Feature 2: Teammate works on monitoring
git checkout develop
git checkout -b feature/prometheus-config

mkdir -p config/prometheus
cat > config/prometheus/prometheus.yml << 'EOF'
# Prometheus configuration

global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']
  
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9323']
EOF

cat > scripts/prometheus-health.sh << 'EOF'
#!/bin/bash
# Check Prometheus health

PROMETHEUS_URL=${PROMETHEUS_URL:-"http://localhost:9090"}

response=$(curl -s -o /dev/null -w "%{http_code}" "$PROMETHEUS_URL/-/healthy")

if [ "$response" = "200" ]; then
    echo "✓ Prometheus is healthy"
    exit 0
else
    echo "✗ Prometheus is unhealthy (HTTP $response)"
    exit 1
fi
EOF

chmod +x scripts/prometheus-health.sh

git add config/prometheus/ scripts/prometheus-health.sh
git commit -m "feat(monitoring): add Prometheus configuration

- Basic Prometheus config with node-exporter
- Health check script for monitoring
- Docker metrics collection"

git push origin feature/prometheus-config


## Create both PRs on GitHub:
1. PR #1: feature/terraform-init → develop
2. PR #2: feature/prometheus-config → develop


## Practice review:
- Review both PRs
- Add comments
- Request changes if needed
- Approve both
- Merge to develop


## Release to main:
# After both features merged to develop
git checkout develop
git pull origin develop

# Create release branch
git checkout -b release/v1.0.0

# Update version file
cat > VERSION << 'EOF'
1.0.0
EOF

cat > CHANGELOG.md << 'EOF'
# Changelog

## [1.0.0] - 2025-01-XX

### Added
- Backup monitoring script with configurable age threshold
- Log rotation script for application logs
- Terraform initialization for infrastructure
- Prometheus monitoring configuration
- Health check scripts for services

### Documentation
- Contributing guidelines
- README with project structure
- Script documentation
EOF

git add VERSION CHANGELOG.md
git commit -m "chore(release): prepare version 1.0.0

- Add VERSION file
- Add CHANGELOG
- Ready for production release"

git push origin release/v1.0.0


## On GitHub:
1. Create PR: release/v1.0.0 → main
2. Title: "Release v1.0.0"
3. Description: Copy CHANGELOG
4. Merge to main
5. Create Git tag
git checkout main
git pull origin main

# Create and push tag
git tag -a v1.0.0 -m "Release version 1.0.0

First production release with:
- Monitoring scripts
- Terraform configuration
- Prometheus setup"

git push origin v1.0.0


## On GitHub: Create Release
1. Go to "Releases" tab
2. Click "Create a new release"
3. Choose tag: v1.0.0
4. Release title: v1.0.0 - Initial Production Release
5. Description: Paste CHANGELOG content
6. Click "Publish release"


## Practice: Fork and PR workflow (for contributing to open source)
# This simulates contributing to someone else's project
cd ~/devops-learning/month1/week3

# You'll do this with your study partner's repo
# For now, document the process:

cat > fork-workflow.md << 'EOF'
# Fork and Pull Request Workflow

## Steps to contribute to external projects

### 1. Fork repository
- Go to target repo on GitHub
- Click "Fork" button
- Now you have your own copy

### 2. Clone your fork
```bash
git clone git@github.com:YourUsername/their-project.git
cd their-project
```

### 3. Add upstream remote
```bash
git remote add upstream git@github.com:TheirUsername/their-project.git
git remote -v
```

### 4. Create feature branch
```bash
git checkout -b fix/typo-in-readme
```

### 5. Make changes and commit
```bash
# Fix the typo
git add README.md
git commit -m "docs: fix typo in installation instructions"
```

### 6. Push to YOUR fork
```bash
git push origin fix/typo-in-readme
```

### 7. Create Pull Request
- Go to YOUR fork on GitHub
- Click "Compare & pull request"
- Base repository: their-project (upstream)
- Base branch: main
- Head repository: your-fork
- Compare branch: fix/typo-in-readme

### 8. Keep fork synchronized
```bash
git checkout main
git fetch upstream
git merge upstream/main
git push origin main
```

## Best Practices for External PRs
- Read CONTRIBUTING.md first
- Keep changes focused and small
- Follow their code style
- Write clear commit messages
- Be responsive to feedback
- Be patient and polite
EOF

git add fork-workflow.md
git commit -m "docs: add fork and PR workflow guide"
git push
