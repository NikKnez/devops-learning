# Subnet Calculation Practice

## Problem 1: Office Network
You need to create a network for 50 computers.

What subnet mask should you use?
- Need: 50 hosts
- /26 gives 62 usable hosts (64 - 2)
- Subnet mask: 255.255.255.192
- CIDR: /26

## Problem 2: Multiple Departments
Company has 3 departments, each needs 30 computers.
You have 192.168.1.0/24 available.

Solution:
- Divide /24 into smaller subnets
- Use /27 (30 usable hosts each)
- Department 1: 192.168.1.0/27 (192.168.1.1-30)
- Department 2: 192.168.1.32/27 (192.168.1.33-62)
- Department 3: 192.168.1.64/27 (192.168.1.65-94)

## Problem 3: AWS VPC Planning
You need to create a VPC for:
- Public subnet: 20 servers
- Private subnet: 100 servers
- Database subnet: 10 servers

Solution using 10.0.0.0/16:
- Public: 10.0.1.0/27 (30 hosts)
- Private: 10.0.2.0/25 (126 hosts)
- Database: 10.0.3.0/28 (14 hosts)

## DevOps Application
This is how you design:
- AWS VPCs
- Kubernetes pod networks
- Docker networks
- Internal company networks
