# Permissions

1. File Permissions
In Linux, everything is a file, and managing access to these files is a critical skill. 
Understanding file permissions is fundamental for system security and administration. 
Let's explore how to read and interpret these permissions.


2. Modifying Permissions
When you need to modify file or directory access rights, the primary tool you'll use is the chmod (change mode) command. 
Understanding how to change permissions in Linux is a fundamental skill for any user. 
The chmod command offers two main methods for this task: symbolic and numerical mode.


3. Ownership Permissions
In a Linux system, every file and directory is assigned an owner and a group. 
Managing Linux file ownership is a fundamental task for controlling access and permissions. 
You can modify both the user and group ownership of a file using specific Linux commands.


4. Umask
Every file that gets created comes with a default set of permissions. 
If you ever want to change that default set of permissions, you can do so with the umask command. 
This command uses the 3-bit permission set we see in numerical permissions.
Instead of adding these permissions, however, umask takes away these permissions.


5. Setuid
There are many cases in which normal users need elevated access to do stuff. 
The system administrator can't always be there to enter a root password every time a user needs access to a protected file, 
so there are special file permission bits to allow this behavior. 
The Set User ID (SUID) allows a user to run a program as the owner of the program file rather than as themselves.


6. Setgid
Similar to the set user ID permission bit, there is a set group ID (SGID) permission bit. 
This bit allows a program to run as if it were a member of that group.


7. Process Permissions
Let's segue into process permissions for a bit. 
Remember how I told you that when you run the passwd command with the SUID permission bit enabled, 
you will run the program as root? That is true. 
However, does that mean since you are temporarily root, you can modify other users' passwords? Nope, fortunately not!

This is because of the many UIDs that Linux implements. There are three UIDs associated with every process:

When you launch a process, it runs with the same permissions as the user or group that ran it. 
This is known as an effective user ID. This UID is used to grant access rights to a process. 
So, naturally, if Bob ran the touch command, the process would run as him, and any files he created would be under his ownership.

There is another UID, called the real user ID. This is the ID of the user that launched the process. 
These are used to track down who the user who launched the process is.

One last UID is the saved user ID. This allows a process to switch between the effective UID and real UID, and vice versa. 
This is useful because we don't want our process to run with elevated privileges all the time; 
it's just good practice to use special privileges at specific times.

Now let's piece these all together by looking at the passwd command once more.

When running the passwd command, your effective UID is your user ID; let's say it's 500 for now. 
Oh, but wait, remember the passwd command has the SUID permission enabled. 
So when you run it, your effective UID is now 0 (0 is the UID of root). Now this program can access files as root.

Let's say you get a little taste of power, and you want to modify Sally's password. 
Sally has a UID of 600. Well, you'll be out of luck. Fortunately, the process also has your real UID, in this case 500. 
It knows that your UID is 500, and therefore you can't modify the password of UID 600. (This, of course, is always bypassed if you are a superuser on a machine and can control and change everything).

Since you ran passwd, it will start the process off using your real UID, 
and it will save the UID of the owner of the file (effective UID), 
so you can switch between the two. No need to modify all files with root access if it's not required.

Most of the time, the real UID and the effective UID are the same, but in such cases as the passwd command, they will change.


8. The Sticky Bit
Beyond the standard read, write, and execute permissions, Linux offers special permissions for advanced access control. 
The last of these special permissions we will cover is the sticky bit.










