# HTTP Protocol Deep Dive

## HTTP Request Structure

Every HTTP request has three parts:

### 1. Request Line
```
METHOD /path HTTP/version
GET /api/users HTTP/1.1
POST /api/users HTTP/1.1
```

### 2. Headers
```
Host: api.example.com
User-Agent: Mozilla/5.0
Accept: application/json
Content-Type: application/json
Authorization: Bearer token123
```

### 3. Body (optional, for POST/PUT/PATCH)
```json
{
  "name": "John Doe",
  "email": "john@example.com"
}
```

## HTTP Response Structure

Every HTTP response has:

### 1. Status Line
```
HTTP/version STATUS_CODE STATUS_TEXT
HTTP/1.1 200 OK
HTTP/1.1 404 Not Found
```

### 2. Headers
```
Content-Type: application/json
Content-Length: 1234
Server: nginx/1.18.0
Cache-Control: max-age=3600
Set-Cookie: session=abc123
```

### 3. Body (the actual content)
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

## HTTP Methods in Detail

### GET - Retrieve Resource
**Purpose:** Read data, no side effects
**Has body:** No
**Idempotent:** Yes (same result every time)
**Cacheable:** Yes
```bash
GET /api/users/123 HTTP/1.1
Host: api.example.com

Response:
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 123,
  "name": "John"
}
```

### POST - Create Resource
**Purpose:** Create new resource
**Has body:** Yes
**Idempotent:** No (creates new resource each time)
**Cacheable:** No
```bash
POST /api/users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane",
  "email": "jane@example.com"
}

Response:
HTTP/1.1 201 Created
Location: /api/users/124
Content-Type: application/json

{
  "id": 124,
  "name": "Jane",
  "email": "jane@example.com"
}
```

### PUT - Update/Replace Resource
**Purpose:** Replace entire resource
**Has body:** Yes
**Idempotent:** Yes
**Cacheable:** No
```bash
PUT /api/users/123 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "id": 123,
  "name": "John Updated",
  "email": "john.new@example.com",
  "age": 30
}

Response:
HTTP/1.1 200 OK
```

### PATCH - Partial Update
**Purpose:** Update specific fields
**Has body:** Yes
**Idempotent:** Generally no
**Cacheable:** No
```bash
PATCH /api/users/123 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "email": "john.updated@example.com"
}

Response:
HTTP/1.1 200 OK
```

### DELETE - Remove Resource
**Purpose:** Delete resource
**Has body:** No
**Idempotent:** Yes
**Cacheable:** No
```bash
DELETE /api/users/123 HTTP/1.1
Host: api.example.com

Response:
HTTP/1.1 204 No Content
```

## HTTP Status Codes - Complete Reference

### 1xx - Informational (rarely seen)
- **100 Continue:** Server received request headers, client should send body
- **101 Switching Protocols:** Server switching to protocol requested by client (WebSocket)

### 2xx - Success
- **200 OK:** Request succeeded
- **201 Created:** Resource created successfully (POST)
- **202 Accepted:** Request accepted, processing not complete
- **204 No Content:** Success but no content to return (DELETE)
- **206 Partial Content:** Returning only part of resource (range requests)

### 3xx - Redirection
- **301 Moved Permanently:** Resource permanently moved, update bookmarks
- **302 Found:** Temporary redirect, use original URL for future requests
- **304 Not Modified:** Resource not changed, use cached version
- **307 Temporary Redirect:** Like 302 but method must not change
- **308 Permanent Redirect:** Like 301 but method must not change

### 4xx - Client Errors
- **400 Bad Request:** Invalid syntax, server can't process
- **401 Unauthorized:** Authentication required
- **403 Forbidden:** Authenticated but no permission
- **404 Not Found:** Resource doesn't exist
- **405 Method Not Allowed:** HTTP method not supported for this resource
- **408 Request Timeout:** Server timed out waiting for request
- **409 Conflict:** Request conflicts with current state (duplicate)
- **410 Gone:** Resource permanently deleted
- **413 Payload Too Large:** Request body too large
- **415 Unsupported Media Type:** Content-Type not supported
- **422 Unprocessable Entity:** Syntax OK but semantic errors
- **429 Too Many Requests:** Rate limit exceeded

### 5xx - Server Errors
- **500 Internal Server Error:** Generic server error
- **501 Not Implemented:** Server doesn't support functionality
- **502 Bad Gateway:** Invalid response from upstream server
- **503 Service Unavailable:** Server temporarily unavailable
- **504 Gateway Timeout:** Upstream server didn't respond in time

## HTTP Headers Reference

### Request Headers

**General Headers:**
```
Host: api.example.com                    # Required in HTTP/1.1
User-Agent: curl/7.68.0                  # Client software
Accept: application/json                  # Preferred response format
Accept-Language: en-US,en;q=0.9          # Preferred language
Accept-Encoding: gzip, deflate, br       # Supported compressions
```

