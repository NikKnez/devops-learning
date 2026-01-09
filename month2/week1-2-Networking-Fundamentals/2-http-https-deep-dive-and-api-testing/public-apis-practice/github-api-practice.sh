#!/bin/bash
# GitHub API Practice Script

# Note: Set GITHUB_TOKEN for higher rate limits
# export GITHUB_TOKEN="ghp_your_token_here"

API="https://api.github.com"

if [ -n "$GITHUB_TOKEN" ]; then
    AUTH_HEADER="Authorization: Bearer $GITHUB_TOKEN"
else
    AUTH_HEADER=""
    echo "Note: Running without authentication (60 requests/hour limit)"
    echo "Set GITHUB_TOKEN for 5000 requests/hour"
    echo ""
fi

echo "=========================================="
echo "GitHub API Practice"
echo "=========================================="
echo ""

# Exercise 1: Get user information
echo "EXERCISE 1: Get User Information"
echo "--------------------------------"
echo "Fetching torvalds (Linus Torvalds)..."
if [ -n "$AUTH_HEADER" ]; then
    curl -s -H "$AUTH_HEADER" "$API/users/torvalds" | \
        jq '{name, company, location, public_repos, followers}'
else
    curl -s "$API/users/torvalds" | \
        jq '{name, company, location, public_repos, followers}'
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 2: Search repositories
echo "EXERCISE 2: Search Popular DevOps Repositories"
echo "----------------------------------------------"
echo "Top 5 DevOps repos by stars..."
if [ -n "$AUTH_HEADER" ]; then
    curl -s -H "$AUTH_HEADER" \
        "$API/search/repositories?q=devops&sort=stars&order=desc&per_page=5" | \
        jq '.items[] | {name, stars: .stargazers_count, language, url: .html_url}'
else
    curl -s "$API/search/repositories?q=devops&sort=stars&order=desc&per_page=5" | \
        jq '.items[] | {name, stars: .stargazers_count, language, url: .html_url}'
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 3: Repository details
echo "EXERCISE 3: Repository Details"
echo "------------------------------"
echo "Kubernetes repository info..."
if [ -n "$AUTH_HEADER" ]; then
    curl -s -H "$AUTH_HEADER" "$API/repos/kubernetes/kubernetes" | \
        jq '{name, description, stars: .stargazers_count, forks, open_issues, language}'
else
    curl -s "$API/repos/kubernetes/kubernetes" | \
        jq '{name, description, stars: .stargazers_count, forks, open_issues, language}'
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 4: Repository languages
echo "EXERCISE 4: Repository Languages"
echo "--------------------------------"
echo "Languages used in kubernetes/kubernetes..."
if [ -n "$AUTH_HEADER" ]; then
    curl -s -H "$AUTH_HEADER" "$API/repos/kubernetes/kubernetes/languages" | \
        jq 'to_entries | map({language: .key, bytes: .value}) | sort_by(.bytes) | reverse | .[0:5]'
else
    curl -s "$API/repos/kubernetes/kubernetes/languages" | \
        jq 'to_entries | map({language: .key, bytes: .value}) | sort_by(.bytes) | reverse | .[0:5]'
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 5: Check rate limit
echo "EXERCISE 5: Rate Limit Status"
echo "-----------------------------"
if [ -n "$AUTH_HEADER" ]; then
    curl -s -H "$AUTH_HEADER" "$API/rate_limit" | \
        jq '.rate | {limit, remaining, reset: (.reset | strftime("%Y-%m-%d %H:%M:%S"))}'
else
    curl -s "$API/rate_limit" | \
        jq '.rate | {limit, remaining, reset: (.reset | strftime("%Y-%m-%d %H:%M:%S"))}'
fi
echo ""

echo "=========================================="
echo "GitHub API Practice Complete!"
echo "=========================================="
