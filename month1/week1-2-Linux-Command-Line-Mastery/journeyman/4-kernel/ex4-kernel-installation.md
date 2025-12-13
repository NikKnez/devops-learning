# Exercise 4: Kernel Installation


## Task 4.1: Understanding Kernel Installation
cat > kernel-installation-guide.txt << 'EOF'
=== Linux Kernel Installation ===

Why Install a Different Kernel?

1. Hardware support (new drivers)
2. Performance improvements
3. Security patches
4. New features
5. Specific requirements (real-time, low-latency)

Installation Methods:

Method 1: Package Manager (RECOMMENDED)
- Safest method
- Tested by distribution
- Easy updates
- Automatic bootloader config

Method 2: Compile from Source
- Latest features
- Custom configuration
- Optimized for hardware
- Time-consuming
- Advanced users only

Ubuntu/Debian Kernel Installation:

1. Check available kernels:
   apt search linux-image

2. Install specific kernel:
   sudo apt install linux-image-X.X.X-generic

3. Install headers (for module compilation):
   sudo apt install linux-headers-X.X.X-generic

4. Update bootloader:
   sudo update-grub

5. Reboot:
   sudo reboot

6. Verify new kernel:
   uname -r

Managing Multiple Kernels:

List installed kernels:
dpkg --list | grep linux-image

Remove old kernels:
sudo apt remove linux-image-X.X.X-generic
sudo apt autoremove

Kernel Naming (Ubuntu):
linux-image-5.15.0-91-generic
            │   │  │  └─ Kernel flavor
            │   │  └─ Build number
            │   └─ Patch level
            └─ Minor version

Kernel Flavors:
-generic    - Standard kernel (default)
-lowlatency - Low latency (audio production)
-aws        - Optimized for AWS
-azure      - Optimized for Azure
-gcp        - Optimized for Google Cloud

GRUB Bootloader:
- Manages multiple kernels
- Default boot order
- Fallback to old kernel if new fails
- Config: /etc/default/grub

Emergency: Boot Old Kernel
1. Restart computer
2. Hold SHIFT during boot
3. GRUB menu appears
4. Select "Advanced options"
5. Choose old kernel
6. Remove problematic kernel after boot

Kernel Compilation (Advanced):

Steps:
1. Download source: https://kernel.org
2. Extract: tar -xzf linux-X.X.X.tar.gz
3. Configure: make menuconfig
4. Compile: make -j$(nproc)
5. Install modules: sudo make modules_install
6. Install kernel: sudo make install
7. Update GRUB: sudo update-grub
8. Reboot

Time: 1-4 hours depending on CPU

Risks:
- System might not boot
- Driver incompatibilities
- Config errors
- Always keep old kernel as backup!
EOF

cat kernel-installation-guide.txt


## Task 4.2: Check Installed Kernels
# List installed kernel packages
dpkg --list | grep linux-image

# Count installed kernels
dpkg --list | grep linux-image | grep -v "meta" | wc -l

# Show kernel sizes
dpkg-query -W -f='${Installed-Size;10} ${Package}\n' | grep linux-image | sort -rn

# Check GRUB configuration
grep -E "menuentry|linux" /boot/grub/grub.cfg | head -20

# Available kernels in repository
apt-cache search linux-image | grep generic | head -10

# Create kernel inventory
cat > kernel-inventory.txt << EOF
=== Kernel Inventory ===

Current running kernel:
$(uname -r)

Installed kernels:
$(dpkg --list | grep linux-image | grep -v "meta")

Total kernels installed:
$(dpkg --list | grep linux-image | grep -v "meta" | wc -l)

Kernel files in /boot:
$(ls -lh /boot/vmlinuz-*)

Available in repos:
$(apt-cache search linux-image-generic | head -5)
EOF

cat kernel-inventory.txt