**Authentication Headers:**
```
Authorization: Bearer eyJhbGc...         # Auth token
Authorization: Basic dXNlcjpwYXNz       # Basic auth (base64)
Cookie: session=abc123; user_id=456      # Session cookies
```

**Content Headers:**
```
Content-Type: application/json           # Body format
Content-Length: 1234                     # Body size in bytes
Content-Encoding: gzip                   # Body compression
```

**Caching Headers:**
```
Cache-Control: no-cache                  # Don't use cached version
If-None-Match: "abc123"                  # Conditional request (ETag)
If-Modified-Since: Sat, 29 Oct 2024...  # Conditional request (time)
```

**Custom Headers:**
```
X-Request-ID: req-123456                 # Request tracking
X-API-Key: your-api-key                  # API authentication
X-Forwarded-For: 203.0.113.1            # Original client IP (proxy)
```

### Response Headers

**Content Headers:**
```
Content-Type: application/json; charset=utf-8
Content-Length: 2048
Content-Encoding: gzip
Content-Language: en
```

**Caching Headers:**
```
Cache-Control: max-age=3600, public      # Cache for 1 hour
Expires: Thu, 01 Dec 2024 16:00:00 GMT  # Absolute expiry
ETag: "abc123"                           # Version identifier
Last-Modified: Wed, 21 Oct 2024 07:28:00 GMT
```

**Security Headers:**
```
Strict-Transport-Security: max-age=31536000  # Force HTTPS
X-Content-Type-Options: nosniff              # Prevent MIME sniffing
X-Frame-Options: DENY                        # Prevent clickjacking
Content-Security-Policy: default-src 'self'  # XSS protection
X-XSS-Protection: 1; mode=block             # XSS filter
```

**Cookie Headers:**
```
Set-Cookie: session=xyz789; Path=/; HttpOnly; Secure; SameSite=Strict
```

**CORS Headers:**
```
Access-Control-Allow-Origin: https://example.com
Access-Control-Allow-Methods: GET, POST, PUT
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Max-Age: 86400
```

**Server Info:**
```
Server: nginx/1.18.0
X-Powered-By: Express
```

## HTTP Versions

### HTTP/1.0 (1996)
- One request per connection
- No persistent connections
- Simple but slow

### HTTP/1.1 (1997) - Most common today
- Persistent connections (Keep-Alive)
- Pipelining (multiple requests without waiting)
- Chunked transfer encoding
- Host header required
- Better caching

### HTTP/2 (2015) - Growing adoption
- Multiplexing (multiple requests on one connection)
- Server push
- Header compression
- Binary protocol (not text)
- Much faster

### HTTP/3 (2022) - Newest
- Built on QUIC (UDP-based)
- Even faster connection setup
- Better for mobile/unreliable networks

## Query Parameters

**Format:** `?key1=value1&key2=value2`
```
GET /api/users?page=2&limit=10&sort=name&order=asc HTTP/1.1

Breakdown:
- page=2        # Second page
- limit=10      # 10 items per page
- sort=name     # Sort by name field
- order=asc     # Ascending order
```

**Special characters encoding:**
```
Space:     %20 or +
&:         %26
=:         %3D
/:         %2F
?:         %3F

Example:
"hello world" → hello%20world or hello+world
"user&admin" → user%26admin
```

## Request/Response Cycle
```
1. Client DNS Lookup
   example.com → 93.184.216.34

2. Client TCP Connection
   Three-way handshake (SYN, SYN-ACK, ACK)

3. Client TLS Handshake (HTTPS)
   Certificate verification, key exchange

4. Client sends HTTP Request
   GET /api/users HTTP/1.1
   Host: example.com
   (headers...)

5. Server processes request
   - Route matching
   - Authentication/authorization
   - Database query
   - Business logic

6. Server sends HTTP Response
   HTTP/1.1 200 OK
   Content-Type: application/json
   (headers...)
   (body...)

7. Client processes response
   - Parse headers
   - Handle status code
   - Parse body
   - Update UI

8. Connection handling
   - Keep-Alive: Connection stays open
   - Close: Connection closes
```

## Common HTTP Patterns

### Pagination
```
GET /api/users?page=2&per_page=20

Response:
{
  "data": [...],
  "pagination": {
    "current_page": 2,
    "total_pages": 10,
    "total_items": 200,
    "per_page": 20
  }
}
```

### Filtering
```
GET /api/users?status=active&role=admin&created_after=2024-01-01
```

### Sorting
```
GET /api/users?sort=created_at&order=desc
```

### Field Selection
```
GET /api/users?fields=id,name,email
```

### Versioning
```
# URL versioning
GET /api/v1/users

# Header versioning
GET /api/users
Accept: application/vnd.api.v1+json

# Query parameter
GET /api/users?version=1
```

### Rate Limiting Headers
```
Response Headers:
X-RateLimit-Limit: 1000        # Total allowed per hour
X-RateLimit-Remaining: 950     # Requests remaining
X-RateLimit-Reset: 1640995200  # Unix timestamp for reset
Retry-After: 3600              # Seconds until reset
```
