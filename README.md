# 🏓 PingPong: Custom TCP/UDP Network Diagnostic Tool

A custom network diagnostic utility implemented in C, inspired by the classic `ping` command. This project features a client-server architecture designed to measure network latency (Round-Trip Time) and packet loss, offering the ability to test connections over both **TCP** and **UDP** protocols.

## ✨ Key Features

* **Dual Protocol Support:** Includes dedicated clients for both TCP (`tcp_ping`) and UDP (`udp_ping`) communications.
* **Concurrent Server:** A robust `pong_server` capable of handling incoming requests and reflecting them back to the client.
* **Network Statistics:** Calculates and displays detailed connection metrics, including minimum, maximum, and average Round-Trip Time (RTT), as well as packet loss percentages.
* **Robust Socket I/O:** Custom read/write wrappers to safely handle partial data transmissions over streams.

## 📂 Project Structure

* `pong_server.c`: The server application that listens for incoming ping messages and replies with pong messages.
* `tcp_ping.c`: The client application to send ping messages over a reliable TCP connection.
* `udp_ping.c`: The client application to send ping messages using connectionless UDP datagrams.
* `statistics.c`: Logic for tracking timing and calculating final network statistics.
* `readwrite.c`: Utility functions ensuring complete data transmission over sockets (handling `EAGAIN` and short counts).
* `fail.c`: Custom error handling and logging functions.
* `pingpong.h`: Common header file containing shared structures, macros, and function prototypes.

## 🛠️ Technologies & Concepts

* **Language:** C
* **Networking:** POSIX Sockets (TCP `SOCK_STREAM` & UDP `SOCK_DGRAM`)
* **Concepts:** Client-Server architecture, Protocol differences, RTT calculation, Robust I/O handling.

## 🚀 How to Build and Run

You can compile the programs using the GNU Compiler Collection (`gcc`). Open your terminal in the project directory.

**1. Compilation:**
Compile the server:
```bash
gcc pong_server.c fail.c readwrite.c -o pong_server
```
Compile the TCP client:
```bash
gcc tcp_ping.c fail.c readwrite.c statistics.c -o tcp_ping
```
Compile the UDP client:
```bash
gcc udp_ping.c fail.c readwrite.c statistics.c -o udp_ping
```
**2. Execution:**
First, start the server on a specific port (e.g., 8080):
```bash
./pong_server 8080
```
Then, open a new terminal window and run one of the clients connecting to the server's IP (e.g., localhost 127.0.0.1) and port:
```bash
./tcp_ping 127.0.0.1 8080
# or
./udp_ping 127.0.0.1 8080
```

## 🧠 What I Learned

This project provided hands-on experience with low-level network programming. Key takeaways include:

* **TCP vs UDP**: Practically observing the differences between connection-oriented, reliable streams (TCP) and connectionless, best-effort datagrams (UDP).
* **Socket API**: Mastering POSIX functions like socket(), bind(), listen(), accept(), sendto(), and recvfrom().
* **Timing and Profiling**: Using system time libraries to accurately measure network latency down to the microsecond.
* **I/O Resilience**: Writing robust wrappers for read() and write() to handle cases where the OS transmits fewer bytes than requested, a common pitfall in socket programming.
