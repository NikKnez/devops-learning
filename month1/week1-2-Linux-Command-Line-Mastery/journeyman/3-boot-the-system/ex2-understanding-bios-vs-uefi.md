# Exercise 2: BIOS/UEFI Stage


## Task 2.1: Understanding BIOS vs UEFI
cat > bios-uefi-guide.txt << 'EOF'
=== BIOS vs UEFI ===

BIOS (Basic Input/Output System) - LEGACY
- Introduced: 1975
- 16-bit mode
- Limited to MBR partition scheme
- Max disk: 2TB
- Slower boot
- Text-based setup
- Security: None

Boot Process:
1. POST (Power-On Self Test)
2. Read MBR (first 512 bytes of disk)
3. Execute bootloader in MBR
4. Bootloader loads OS

MBR Structure:
- 446 bytes: Bootloader code
- 64 bytes: Partition table (4 entries)
- 2 bytes: Boot signature (0x55AA)

UEFI (Unified Extensible Firmware Interface) - MODERN
- Introduced: 2005, standard since 2010
- 32-bit or 64-bit mode
- Uses GPT partition scheme
- Max disk: 9.4 ZB (essentially unlimited)
- Faster boot
- GUI setup possible
- Security: Secure Boot, TPM support

Boot Process:
1. UEFI firmware initialization
2. Read EFI System Partition (ESP)
3. Execute bootloader from ESP (.efi file)
4. Bootloader loads OS

ESP (EFI System Partition):
- FAT32 formatted
- Contains bootloaders
- Typically /boot/efi
- ~100-500 MB

Key Differences:

Feature          BIOS              UEFI
-------          ----              ----
Released         1975              2005
Architecture     16-bit            32/64-bit
Partition        MBR (2TB max)     GPT (unlimited)
Boot method      MBR               ESP
Interface        Text              GUI possible
Security         None              Secure Boot
Speed            Slower            Faster
Mouse support    No                Yes

DevOps Considerations:
- Cloud VMs: Usually UEFI
- Containers: Boot process abstracted
- Bare metal: Check BIOS/UEFI mode
- Disk imaging: Different procedures
EOF

cat bios-uefi-guide.txt


## Task 2.2: Check Your System's Firmware Type
# Method 1: Check if /sys/firmware/efi exists
if [ -d /sys/firmware/efi ]; then
    echo "System is using UEFI"
else
    echo "System is using BIOS (Legacy)"
fi

# Method 2: Check with efibootmgr (UEFI only)
if command -v efibootmgr &> /dev/null; then
    echo "=== UEFI Boot Entries ==="
    sudo efibootmgr 2>/dev/null || echo "Not UEFI or permission denied"
fi

# Check EFI System Partition (if UEFI)
if [ -d /boot/efi ]; then
    echo "=== EFI System Partition ==="
    ls -lh /boot/efi/EFI/ 2>/dev/null
fi

# Check partition scheme (GPT vs MBR)
DISK=$(lsblk -ndo NAME | head -1)
echo "=== Partition Table Type ==="
sudo parted /dev/$DISK print 2>/dev/null | grep "Partition Table" || echo "Cannot determine"

# Create firmware report
cat > firmware-report.txt << EOF
=== Firmware Type Report ===

Firmware type: $([ -d /sys/firmware/efi ] && echo "UEFI" || echo "BIOS")

EFI directory exists: $([ -d /boot/efi ] && echo "Yes" || echo "No")

Partition table: $(sudo parted /dev/$DISK print 2>/dev/null | grep "Partition Table" | cut -d: -f2 | xargs)

Boot mode: $([ -d /sys/firmware/efi ] && echo "UEFI" || echo "Legacy BIOS")
EOF

cat firmware-report.txt


## Task 2.3: POST and Hardware Initialization
cat > post-process.txt << 'EOF'
=== POST (Power-On Self Test) ===

What Happens During POST?

1. CPU Initialization
   - CPU starts executing firmware
   - Registers initialized
   - Cache flushed

2. Memory Test
   - RAM chips tested
   - Memory controller initialized
   - Bad sectors marked

3. Hardware Detection
   - Keyboard
   - Mouse
   - Storage devices
   - Video card
   - Network card

4. Device Initialization
   - Initialize SATA controllers
   - Initialize USB controllers
   - Initialize PCI devices

5. Boot Device Selection
   - Check boot order (BIOS/UEFI setting)
   - Try each device in order
   - Find bootable device (boot flag or EFI)

POST Beep Codes (BIOS):
- 1 beep: POST successful
- 2 beeps: POST error (see screen)
- 3 beeps: Memory error
- Continuous beep: Power supply or motherboard failure

No Video? Check:
1. Monitor connection
2. Video card
3. RAM seated properly
4. POST beep codes

UEFI Boot Order:
- Set in UEFI setup
- Press F2/F12/Del during boot
- Configure:
  * Boot device priority
  * Secure Boot settings
  * CSM (Compatibility Support Module)

DevOps Relevance:
- Hardware failures: POST catches them
- Boot order: Important for PXE boot
- UEFI settings: Needed for some installs
- Virtual machines: Simplified POST
EOF

cat post-process.txt
