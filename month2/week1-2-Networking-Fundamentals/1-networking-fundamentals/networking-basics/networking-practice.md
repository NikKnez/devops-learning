# IP Addressing Practice


## My Network Information

### Find your IP address (multiple methods)
```bash
# Method 1: ip command (modern Linux)
ip addr show

# Method 2: ifconfig (older, but still works)
ifconfig

# Method 3: hostname command
hostname -I

# Method 4: Check specific interface
ip addr show eth0  # or wlan0 for wireless
```

### Understanding the output
- inet: IPv4 address
- inet6: IPv6 address
- netmask: Subnet mask
- broadcast: Broadcast address

### My actual network info:
IPv4: [FILL IN]
Netmask: [FILL IN]
Gateway: [FILL IN]
DNS: [FILL IN]

## IP Address Classes

### Class A
- Range: 1.0.0.0 to 126.0.0.0
- Default mask: 255.0.0.0 (/8)
- Used for: Very large networks

### Class B
- Range: 128.0.0.0 to 191.255.0.0
- Default mask: 255.255.0.0 (/16)
- Used for: Medium to large networks

### Class C
- Range: 192.0.0.0 to 223.255.255.0
- Default mask: 255.255.255.0 (/24)
- Used for: Small networks (most common)

### Special Addresses
- 127.0.0.1: Localhost (loopback)
- 192.168.x.x: Private networks
- 10.x.x.x: Private networks
- 172.16.x.x - 172.31.x.x: Private networks
- 0.0.0.0: Any address
- 255.255.255.255: Broadcast

## CIDR Notation Practice

### Understanding /24, /16, etc.

/32 = 255.255.255.255 (1 host)
/24 = 255.255.255.0 (254 hosts)
/16 = 255.255.0.0 (65,534 hosts)
/8 = 255.0.0.0 (16,777,214 hosts)

### Examples:
- 192.168.1.0/24
  - Network: 192.168.1.0
  - Usable IPs: 192.168.1.1 - 192.168.1.254
  - Broadcast: 192.168.1.255
  - Total hosts: 254

- 10.0.0.0/16
  - Network: 10.0.0.0
  - Usable IPs: 10.0.0.1 - 10.0.255.254
  - Broadcast: 10.0.255.255
  - Total hosts: 65,534

## Practical Exercises

### Exercise 1: Calculate subnet info
Given: 192.168.10.0/24
Network address: 192.168.10.0
First usable: 192.168.10.1
Last usable: 192.168.10.254
Broadcast: 192.168.10.255
Total hosts: 254

### Exercise 2: Identify network class
- 172.16.50.10 → Class B
- 10.20.30.40 → Class A
- 192.168.1.100 → Class C
- 8.8.8.8 → Class A (Google DNS)

### Exercise 3: CIDR conversion
255.255.255.0 = /24
255.255.0.0 = /16
255.255.255.128 = /25
255.255.255.192 = /26

## Questions to Answer:
1. What is my current IP address?
2. What subnet am I on?
3. What is my default gateway?
4. How many devices can be on my network?
