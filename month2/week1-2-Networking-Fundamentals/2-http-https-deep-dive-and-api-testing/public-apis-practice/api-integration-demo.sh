#!/bin/bash
# Comprehensive API Integration Demo

echo "=========================================="
echo "Multi-API Integration Demo"
echo "=========================================="
echo ""

# 1. Get country information
echo "STEP 1: Get Country Information"
echo "-------------------------------"
country="serbia"
country_data=$(curl -s "https://restcountries.com/v3.1/name/$country")

name=$(echo $country_data | jq -r '.[0].name.common')
capital=$(echo $country_data | jq -r '.[0].capital[0]')
population=$(echo $country_data | jq -r '.[0].population')
area=$(echo $country_data | jq -r '.[0].area')

echo "Country: $name"
echo "Capital: $capital"
echo "Population: $(printf "%'d" $population)"
echo "Area: $(printf "%'d" $area) km²"
echo ""
read -p "Press Enter to continue..."
echo ""

# 2. Get weather for capital
echo "STEP 2: Get Weather for Capital"
echo "-------------------------------"
# Get coordinates for Belgrade
lat=$(echo $country_data | jq -r '.[0].capitalInfo.latlng[0]')
lon=$(echo $country_data | jq -r '.[0].capitalInfo.latlng[1]')

weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true")
temp=$(echo $weather | jq -r '.current_weather.temperature')
windspeed=$(echo $weather | jq -r '.current_weather.windspeed')

echo "Current weather in $capital:"
echo "  Temperature: ${temp}°C"
echo "  Wind Speed: ${windspeed} km/h"
echo ""
read -p "Press Enter to continue..."
echo ""

# 3. Get GitHub activity for country
echo "STEP 3: GitHub Activity from $name"
echo "-------------------------------"
echo "Top repositories from Serbia..."

# Search for repos from Serbian developers
repos=$(curl -s "https://api.github.com/search/repositories?q=location:serbia&sort=stars&order=desc&per_page=3")

echo "$repos" | jq -r '.items[] | "  \(.name) - \(.stargazers_count) stars - \(.language)"'
echo ""
read -p "Press Enter to continue..."
echo ""

# 4. Fun fact
echo "STEP 4: Random Cat Fact (Because Why Not?)"
echo "------------------------------------------"
curl -s https://catfact.ninja/fact | jq -r '.fact'
echo ""

echo "=========================================="
echo "Multi-API Integration Complete!"
echo "=========================================="
echo ""
echo "This demo showed:"
echo "  1. Country data from REST Countries API"
echo "  2. Weather data from Open-Meteo API"
echo "  3. GitHub repository search"
echo "  4. Random data from Cat Facts API"
echo ""
echo "In real DevOps, you might combine:"
echo "  - Monitoring APIs (Prometheus, Datadog)"
echo "  - Cloud provider APIs (AWS, Azure, GCP)"
echo "  - CI/CD APIs (Jenkins, GitLab, GitHub Actions)"
echo "  - Communication APIs (Slack, PagerDuty)"
echo "=========================================="
