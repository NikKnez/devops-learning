#!/bin/bash
# API Health Monitoring Script

APIs=(
    "GitHub|https://api.github.com"
    "JSONPlaceholder|https://jsonplaceholder.typicode.com/posts/1"
    "REST Countries|https://restcountries.com/v3.1/all"
    "Cat Facts|https://catfact.ninja/fact"
    "Open-Meteo|https://api.open-meteo.com/v1/forecast?latitude=44.81&longitude=20.46&current_weather=true"
)

echo "=========================================="
echo "API Health Monitor"
echo "=========================================="
echo ""
echo "Checking API availability and response times..."
echo ""

for api in "${APIs[@]}"; do
    name=$(echo $api | cut -d'|' -f1)
    url=$(echo $api | cut -d'|' -f2)
    
    # Measure response time and status
    response=$(curl -s -o /dev/null -w "%{http_code}|%{time_total}" "$url")
    http_code=$(echo $response | cut -d'|' -f1)
    time=$(echo $response | cut -d'|' -f2)
    
    # Status indicator
    if [ "$http_code" -eq 200 ]; then
        status="✓"
    else
        status="✗"
    fi
    
    printf "  [$status] %-18s HTTP %s - %.3fs\n" "$name" "$http_code" "$time"
done

echo ""
echo "=========================================="
