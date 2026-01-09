#!/bin/bash
# Real DevOps Scenario: Deployment Information Dashboard

# Scenario: You need to create a deployment dashboard that shows:
# 1. Latest commits from GitHub
# 2. Current server weather (for data center location)
# 3. System status

echo "=========================================="
echo "Deployment Information Dashboard"
echo "=========================================="
echo ""

# Configuration
REPO="kubernetes/kubernetes"
DATACENTER_LAT="44.8125"
DATACENTER_LON="20.4612"

# 1. Latest commits
echo "LATEST COMMITS ($REPO)"
echo "----------------------------------------"
commits=$(curl -s "https://api.github.com/repos/$REPO/commits?per_page=3")
echo "$commits" | jq -r '.[] | "  \(.commit.author.date[0:10]) - \(.commit.message | split("\n")[0])" | .[0:70]'
echo ""

# 2. Data center weather
echo "DATA CENTER WEATHER (Belgrade)"
echo "----------------------------------------"
weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$DATACENTER_LAT&longitude=$DATACENTER_LON&current_weather=true")
temp=$(echo $weather | jq -r '.current_weather.temperature')
windspeed=$(echo $weather | jq -r '.current_weather.windspeed')
echo "  Temperature: ${temp}°C"
echo "  Wind Speed: ${windspeed} km/h"
echo ""

# 3. Mock system status (in real scenario, this would be from monitoring API)
echo "SYSTEM STATUS"
echo "----------------------------------------"
echo "  Web Servers:    ✓ Healthy (3/3)"
echo "  Database:       ✓ Healthy"
echo "  Cache:          ✓ Healthy"
echo "  Load Balancer:  ✓ Healthy"
echo ""

# 4. API Health
echo "EXTERNAL APIS"
echo "----------------------------------------"
apis=("GitHub" "Weather" "Monitoring")
for api in "${apis[@]}"; do
    echo "  $api: ✓ Operational"
done
echo ""

echo "=========================================="
echo "Dashboard generated at: $(date)"
echo "=========================================="
