Udacity course - Operating systems

Class 3

1) What is an operating system?

CPU nowadays consists of multiple cores, that means it is able to process multiple things at the same time. Hardware components are also memory, devices like network interconnects for connecting to the internet (ethernet port or wifi card), graphics processing cards (GPUs), hard disk, SSD, flash devices like USB drives - all hardware components will be used by multiple applications. In your desktop or laptop you may be currently be running browser, text editor, skype and many others - the operatingsystem is the layer of system software that sits between hardware and these applications.

The OS hides the complexities of the underlying hardware from applications and for the developers. You dont want to worry about disk sectors o blocks when you are saving the output of a computation. Also, the OS manages a higher level abstraction of file and provides operations like reads and writes.
Socket = higher level abstraction that allow you to run internet without thinking about bits and packets to perform communication.
OS manages: decides how many and which of these resources will the application use, allocates memory for these apps and also schedules on to the CPU that can execute them.
In summary, it is responsible for all types of resource allocations and manages tasks on behalf of every application, also ensure that apps co-running in the same hardware won't hurt each other (isolation and protection).

OS is the software that has privileges to access the underlying hardware and manipulates it. In contrast, applications aren't allowed to do that.

Which of the following are likely components of an operating system?
The options are a file editor, a file system, a device driver, cache memory, a web browser, and a scheduler.

Answer:
 - file system (responsible for hiding hardware complexity and exporting simpler abstractions)
 - device driver (responsible for making decisions regarding the usage of hardware devices)
 - scheduler (distributes access to the cpu)
 File editor is an application, so is web browser. Cache memory is a portion of hardware in which OS can't manage itself.
 
 Abstraction = operating system simplifies something about the underlying hardware
 Arbitration = operating system manages the underlying hardware


To achieve its goals, OS support many abstractions, like process and thread  (corresponding mechanisms: create, schedule).
To operate on these abstractions, the operating system may incorporate mechanisms to open gain access to a particular device or hardware component, to write to it, to update its state, to allocate to make sure that a particular application has access to that resource.
Operating systems may also integrate specific policies that determine exactly how these mechanisms will be used to manage the underlying hardware.
For instance, a policy can control what is the maximum number of sockets that a process can actually have access to. (like least-recently used, earliest deadline first.
Or they may control which data will be removed from physical memory, for instance, based on some algorithm like least-recently used.
