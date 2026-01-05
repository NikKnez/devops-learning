# DNS Deep Dive


## What is DNS?

DNS translates domain names to IP addresses:
- google.com → 142.250.185.46
- github.com → 140.82.121.4

Without DNS, you'd need to remember IP addresses!

## DNS Hierarchy
```
Root (.)
    |
TLD (.com, .org, .net)
    |
Domain (google.com)
    |
Subdomain (mail.google.com)
```

## DNS Record Types

### A Record
Maps domain to IPv4 address
example.com → 192.0.2.1

### AAAA Record
Maps domain to IPv6 address
example.com → 2001:0db8:85a3::1

### CNAME Record
Alias for another domain
www.example.com → example.com

### MX Record
Mail server for domain
example.com → mail.example.com

### TXT Record
Text information (often for verification)
Used for: SPF, DKIM, domain verification

### NS Record
Name servers for domain
example.com → ns1.nameserver.com

## DNS Query Process

1. User types: google.com
2. Check local cache
3. Query DNS resolver (ISP)
4. Resolver queries root server
5. Root points to .com TLD server
6. TLD points to google.com nameserver
7. Nameserver returns IP address
8. Browser connects to IP

## Practical DNS Commands

See commands below...
