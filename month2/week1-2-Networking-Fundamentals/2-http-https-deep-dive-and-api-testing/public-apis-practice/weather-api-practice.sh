#!/bin/bash
# Weather API Practice Script

API="https://api.open-meteo.com/v1"

# Cities with coordinates
declare -A CITIES
CITIES[Belgrade]="44.8125,20.4612"
CITIES[London]="51.5074,-0.1278"
CITIES[NewYork]="40.7128,-74.0060"
CITIES[Tokyo]="35.6762,139.6503"
CITIES[Sydney]="-33.8688,151.2093"

echo "=========================================="
echo "Weather API Practice"
echo "=========================================="
echo ""

# Exercise 1: Current weather
echo "EXERCISE 1: Current Weather"
echo "---------------------------"
for city in "${!CITIES[@]}"; do
    coords=${CITIES[$city]}
    lat=$(echo $coords | cut -d, -f1)
    lon=$(echo $coords | cut -d, -f2)
    
    weather=$(curl -s "$API/forecast?latitude=$lat&longitude=$lon&current_weather=true")
    temp=$(echo $weather | jq -r '.current_weather.temperature')
    windspeed=$(echo $weather | jq -r '.current_weather.windspeed')
    
    echo "  $city: ${temp}°C, Wind: ${windspeed} km/h"
done
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 2: 7-day forecast for Belgrade
echo "EXERCISE 2: 7-Day Forecast (Belgrade)"
echo "-------------------------------------"
coords=${CITIES[Belgrade]}
lat=$(echo $coords | cut -d, -f1)
lon=$(echo $coords | cut -d, -f2)

forecast=$(curl -s "$API/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Europe/Belgrade")

echo "$forecast" | jq -r '.daily | .time as $dates | .temperature_2m_max as $max | .temperature_2m_min as $min | .precipitation_sum as $precip | range(0;7) | "\($dates[.]) - Max: \($max[.])°C, Min: \($min[.])°C, Rain: \($precip[.])mm"'
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 3: Compare cities
echo "EXERCISE 3: Temperature Comparison"
echo "----------------------------------"
echo "Current temperatures across cities:"
for city in "${!CITIES[@]}"; do
    coords=${CITIES[$city]}
    lat=$(echo $coords | cut -d, -f1)
    lon=$(echo $coords | cut -d, -f2)
    
    temp=$(curl -s "$API/forecast?latitude=$lat&longitude=$lon&current_weather=true" | \
        jq -r '.current_weather.temperature')
    
    printf "  %-12s %6.1f°C\n" "$city:" "$temp"
done | sort -k2 -n -r
echo ""

echo "=========================================="
echo "Weather API Practice Complete!"
echo "=========================================="
