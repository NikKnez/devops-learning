# AWS Security Group Templates

## Template 1: Web Server Security Group

**Name:** web-servers-sg
**Description:** Security group for public-facing web servers

**Inbound Rules:**
| Type  | Protocol | Port | Source      | Description           |
|-------|----------|------|-------------|-----------------------|
| HTTP  | TCP      | 80   | 0.0.0.0/0   | HTTP from internet    |
| HTTPS | TCP      | 443  | 0.0.0.0/0   | HTTPS from internet   |
| SSH   | TCP      | 22   | bastion-sg  | SSH from bastion only |

**Outbound Rules:**
| Type        | Protocol | Port | Destination | Description     |
|-------------|----------|------|-------------|-----------------|
| All traffic | All      | All  | 0.0.0.0/0   | Allow all out   |

---

## Template 2: Application Server Security Group

**Name:** app-servers-sg
**Description:** Security group for application servers in private subnet

**Inbound Rules:**
| Type       | Protocol | Port | Source        | Description              |
|------------|----------|------|---------------|--------------------------|
| Custom TCP | TCP      | 8080 | web-servers-sg| App traffic from web     |
| SSH        | TCP      | 22   | bastion-sg    | SSH from bastion         |

**Outbound Rules:**
| Type       | Protocol | Port | Destination | Description              |
|------------|----------|------|-------------|--------------------------|
| PostgreSQL | TCP      | 5432 | database-sg | Database access          |
| Redis      | TCP      | 6379 | cache-sg    | Cache access             |
| HTTPS      | TCP      | 443  | 0.0.0.0/0   | External API calls       |

---

## Template 3: Database Security Group

**Name:** database-sg
**Description:** Security group for RDS PostgreSQL

**Inbound Rules:**
| Type       | Protocol | Port | Source        | Description              |
|------------|----------|------|---------------|--------------------------|
| PostgreSQL | TCP      | 5432 | app-servers-sg| DB access from app only  |

**Outbound Rules:**
| Type | Protocol | Port | Destination | Description              |
|------|----------|------|-------------|--------------------------|
| None | -        | -    | -           | No outbound needed       |

---

## Template 4: Load Balancer Security Group

**Name:** alb-sg
**Description:** Security group for Application Load Balancer

**Inbound Rules:**
| Type  | Protocol | Port | Source    | Description           |
|-------|----------|------|-----------|-----------------------|
| HTTP  | TCP      | 80   | 0.0.0.0/0 | HTTP from internet    |
| HTTPS | TCP      | 443  | 0.0.0.0/0 | HTTPS from internet   |

**Outbound Rules:**
| Type       | Protocol | Port | Destination     | Description         |
|------------|----------|------|-----------------|---------------------|
| Custom TCP | TCP      | 8080 | web-servers-sg  | Forward to web      |

---

## Template 5: Bastion Host Security Group

**Name:** bastion-sg
**Description:** Security group for SSH bastion/jump host

**Inbound Rules:**
| Type | Protocol | Port | Source           | Description           |
|------|----------|------|------------------|-----------------------|
| SSH  | TCP      | 22   | YOUR_IP/32       | SSH from office only  |

**Outbound Rules:**
| Type | Protocol | Port | Destination | Description              |
|------|----------|------|-------------|--------------------------|
| SSH  | TCP      | 22   | 10.0.0.0/16 | SSH to VPC instances     |

---

## Security Group Chaining Example
```
Internet
    ↓
[ALB-SG: Allow 80,443 from 0.0.0.0/0]
    ↓
[Web-SG: Allow 8080 from ALB-SG]
    ↓
[App-SG: Allow 8081 from Web-SG]
    ↓
[DB-SG: Allow 5432 from App-SG]
```

Each layer only allows traffic from the previous layer.
This is called "defense in depth."
