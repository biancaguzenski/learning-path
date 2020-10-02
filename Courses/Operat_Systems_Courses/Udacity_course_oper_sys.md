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

OS manages resources like memory, so let's look at a memory management example.
To do that, OS uses a memory page as an abstraction and this memory page corresponds to some adressable region of memory of some fixed size. OS integrates some mechanisms to operate on that page and allocate in DRAM and map it into the adress piece of the process.
It allows the process to access actyal physical memory. Sometimes the page is moved to different locations of physical memory and sometimes it is stored in disk. The policies helps OS to decides where the contents of this page will be stored. A common policy is that pages that have been least recently used over a period of time are the ones that will be copied on hard disk. Those are called swappings. The ones that have been accessed more frequently are more important and that is why we maintain them in memory.

2) Design principles

Separation between mechanisms and policies - incorporate into the OS flexible mechanisms that support a range of policies. For memory management, we could use least recently used, least frequently used, random - we need a way to track the frequency of the time when memory locations have been accessed.


To achieve its role in controlling hardware, OS must have special privileges (aka direct access to hardware) which is something normal applications dont have. To have direct access to hardware, there are two modes: privileged kernel mode and unprivileged/user mode. For this, in kernel mode there is a special bit set in cpu and if this bit is set, any instruction that direct manipulates CPU is allowed.
If user mode try to perform that, it will cause a trap: the app will be interrupted and hardware will switch the control to the OS at a specific location. OS will check what caused that trap and see if should grant access or if should terminate the process in case it is something illegal. Interface is the system exported by OS to allow interaction between apps and hardware.

3) system calls

We will start by assuming we are currently in an executing user process. The process needs some hardware access, so it makes a system call. On system call, control is passed to the OS and OS will perform the operation and return the result to the process. This calls involves changing the execution context from the user process to that of the OS kernel (passing arguments), and jump to the memory so you can go throught the instruction sequence your call needs. This is not a cheap operation (making a sys call).

In summary, user/kernel transitions are a necessary step. Apps may need to perform access to hardware, and only OS can perform that. 
Performing all of this, despite of the fact that hardware provides support, still takes a number of instructions.
For instance, on a two gigahertz machine running Linux,it can take 50 to 100 nanoseconds to perform all the operations that are necessary around a user/kernel transition. This is real time, real overhead for the system.
The other problem with these transitions is they affect the hardware cache usage. The application performance is very dependent on the ability to use the hardware cache. If accessing cache is order a few cycles, accessing memory can be order of hundreds of cycles.
When we perform a system call, or in general when we cross into the operating system, the operating system, while executing, will likely bring content that it needs in the cache. This will replace some of the application content that was in the hardware cache before that transition was performed. And, so this will have some impact on the application performance, because it will no longer be able to access its data in cache, it will have to go to memory. In summary, these user/kernel transitions, they're not cheap.

An OS provides apps access to hardware by exporting a number of services. These services are directly linked to some components of hardware. For instance, there is a scheduling component responsible for controlling the access to the cpu. The memory manager is responsible for allocating the underlying physical memory to one or more co-running applications. And it also has to make sure that multiple applications don't overwrite each other's accesses to memory. A block device driver is responsible for access to a block device like disk. In addition, the operating system also exports higher-level services that are linked with higher-level abstractions, as opposed to those that are linked with abstractions that really map to the hardware.
All services will be available via system calls, like:
To send a signal to a process, there is a system called kill.
To set the group identity of a process, there is a system called SETGID.
Mounting a file system is done via the mount system call.
And finally reading or writing system parameters is done via the system control system call, SYSCTL.


4) OS organizations/Estruturas - 4 types

- Monilithic design: this design is when every possible service that any app can require is already part of the OS. This OS include several possible file systems and the workload is sequentially accessing files when reading and writing them. This can make the OS really large. The benfit for	 this approach is that everything is in the OS already - the abstractions, the services, everything is packaged at the same time. The downside is that there is too much state, hard to mantain and debug and upgrade - this require memory and can impact the performance.
Monolítico: so = BLOCO INTEIRO - tudo ocorre no modulo kernel e reage com o modulo usuário - unix, windows - O sistema operacional é escrito como um conjunto de rotinas, cada uma das quais podendo chamar qualquer uma das outras sempre que precisar. Quando essa técnica é utilizada, cada rotina do sistema tem uma interface bem-defi nida em termos de parâmetros e de resultados e cada uma está livre para chamar qualquer uma das outras, se a última fornecer alguma computação útil de que a primeira precise.
- Microkernel - diminui o tamanho do bloco de so e a principal parte é a porção de comunicação - minix e symbian
- Camadas - so modular com hierarquia - dividir em diversos mini modulos com diversas funcionalidades - interface definida pra que os niveis conversem - openvms e multics
- Maquina virtual - camada intermediária que permite comunicação com diversos sistemas diferentes - vm370 com um cms, maquina virtual do java

Arquiteturas
Monoprogramado/multitarefa - não sofisticado, um unico programa, simples - sensores, sist. embarcados, relogios etc
   - processador e memória dedicados a um unico programa
   - recursos mal utilizados - disco ocioso ou cpu ociosa - não usa todos os recursos disponíveis
   - programa em tres estados - execução, espera, terminado
   - vantagem: simplicidade, implementação mais simples
Multiprogramado/multitarefa - conjunto de tarefas, porção gerencial se divide entre n programas - faz a máquina ficar menos ociosa
   - SO's atualmente - voltada para o ambiente multicore e com suporte pra essas diversas tarefas ao mesmo tempo
   - Multiplas tarefas -  tarefas concorrentes - processo otimizado
   - Sistemas em batch(lote) - lote de tarefas pra executar - ordem sequencial para execução (makefile: uma execução em lote)
   - S. de tempo compartilhado - interativo - reage com vários terminais/microcomputadores - mainframe é o computador que permite essa interação - computador de grande porte que permite o compartilhamento
   - S. de tempo real - tempo crítico para ser executado
   


