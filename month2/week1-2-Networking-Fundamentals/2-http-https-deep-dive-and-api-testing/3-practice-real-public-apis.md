# Practice with Real Public APIs

## APIs Practiced

### 1. GitHub API
- User information and repositories
- Repository search and details
- Languages and contributors
- Rate limiting and authentication
- Creating gists

### 2. REST Countries API
- Country information (name, capital, population)
- Search by name, capital, region, language
- Field filtering
- Coordinate data

### 3. Open-Meteo (Weather)
- Current weather conditions
- 7-day forecasts
- Hourly predictions
- Historical data
- Multiple locations

### 4. JSONPlaceholder
- Posts, users, comments
- CRUD operations
- Filtering and pagination
- Testing API patterns

### 5. Other APIs
- Cat Facts API
- JokeAPI
- Advice Slip

## Skills Developed

### API Integration
- Combining multiple APIs
- Data correlation across sources
- Building dashboards from API data
- Real-time information gathering

### Error Handling
- HTTP status code checking
- Retry logic with exponential backoff
- Timeout configuration
- Response validation

### Performance
- Parallel API calls
- Response caching
- Request optimization
- Rate limit management

### Security
- Token authentication
- Credential management
- Sanitized logging
- Secure storage practices


## Scripts Created
1. github-api-practice.sh - GitHub API exploration
2. weather-api-practice.sh - Weather data retrieval
3. api-integration-demo.sh - Multi-API integration
4. api-health-monitor.sh - API availability monitoring
5. devops-api-scenario.sh - Real deployment dashboard


## Real DevOps Applications

### Deployment Verification
# Check service health after deployment
for endpoint in /health /version /metrics; do
    curl -f "https://api.example.com$endpoint" || rollback
done

### Infrastructure Monitoring
# Monitor multiple services
apis=(api.service1.com api.service2.com api.service3.com)
for api in "${apis[@]}"; do
    curl -f "https://$api/health" || alert_team
done

### Data Aggregation
# Combine data from multiple sources
weather=$(curl -s weather-api.com)
github=$(curl -s api.github.com/repos/company/project)
monitoring=$(curl -s monitoring-api.com/metrics)

# Generate report
create_report "$weather" "$github" "$monitoring"

### Automated Testing
# Test API endpoints
test_suite=(
    "GET|/users|200"
    "GET|/health|200"
    "POST|/auth|401"  # Should fail without creds
)

for test in "${test_suite[@]}"; do
    run_test "$test" || exit 1
done


## API Best Practices Learned
1. Authentication
     - Store tokens in environment variables
     - Never hardcode credentials
     - Use appropriate auth method for API
2. Error Handling
     - Always check HTTP status codes
     - Implement retry logic
     - Set timeouts
     - Validate responses
3. Rate Limiting
     - Check rate limit headers
     - Implement delays between requests
     - Cache responses when possible
     - Use batch endpoints if available
4. Performance
     - Request only needed fields
     - Use pagination properly
     - Parallel requests when appropriate
     - Cache frequently accessed data
5. Monitoring
     - Log API calls and responses
     - Track response times
     - Alert on failures
     - Monitor rate limit usage


## Key Takeaways
1. APIs are everywhere in DevOps
     - Cloud providers (AWS, Azure, GCP)
     - CI/CD platforms (Jenkins, GitHub Actions)
     - Monitoring tools (Prometheus, Datadog)
     - Communication (Slack, PagerDuty)
2. Understanding APIs is critical
     - Automation depends on APIs
     - Infrastructure as Code uses APIs
     - Monitoring and alerting via APIs
     - Integration between tools
3. Error handling is not optional
     - APIs fail
     - Networks are unreliable
     - Rate limits exist
     - Always plan for failure
4. Security matters
     - Protect credentials
     - Use HTTPS
     - Validate inputs
     - Sanitize logs

# Next: Week 2 Review and Python Preparation
