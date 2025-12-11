# Exercise 7: Comprehensive Boot Analysis


## Task 7.1: Complete System Boot Report
cat > complete-boot-report.sh << 'EOF'
#!/bin/bash

echo "=========================================="
echo "  Complete Linux Boot Analysis Report"
echo "=========================================="
echo ""

echo "=== 1. FIRMWARE ==="
if [ -d /sys/firmware/efi ]; then
    echo "Type: UEFI"
    if command -v efibootmgr &> /dev/null; then
        echo "Boot entries:"
        sudo efibootmgr 2>/dev/null | head -10
    fi
else
    echo "Type: BIOS (Legacy)"
fi
echo ""

echo "=== 2. BOOTLOADER ==="
echo "GRUB version: $(grub-install --version 2>/dev/null || echo 'Not installed')"
echo "Installed kernels:"
ls /boot/vmlinuz-* 2>/dev/null | head -5
echo ""

echo "=== 3. KERNEL ==="
echo "Current kernel: $(uname -r)"
echo "Kernel command line:"
cat /proc/cmdline
echo ""

echo "=== 4. INIT SYSTEM ==="
echo "Init: $(ps -p 1 -o comm=)"
echo "systemd version: $(systemctl --version | head -1)"
echo "Default target: $(systemctl get-default)"
echo ""

echo "=== 5. BOOT TIMING ==="
systemd-analyze 2>/dev/null || echo "systemd-analyze not available"
echo ""

echo "=== 6. SYSTEM STATUS ==="
echo "Uptime: $(uptime -p)"
echo "Boot time: $(who -b)"
echo ""

echo "=== 7. SERVICES ==="
echo "Active services: $(systemctl list-units --type=service --state=active | grep -c service)"
echo "Failed services: $(systemctl --failed | grep -c service)"
if [ "$(systemctl --failed | grep -c service)" -gt 0 ]; then
    echo "Failed:"
    systemctl --failed --no-pager
fi
echo ""

echo "=== 8. TOP 5 SLOWEST SERVICES ==="
systemd-analyze blame 2>/dev/null | head -5
echo ""

echo "=========================================="
echo "Report generated: $(date)"
echo "=========================================="
EOF

chmod +x complete-boot-report.sh
./complete-boot-report.sh > boot-report-full.txt
cat boot-report-full.txt 
