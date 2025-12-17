# Logging


1. System Logging
Understanding system logging is a fundamental part of learning how to learn Linux. The services, kernel, and daemons on your system are constantly active. 
This activity is recorded and saved on your system in files called logs, creating a human-readable journal of all important system events.


2. syslog
The syslog service manages and sends logs to the system logger. 
Rsyslog is an advanced version of syslog; most Linux distributions should be using this new version. 
The output of all the logs the syslog service collects can be found at /var/log/syslog (every message except authentication messages).


3. General Logging
Your Linux system diligently records events, errors, and operational information in files known as system logs. 
These logs are invaluable for Linux troubleshooting and understanding system behavior. 
For any Linux beginner, learning to read these logs is a crucial step. Most important log files are stored in the /var/log directory. 
In this lesson, we'll explore two of the most common general-purpose logs.


4. Kernel Logging
The Linux kernel is the core of the operating system, and it generates messages about its operations, hardware status, and potential issues. 
Accessing this information is crucial for system administration and troubleshooting. 
This is where the kernel log comes in.


5. Authentication Logging
In Linux, keeping track of who accesses a system and how they do it is crucial for security and troubleshooting. 
This process is managed through authentication logging, which records all authorization-related events, such as user logins and the methods used.


6. Managing Log Files
System and application log files generate a lot of data, which is stored on your hard disks. 
Over time, these files can grow to an unmanageable size, creating several challenges for system administrators. 
This lesson in our Linux tutorial provides a beginner's guide to effective log management.
