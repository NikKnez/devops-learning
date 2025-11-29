# Exercise 12: Comprehensive Practice Challenge

# Create this directory structure with appropriate permissions:

# 1. Personal directory (you only)
mkdir personal-files
chmod 700 personal-files
touch personal-files/diary.txt
chmod 600 personal-files/diary.txt

# 2. Shared project (team collaboration)
mkdir shared-project  
chmod 2775 shared-project  # setgid + group write
touch shared-project/team-doc.txt
chmod 664 shared-project/team-doc.txt

# 3. Public scripts (everyone can execute)
mkdir public-scripts
chmod 755 public-scripts
touch public-scripts/utility.sh
chmod 755 public-scripts/utility.sh

# 4. Upload directory (users can upload but not delete others' files)
mkdir public-uploads
chmod 1777 public-uploads  # sticky bit

# Verify everything
echo "=== Permission Setup Verification ===" > verification.txt
ls -ld personal-files shared-project public-scripts public-uploads >> verification.txt
echo "" >> verification.txt
ls -l personal-files/ >> verification.txt
ls -l shared-project/ >> verification.txt
ls -l public-scripts/ >> verification.txt

cat verification.txt
