# The Filesystem


1. Filesystem Hierarchy
You are likely becoming familiar with the directory structure on your system. 
Most Linux distributions organize their filesystems according to the Linux File System Hierarchy (FHS) Standard. 
This standard ensures that files are stored in predictable locations, making systems more consistent.

To see the top-level directories, run the command ls -l /. 
While your system might have minor differences, 
the core linux file hierarchy structure will be very similar to the one described below.


2. Filesystem Types
Linux supports a wide variety of filesystem implementations. 
Some are optimized for speed, others for large storage capacity, and some are designed for smaller devices. 
Each of these different filesystem types has a unique way of organizing data.


3. Anatomy of a Disk
A hard disk in Linux can be subdivided into partitions, which function as individual block devices. 
You may recall examples like /dev/sda1 and /dev/sda2. 
Here, /dev/sda represents the entire disk, while /dev/sda1 is the first partition on that disk. 
Partitions are incredibly useful for separating data. 
If you need a specific filesystem for a portion of your storage, 
you can create a new partition for it instead of formatting the entire disk.


4. Disk Partitioning
This lesson provides a practical guide to managing filesystems by partitioning a disk, such as a USB drive. 
If you don't have a spare drive, you can still follow along to understand the concepts.

First, we'll need to partition our disk. There are many tools available for this task:

- fdisk: A basic command-line partitioning tool; it does not support GPT.
- parted: A powerful command-line tool that supports both MBR and GPT partitioning.
- gparted: The graphical version of parted. For users who prefer a visual interface, gparted is an intuitive tool, often considered a great gparted windows alternative.
- gdisk: Similar to fdisk, but it only supports GPT.
We will use parted for our examples.


5. Creating Filesystems
After you have successfully partitioned a disk, the next crucial step in Linux disk management is to create a filesystem. 
This process, often called formatting, organizes the partition so it can store files and directories.


6. mount and umount
Before you can access the files on a storage device, you must first mount its filesystem to a directory on your system. 
This process involves a device location, a filesystem type, and a mount point. 
The mount point is simply an existing directory where the filesystem will be attached.


7. /etc/fstab
In Linux, when you want to automatically mount filesystems at startup, 
you configure them in a special configuration file located at /etc/fstab. 
The name fstab is short for "filesystem table," and this file contains a permanent list of filesystems 
that the system should mount during the boot process. 
Understanding the fstab linux configuration is a key skill for any system administrator.


8. swap
In our previous example, I showed you how to see your partition table. 
Let's revisit that example, more specifically this line:

Number  Start   End     Size    Type      File system     Flags
 5      6861MB  7380MB  519MB   logical   linux-swap(v1)

What is this swap partition? 
Well, swap is what we use to allocate virtual memory to our system. 
If you are low on memory, the system uses this partition to "swap" pieces of memory of idle processes to the disk, 
so you're not bogged down for memory.


9. Disk Usage
Managing disk space is a fundamental task for any Linux user or administrator. 
Two essential commands for this purpose are df and du. 
Let's explore how to use them to monitor your disk utilization effectively.


10. Filesystem Repair
Sometimes our filesystem isn't always in the best condition. 
If we have a sudden shutdown, our data can become corrupt. 
It's up to the system to try to get us back into a working state (although we certainly can try ourselves).

The fsck (filesystem check) command is used to check the consistency of a filesystem and can even try to repair it for us. Usually, when you boot up a disk, fsck will run before your disk is mounted to make sure everything is okay. Sometimes, though, your disk is so bad that you'll need to manually do this. However, be sure to do this while you are in a rescue disk or somewhere where you can access your filesystem without it being mounted.

sudo fsck /dev/sda


11. Inodes
Remember how our filesystem is comprised of all our actual files and a database that manages them? 
This database is known as the inode table, a fundamental part of how inode in linux works.


12. symlinks
When you list files in detail, you see a lot of information. 
Let's look at a previous example of inode information from the ls -li command:

pete@icebox:~$ ls -li
140 drwxr-xr-x 2 pete pete 6 Jan 20 20:13 Desktop
141 drwxr-xr-x 2 pete pete 6 Jan 20 20:01 Documents

We've previously glossed over the third field in this output. This field is the link count.
