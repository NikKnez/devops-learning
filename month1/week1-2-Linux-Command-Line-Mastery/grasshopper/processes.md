# 4. Processes

1. ps (Processes)
## Understanding Linux Processes
Processes are the programs currently running on your machine. 
The Linux kernel manages them, and each process is assigned a unique number called the process ID (PID).
PIDs are typically assigned sequentially as new processes are created.


2. Controlling Terminal
When you inspect running processes, you'll notice a TTY field in the ps command's output. 
This field is important as it indicates the controlling terminal that executed the command. 
Understanding this concept is key to managing processes effectively.

## What is a TTY
TTY is an abbreviation for "Teletype," which historically was a physical device for interacting with a computer. 
In modern Linux systems, a TTY refers to the terminal that provides the standard input and output for a process.


3. Process Details
Before diving into the practical applications of process management, it's essential to understand what 
Linux processes are and how they function. 
This topic can seem complex as we explore the details, so feel free to revisit this lesson later if needed.

## What is a Linux Process
A process is a program in execution. 
More precisely, it is an instance of a running program to which the system has allocated resources like memory, CPU time, 
and I/O. For example, if you open three terminal windows, run the cat command
in two of them without any arguments (it will wait for standard input, keeping the process active), 
and then use the third window to run ps aux | grep cat, you will see two distinct cat processes. 
Each is a separate instance of the same program, with its own unique process ID and resource allocation.


4. Process Creation
This lesson explores the fundamental concepts of how new processes are started on a Linux system. 
Understanding this mechanism provides insight into the inner workings of the operating system.

## The Fork and Exec Model
The primary mechanism for process creation in Linux involves an existing process cloning itself 
using the fork system call. The fork call creates a nearly identical child process. 
This new child process receives its own unique Process ID (PID), while the original process becomes its parent, 
identified by a Parent Process ID (PPID).


5. Process Termination
## The Termination Process
Once a process is created, how does it end? 
The termination of a process is a critical part of the process lifecycle, 
ensuring system resources are managed effectively.

A process typically terminates by calling the _exit system call. 
This action signals the kernel that the process is finished and its resources, 
like memory and file descriptors, can be reclaimed. Upon exiting, the process provides a termination status to the kernel, 
which is an integer value. By convention, a status of 0 indicates successful execution, 
while a non-zero value signals an error.

However, calling _exit doesn't immediately erase the process. 
The parent process must acknowledge its child's termination by using the wait system call. 
This call allows the parent to retrieve the child's termination status. 
This two-step mechanism is essential for proper process cleanup. 
Another way to linux kill child process is by using signals, a topic we will explore in a later lesson.


6. Signals
In Linux, a signal is a software interrupt sent to a process to notify it that an important event has occurred. 
Understanding linux signals is fundamental to managing processes and system behavior effectively.


7. kill (Terminate)
In Linux, you can manage processes by sending them signals. 
The primary command for this is kill, which, despite its name, 
can send various signals, not just ones that terminate a process.


8. niceness
When you run multiple applications on your computer, it seems like they are all running simultaneously. 
In reality, the CPU is rapidly switching between them, giving each process a small amount of processing time.


9. Process States
When you inspect running processes, for example with the ps aux command, you'll notice a STAT column. 
Understanding the codes in this column is key to mastering process management. 
Each code represents a specific linux process state.


10. /proc filesystem
In Linux, a core principle is that everything is treated as a file. 
This concept extends to running processes, whose information is dynamically stored in a special virtual filesystem 
known as /proc.


11. Job Control
In Linux, you often encounter commands that take a long time to complete. 
Instead of waiting and leaving your terminal unusable, you can use Linux job control to manage these tasks. 
This powerful feature allows you to run and manage multiple background processes within a single shell session, 
significantly improving your workflow.


















