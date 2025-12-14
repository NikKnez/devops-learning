# Init


1. System V Overview
The primary role of an init system is to start and stop essential processes. 
Linux has seen three major init implementations: System V, Upstart, and systemd. 
This lesson focuses on the most traditional version, System V init, often referred to as SysV or simply systemv (pronounced 'System Five').

To determine if your system uses the systemv implementation, check for an /etc/inittab file. 
If this file exists, you are most likely running a SysV-based distribution.


2. System V Service
System V (or SysV) is one of the classic initialization systems in Unix-like operating systems. 
Although many modern Linux distributions have moved to newer systems like systemd, 
understanding how to manage System V services is still a valuable skill, as many systems maintain backward compatibility.


3. Upstart Overview
Upstart was developed by Canonical, so it was the init implementation on Ubuntu for a while; however, on modern Ubuntu installations, systemd is now used. 
Upstart was created to improve upon the issues with SysV, such as strict startup processes, blocking of tasks, etc. 
Upstart's event and job-driven model allow it to respond to events as they happen.


4. Upstart Jobs
Upstart is an event-based init system used in some upstart linux distributions to manage services and tasks during boot and while the system is running. 
It operates through a system of jobs and events. 
While tracing the origin of every event can be complex, often requiring you to explore job configurations in /etc/init, 
you will more commonly need to manage these jobs directly from the command line. 
The initctl utility provides a suite of commands for this purpose.


5. Systemd Overview
What is Systemd?

Systemd is the default init system and service manager for most modern Linux distributions. 
It is responsible for initializing the system in the correct order after the kernel is loaded. 
A simple way to check if your system uses it is to see if the /usr/lib/systemd directory exists. 
If it does, you are likely running a system managed by systemd.


6. Systemd Goals
This lesson provides a foundational overview of systemd unit files and how to manage them with systemctl, the primary tool for controlling the init system. 
We will cover the basic structure of a unit file and the essential commands for managing Linux services.


7. Power States
Properly managing your Linux system's power state is a fundamental skill. 
While you can use a graphical interface, the command line provides powerful and flexible options for shutting down or restarting your machine. 
These processes are tied to the system's initialization system, such as init or systemd, 
which manages different operational states, including startup and shutdown.



















