# Concept: 0x08. Networking Basics #1

**#DevOps** **#Network** **#SysAdmin**

## Resources

**Read or watch:**

- [What is localhost](https://en.wikipedia.org/wiki/Localhost)
- [What is 0.0.0.0](https://en.wikipedia.org/wiki/0.0.0.0)
- [What is the 'hosts' file](https://www.makeuseof.com/tag/modify-manage-hosts-file-linux/)
- [Netcat examples](https://www.thegeekstuff.com/2012/04/nc-command-examples/)

**man or help:**

- `ifconfig`
- `telnet`
- `nc`
- `cut`

## Learning Objectives

### General

- What is `localhost/127.0.0.1`
- What is `0.0.0.0`
- What is `/etc/hosts`
- How to display your machine’s active network interfaces

## Tasks

- 0. Change your home IP- A Bash script that configures an Ubuntu server with the requirements:
  - localhost resolves to 127.0.0.2
  - facebook.com resolves to 8.8.8.8.
  - The checker is running on Docker, so make sure to read [this](http://blog.jonathanargentiero.com/docker-sed-cannot-rename-etcsedl8ysxl-device-or-resource-busy/)

- 1. Show attached IPs- A Bash script that displays all active IPv4 IPs on the machine it’s executed on.

- 2. Port listening on localhost - A Bash script that listens on port `98` on `localhost`.
