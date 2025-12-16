# Process Utilization


1. Tracking processes: top
Understanding how to read and analyze resource utilization is a critical skill for any Linux user. 
Many consider mastering command-line tools the best way to learn Linux from the ground up, as they provide deep insight into how Linux works. 
This lesson introduces top, a powerful utility for tracking what your processes are doing in real-time.


2. lsof and fuser
Have you ever tried to unmount a USB drive and received a "Device or Resource Busy" error? 
This common issue occurs when a process is still using a file or directory on the device. 
To solve this, you need to find out which process is holding the resource. 
Two powerful utilities for this task are lsof and fuser.


3. Process Threads
What Are Process Threads?

You may have heard the terms single-threaded and multi-threaded. 
Threads are units of execution within a process and are often called "lightweight processes." 
While processes operate with their own isolated system resources, threads within the same process can share these resources, such as memory. 
This shared-resource model makes communication between threads much faster and more efficient than communication between separate processes.


4. CPU Monitoring
A fundamental skill in managing a Linux system is understanding its performance. 
One of the most useful commands for a quick health check is uptime.
While we've seen uptime before, let's focus on the load average field, which is crucial for Linux CPU monitoring.


5. I/O Monitoring
Effective I/O monitoring is crucial for maintaining a healthy and responsive Linux system. 
A powerful command-line tool for this task is iostat, which provides detailed reports on both CPU and disk activity.
Running the iostat command generates a snapshot of your system's performance metrics.


6. Memory Monitoring
Effective system administration requires keeping a close eye on resource usage, and memory monitoring is a critical part of this process. 
When a system runs low on memory, its performance can degrade significantly. 
Linux provides several tools to help you track memory consumption, and one of the most versatile is vmstat.


7. Continuous Monitoring
These monitoring tools are good to look at when your machine is having issues, but what about machines that are having issues when you aren't looking? 
For those, you'll need to use a continuous monitoring tool, something that will collect, report, and save your system activity information. 
In this lesson, we will go over a great tool to use: sar.


8. Cron Jobs
While process utilization is important, it's also a great time to introduce a powerful tool for Linux automation: the cron daemon. 
This background service allows you to schedule tasks to run automatically at specific times or intervals. 
These scheduled tasks are commonly known as cron jobs. This is incredibly useful for automating routine actions, 
such as running a backup script every night or cleaning up temporary files once a week.
