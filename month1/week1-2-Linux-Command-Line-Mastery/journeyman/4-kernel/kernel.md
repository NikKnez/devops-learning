## Kernel


1. Overview of the Kernel
As you've learned, the kernel is the core of the operating system. 
To truly understand Linux, we must see how all its parts work together. 
This lesson provides a high-level overview, a critical first step in your linux jorney.

The Linux operating system can be organized into three different levels of abstraction.
- The System Hardware
- The Linux Kernel
- The User Space


2. Privilege Levels
The next few lessons cover more theoretical concepts. 
If you prefer hands-on practice, feel free to skip ahead and return to these topics later.

A fundamental aspect of the Linux architecture is the separation between user space and the kernel. 
But why can't we combine their powers into a single layer? 
The reason is security and stability, which is achieved by having them operate in different modes.


3. System Calls
Imagine you are at a large concert. To get from the general audience area to the exclusive backstage, you can't just walk through. 
You need a special pass that grants you access through a specific, guarded door. 
In the world of computing, system calls are those special passes.


4. Kernel Installation
Okay, now that we've got all that boring stuff out of the way, let's talk about actually installing and modifying kernels. 
You can install multiple kernels on your system; remember in our lesson on the boot process? 
In our GRUB menu, we can choose which kernel to boot to.


5. Kernel Location
When you install a new kernel, your system adds several important files to a specific directory. 
If you've ever wondered where is the kernel stored in Linux, the answer is typically the /boot directory. 
This directory is the standard Linux kernel location on most systems.


6. Kernel Modules
Think of the Linux kernel as the core engine of a car. 
You can add accessories like a roof rack or a new sound system without changing the engine itself. 
These accessories can be added or removed as needed. 
The Linux kernel uses a similar concept with kernel modules.
