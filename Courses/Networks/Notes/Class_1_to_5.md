## CS144 STANFORD - INTRODUCTION TO COMPUTER NETWORKING

### Class 1 Notes

* Connectivity - 2 computers can connect and exchange data - if you connect your computer to internet, you can connect to anyone who is also connected - how?

You connect your browser to read a magazine - The server run by the publisher has all of the magazine articles, and might also have all past issues you can have access to all catalog and can download on demand

*Basic model* - two computers, each running a program locally and these two communicates with network - **bidirectional reliable byte stream connection**.

Computer A wants to communicate with computer B
{ A and B set up a connection
  A writes data, B can read it
  Vice versa }
Anyone can close the connection - the web browser can close after receiven all data - the server can also close the request.

**World wide web** - uses HTTP to communicate
* a cliente opens connection with server and requests a page with command get -> server receives the requests and sends reposes (200 ok is accepted request) sends ok and also the page.
HTTP is ascii, human readable - responses are easy to understand.

**Bit torrent** - Program in which clients exchange files
* When a client request documents for another clients. BitTorrent breaks files in chunks of data called pieces - when a cliente download a piece, it says to other clients they have those pieces as well so they can download it too. Swarms = collection of collaboratin clients.
BitTorrent uses the same reliable bidirectional data stream in a different way - first the client must find a torrent file (in the world wide web) and download it using HTTP. This torrent file describes the file you want to download and also tells BitTorrent about who the tracker is for that torrent - a tracker is a node, a cliente in this swarm - the client receive a list of other clients and ask for pieces of the file.

**Skype** - exchange of audio/video
* Most simple mode: simple client-server exchange, just like http. You open the connection, if the client accepts, you start to exchange audio, video and other data.
BUT, there are other scenarios:
Usually, clients are covered by NAT for protection. NAT is network adress translator (cover nat later) - you can open connections out to the internet, but other nodes on the internet cant easily open connection with you. So, in skype, you need an intermediate. Rendezvou server is ao option to works with one NAT (client A has no nat, client B has) - in this case, client A asks rendezvous to calls b, if b accepts, there is a connection between a and b ~REVERSE CONNECTION~ this happens because normally, clients in skype are people, not servers. Server are usually not behind nat because this wouldnt make sense. In case both clients has NAT layer, there is Relay, another kind of server - they communicate through relay.

### Class 2 Notes

**The four layer internet model**

All applications want to send and receive data sure that anything will be lost or corrupted and also not knowing the path and its details.

Thats why exists the *4 layer model* - describe hierarchy of operations that make up the internet - layering is a very important concept

What each layer does?
* all layers are there to enable applications in the end hosts to communicate reliably
* each layer has a different responsability, with each layer building a service on top od the one bellow, all the way to the top where we have a bidirectional reliable byte stream communication

**APPLICATION LAYER**

Each app is different (skype, www, bittorrent).
Transport layer helps a lot application.
Communicates with its peer layer - other app layer - destination.

**TRANSPORT LAYER**

Make sure data send by application is correctly delivered in correct order to the other application - if network layer drops some datarams, tcp retransmit them until the packet is correctly received. Later we will learn a lot about tcp.
Not all apps need tcp, some use udp - doesn't guarantee deliver.

**NETWORK LAYER** - most important
The job is to deliver packets end-to-end across the internet from the source to the destiation.
Network hands the datagram(packet) to the link layer below, telling it to send over the first link (to another router - the next router send it to the network layer of this router to examinate the header and then send to the next router - this happens until reaches destination)
Network layer uses Internet Protocol. (more on ip later)

IP - makes best effort attempt to deliver datagrams, but makes no promisses - there are no guarantees that packets wont be list or corrupted. To make sure it happens right, you need transport layer.
(PACKET WILL BE DISCUSSED NEXT VIDEO)

**LINK LAYER** - end hosts, links, routers

Data is delibered hop-by-hop over each link in turn. Data is delivered in packets(self contained unit: data + header with information about it)
The link layer's job is to carry the data over one link at time. Ethernet, wifi and 4g are examples of links.
