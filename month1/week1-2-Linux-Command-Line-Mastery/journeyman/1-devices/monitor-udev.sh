#!/bin/bash

echo "Monitoring udev events..."
echo "Try plugging in a USB device"
echo "Press Ctrl+C to stop"
echo ""

# Monitor all udev events
udevadm monitor

# Or monitor specific subsystems:
# udevadm monitor --subsystem-match=block
# udevadm monitor --subsystem-match=usb
