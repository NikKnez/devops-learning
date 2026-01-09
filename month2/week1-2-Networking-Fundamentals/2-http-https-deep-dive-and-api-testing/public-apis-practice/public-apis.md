# Practice with Real Public APIs

## Public APIs for Practice

### No Authentication Required
- JSONPlaceholder - Fake REST API
- REST Countries - Country information
- Open-Meteo - Weather data
- Cat Facts API - Random cat facts
- Dog API - Dog images
- JokeAPI - Random jokes
- Advice Slip - Random advice

### Authentication Required (Free)
- GitHub API - Code repositories
- OpenWeatherMap - Weather data
- NewsAPI - News articles
- CoinGecko - Cryptocurrency data

## API 1: GitHub API

**Base URL:** https://api.github.com
**Authentication:** Optional (higher rate limits with token)
**Rate Limit:** 60/hour (unauthenticated), 5000/hour (authenticated)
**Documentation:** https://docs.github.com/en/rest

### Common Endpoints
```bash
# Get user info
curl https://api.github.com/users/torvalds

# Get user repositories
curl https://api.github.com/users/torvalds/repos

# Search repositories
curl "https://api.github.com/search/repositories?q=devops&sort=stars"

# Get repository info
curl https://api.github.com/repos/kubernetes/kubernetes

# Get repository languages
curl https://api.github.com/repos/kubernetes/kubernetes/languages

# Get repository contributors
curl https://api.github.com/repos/kubernetes/kubernetes/contributors

# Get trending repositories (via search)
curl "https://api.github.com/search/repositories?q=created:>2024-01-01&sort=stars&order=desc"
```

### With Authentication
```bash
# Set your GitHub token (get from https://github.com/settings/tokens)
GITHUB_TOKEN="ghp_your_token_here"

# Authenticated request
curl -H "Authorization: Bearer $GITHUB_TOKEN" \
     https://api.github.com/user

# Check rate limit
curl -H "Authorization: Bearer $GITHUB_TOKEN" \
     https://api.github.com/rate_limit

# Create a gist
curl -X POST https://api.github.com/gists \
     -H "Authorization: Bearer $GITHUB_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{
       "description": "Test gist from API",
       "public": false,
       "files": {
         "test.txt": {
           "content": "Hello from GitHub API"
         }
       }
     }'
```

## API 2: REST Countries

**Base URL:** https://restcountries.com/v3.1
**Authentication:** None required
**Rate Limit:** None
**Documentation:** https://restcountries.com/

### Common Endpoints
```bash
# Get all countries
curl https://restcountries.com/v3.1/all

# Get specific country by name
curl https://restcountries.com/v3.1/name/serbia

# Get country by code
curl https://restcountries.com/v3.1/alpha/rs

# Search countries by capital
curl https://restcountries.com/v3.1/capital/belgrade

# Search by region
curl https://restcountries.com/v3.1/region/europe

# Search by language
curl https://restcountries.com/v3.1/lang/serbian

# Filter fields
curl "https://restcountries.com/v3.1/name/serbia?fields=name,capital,population,area"
```

## API 3: Open-Meteo (Weather)

**Base URL:** https://api.open-meteo.com/v1
**Authentication:** None required
**Rate Limit:** Generous free tier
**Documentation:** https://open-meteo.com/

### Common Endpoints
```bash
# Current weather for Belgrade
curl "https://api.open-meteo.com/v1/forecast?latitude=44.8125&longitude=20.4612&current_weather=true"

# 7-day forecast
curl "https://api.open-meteo.com/v1/forecast?latitude=44.8125&longitude=20.4612&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Europe/Belgrade"

# Hourly forecast
curl "https://api.open-meteo.com/v1/forecast?latitude=44.8125&longitude=20.4612&hourly=temperature_2m,precipitation,windspeed_10m&timezone=Europe/Belgrade"

# Historical weather
curl "https://api.open-meteo.com/v1/forecast?latitude=44.8125&longitude=20.4612&start_date=2024-01-01&end_date=2024-01-07&daily=temperature_2m_max,temperature_2m_min"
```

## API 4: JSONPlaceholder (Testing)

**Base URL:** https://jsonplaceholder.typicode.com
**Authentication:** None required
**Rate Limit:** None
**Documentation:** https://jsonplaceholder.typicode.com/

### All Endpoints
```bash
# Posts
curl https://jsonplaceholder.typicode.com/posts
curl https://jsonplaceholder.typicode.com/posts/1
curl https://jsonplaceholder.typicode.com/posts/1/comments

# Users
curl https://jsonplaceholder.typicode.com/users
curl https://jsonplaceholder.typicode.com/users/1
curl https://jsonplaceholder.typicode.com/users/1/posts

# Comments, Albums, Photos, Todos
curl https://jsonplaceholder.typicode.com/comments
curl https://jsonplaceholder.typicode.com/albums
curl https://jsonplaceholder.typicode.com/photos
curl https://jsonplaceholder.typicode.com/todos

# Filter
curl "https://jsonplaceholder.typicode.com/posts?userId=1"
curl "https://jsonplaceholder.typicode.com/comments?postId=1"
```

## API 5: Cat Facts

**Base URL:** https://catfact.ninja
**Authentication:** None required
```bash
# Random cat fact
curl https://catfact.ninja/fact

# Multiple facts
curl "https://catfact.ninja/facts?limit=5"

# Cat breeds
curl https://catfact.ninja/breeds
```

## API 6: JokeAPI

**Base URL:** https://v2.jokeapi.dev
**Authentication:** None required
```bash
# Random joke
curl https://v2.jokeapi.dev/joke/Any

# Programming jokes only
curl https://v2.jokeapi.dev/joke/Programming

# Safe jokes (no offensive content)
curl "https://v2.jokeapi.dev/joke/Any?safe-mode"

# Specific type
curl "https://v2.jokeapi.dev/joke/Programming?type=single"
```

## Understanding API Responses

### Response Structure
```json
{
  "data": [...],           // Actual data
  "meta": {                // Metadata
    "pagination": {
      "page": 1,
      "per_page": 10,
      "total": 100
    }
  },
  "error": null           // Error info if any
}
```

### Pagination Patterns

**Page-based:**
```bash
curl "https://api.example.com/users?page=2&per_page=10"
```

**Offset-based:**
```bash
curl "https://api.example.com/users?offset=20&limit=10"
```

**Cursor-based:**
```bash
curl "https://api.example.com/users?cursor=abc123&limit=10"
```

### Rate Limit Headers
```
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4999
X-RateLimit-Reset: 1640995200
```

### Error Responses
```json
{
  "error": {
    "code": 404,
    "message": "Resource not found",
    "details": "User with id 999 does not exist"
  }
}
```
