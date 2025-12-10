# Boot the System


1. Boot Process Overview
Having explored some key components of Linux, let's now see how they all come together during system startup. 
The entire sequence, from pressing the power button to reaching a login prompt, is known as the Linux boot process. 
It's a fascinating journey that transforms a powered-off machine into a fully functional operating system.

The booting process of the Linux operating system can be simplified into four main stages.

Stage 1 BIOS
Stage 2 Bootloader
Stage 3 Kernel
Stage 4 Init


2. Boot Process: BIOS
The first step in the Linux boot process is the BIOS (Basic Input/Output System), which performs crucial system integrity checks upon startup. 
The BIOS is firmware commonly found in IBM PC-compatible computers, which represent the majority of computers in use today.


3. Boot Process: Bootloader
What is a Bootloader in Linux
After the BIOS/UEFI finishes its tasks, it hands over control to the next stage of the boot process: the bootloader. 
A bootloader in Linux is a small program that loads the operating system's kernel into memory and then executes it. 
It acts as the bridge between the system's firmware and the Linux kernel.


4. Boot Process: Kernel
Once the bootloader has loaded the kernel into memory and passed the necessary parameters, the kernel takes control of the system. 
Let's explore what happens next.


5. Boot Process: Init
As we've learned, the init process is the first process to run during the Linux boot process. 
It is the parent of all other processes and is responsible for starting the essential services that bring your system to a usable state. 
But how does it accomplish this?

There are three major implementations of the Linux init system, each with a different approach to managing services.

- System V Init
- Upstart
- systemd
