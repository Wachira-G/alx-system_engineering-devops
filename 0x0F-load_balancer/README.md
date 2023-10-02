# Concept: 0x0F Load balancer

## Concepts

- **Load balancer**
- **Web stack debugging**


## Background Context

we have been issued with 2 additional servers:

- gc-[STUDENT_ID]-web-02-XXXXXXXXXX
- gc-[STUDENT_ID]-lb-01-XXXXXXXXXX

this is besides the web-01 server that we were working on before.
We improve our web stack so that there is redundancy for our web servers. This will allow us to be able to accept more traffic by doubling the number of web servers, and to make our infrastructure more reliable. If one web server fails, we will still have a second one to handle requests.

For this project, we write Bash scripts to automate our work.
All scripts are designed to configure a brand new Ubuntu server to match the task requirements.

## Resources

**Read or watch:**

- [Introduction to load-balancing and HAproxy](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts)
- [HTTP header](https://www.techopedia.com/definition/27178/http-header)
- [Debian/Ubuntu HAProxy packages](https://haproxy.debian.net/#distribution=Ubuntu&release=xenial&version=2.0)
- [What is a reverse proxy](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/#:~:text=A%20reverse%20proxy%20is%20a,security%2C%20performance%2C%20and%20reliability.)
