#!/bin/bash

# Standard source compilation workflow
# DO NOT RUN - This is a template

# 1. Download source
wget http://example.com/software-1.0.tar.gz

# 2. Extract
tar -xzf software-1.0.tar.gz
cd software-1.0/

# 3. Read documentation
cat README
cat INSTALL

# 4. Install build dependencies
sudo apt install build-essential [other-deps]

# 5. Configure
./configure --prefix=/usr/local

# 6. Compile
make

# 7. Test (if available)
make test

# 8. Install
sudo make install

# 9. Verify
which software
software --version

# 10. Uninstall (if needed later)
# sudo make uninstall
# OR manually:
# sudo rm /usr/local/bin/software
