# Day 7: Manual Deployment Practice

## Project Deployed
Python_AI_University

## What I Did

1. Cloned project from GitHub
git clone https://github.com/NikKnez/Python_AI_University.git

2. Set parameters for seting nginx server and paths in folders root /etc/nginx/sites-available and /etc/nginx/sites-enabled
nano /etc/nginx/sites-available
nano /etc/nginx/sites-enabled

3. Set correct permissions
sudo chown -R www-data:www-data /home/nikola/Python_AI_University
sudo chmod -R 755 /home/nikola/Python_AI_University

4. Restarted nginx
sudo systemctl restart restart nginx

5. Accessed at http://localhost - SUCCESS

## Problems Encountered
- Problem 1: "404 Not Found"
    Problem was in sites-available where root path of website was not inserted correctly.
    Problem fixed I changed the root path website and then worked well

- Problem 2: Problem: "403 Forbidden"
    Problem with permissions. My mistake that i set wrong permission with:  
      sudo chown -R www-data:www-data /var/www/html/
      and sudo chmod -R 755 /var/www/html/
    Problem fixed when correct permission is set: 
      sudo chown -R www-data:www-data /home/nikola/Python_AI_University/ and 
      sudo chmod -R 755 /home/nikola/Python_AI_University/

## What I Learned
- How to deploy static websites with nginx
- Linux file permissions (chown, chmod)
- Web server management (systemctl)
- Manual deployment process

## Next Steps
Tomorrow: Automate this with a bash script
