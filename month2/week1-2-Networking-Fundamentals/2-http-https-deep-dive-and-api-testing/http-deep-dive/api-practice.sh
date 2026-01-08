#!/bin/bash
# Practice with public APIs

echo "=========================================="
echo "Public API Practice"
echo "=========================================="
echo ""

# GitHub API
echo "1. GitHub API - Get Repository Info"
echo "-----------------------------------"
curl -s https://api.github.com/repos/torvalds/linux | \
  python3 -c "import sys, json; data=json.load(sys.stdin); print(f\"Name: {data['name']}\nStars: {data['stargazers_count']}\nLanguage: {data['language']}\")"
echo ""

# JSONPlaceholder API
echo "2. JSONPlaceholder - Sample REST API"
echo "------------------------------------"
echo "Users:"
curl -s https://jsonplaceholder.typicode.com/users | \
  python3 -c "import sys, json; users=json.load(sys.stdin); [print(f\"  {u['id']}: {u['name']}\") for u in users[:3]]"
echo ""

# REST Countries API
echo "3. REST Countries - Country Information"
echo "---------------------------------------"
curl -s https://restcountries.com/v3.1/name/serbia | \
  python3 -c "import sys, json; data=json.load(sys.stdin)[0]; print(f\"Country: {data['name']['common']}\nCapital: {data['capital'][0]}\nPopulation: {data['population']:,}\")"
echo ""

# Weather API (no key needed for demo)
echo "4. Open-Meteo - Weather Data"
echo "----------------------------"
curl -s "https://api.open-meteo.com/v1/forecast?latitude=44.8125&longitude=20.4612&current_weather=true" | \
  python3 -c "import sys, json; data=json.load(sys.stdin)['current_weather']; print(f\"Temperature: {data['temperature']}°C\nWind Speed: {data['windspeed']} km/h\")"
echo ""

echo "=========================================="
echo "Try these APIs yourself:"
echo "  - GitHub: https://api.github.com"
echo "  - JSONPlaceholder: https://jsonplaceholder.typicode.com"
echo "  - REST Countries: https://restcountries.com"
echo "  - Cat Facts: https://catfact.ninja/fact"
echo "=========================================="
