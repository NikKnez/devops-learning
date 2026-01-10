# Review - HTTP/HTTPS & APIs

## Week 2 Summary (Days 37-40)

### Day 37: HTTP Protocol Deep Dive
**Key Concepts:**
- HTTP request/response structure
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Status codes (2xx, 3xx, 4xx, 5xx)
- Headers (request, response, security)
- Query parameters and encoding
- HTTP versions (1.0, 1.1, 2, 3)

**Commands:**
- curl https://api.example.com
- curl -I https://api.example.com
- curl -v https://api.example.com
- curl -X POST -d '{"key":"value"}' https://api.example.com

**Real DevOps Use:**
- API testing
- Health checks
- Integration testing
- Debugging applications

### Day 38: Advanced curl & Authentication
**Key Concepts:**
- Advanced curl options (-H, -d, -F, -u)
- Authentication methods (Basic, Bearer, API keys, OAuth, Cookies)
- JSON processing with jq
- Error handling and retries
- Timing and performance measurement
- SSL/TLS options

**Commands:**
- curl -u user:pass https://api.example.com
- curl -H "Authorization: Bearer token" https://api.example.com
- curl -X POST -H "Content-Type: application/json" -d @file.json
- curl -w "%{time_total}" -o /dev/null -s https://api.example.com

**Real DevOps Use:**
- Authenticated API calls
- Deployment verification
- Performance monitoring
- Automated testing

### Day 39: Public API Practice
**Key Concepts:**
- Working with real APIs (GitHub, Weather, Countries)
- Rate limiting and pagination
- Multi-API integration
- Error responses and handling
- API monitoring
- Best practices

**APIs Used:**
- GitHub API (repositories, users)
- REST Countries (country data)
- Open-Meteo (weather forecasts)
- JSONPlaceholder (testing)
- Cat Facts, JokeAPI

**Real DevOps Use:**
- Data aggregation
- External service integration
- Automated reporting
- Health monitoring

### Day 40: Review & Python Prep
**Today's Focus:**
- Week 2 knowledge check
- Identify gaps
- Prepare for Python automation

## Week 2 Knowledge Check

Answer these questions:

### HTTP Basics
1. What are the three parts of an HTTP request?
2. What's the difference between PUT and PATCH?
3. What does HTTP status code 502 mean?
4. What header indicates the response content type?

### curl
5. How do you send a POST request with JSON data?
6. How do you follow redirects?
7. How do you measure response time?
8. How do you save response headers to a file?

### Authentication
9. What are the main authentication methods for APIs?
10. How do you send a Bearer token?
11. Where should you store API credentials?
12. What's the difference between OAuth 1.0 and 2.0?

### APIs
13. What is rate limiting and why does it exist?
14. What is pagination in APIs?
15. How do you handle API errors properly?
16. What's the difference between public and private APIs?

## Answers

1. Request line, headers, body (optional)
2. PUT replaces entire resource, PATCH updates specific fields
3. Bad Gateway - upstream server returned invalid response
4. Content-Type header
5. `curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' URL`
6. `curl -L URL`
7. `curl -w "%{time_total}" -o /dev/null -s URL`
8. `curl -D headers.txt URL` or `curl -i URL > response.txt`
9. Basic Auth, Bearer Token, API Keys, OAuth, Session Cookies
10. `curl -H "Authorization: Bearer TOKEN" URL`
11. Environment variables, secrets manager, config files (not in code!)
12. OAuth 2.0 is simpler, uses bearer tokens; OAuth 1.0 uses signatures
13. Prevents abuse, ensures fair usage, protects server resources
14. Breaking large result sets into pages/chunks
15. Check status codes, implement retries, validate responses, log errors
16. Public: Anyone can access; Private: Authentication required

## Hands-on Review Exercises
