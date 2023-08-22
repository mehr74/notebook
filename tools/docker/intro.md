---
id: introduction
title: Introduction
tags:
  - Getting started
  - docker
  - tools
---
# Introduction

## What is docker?
*Docker* is a widely used containerization platform. It enables us 
to package, distribute, and run applications in isolated environments, 
called *containers*. Therefore, docker simplifies the process of deploying, 
managing, and scaling applications while improving consistency, 
efficiency, and security.

<iframe 
  width="853" 
  height="480" 
  src="https://www.youtube.com/embed/_dfLOzuIg2o" 
  title="What is Docker in 5 minutes" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## Key phases in using docker
There are several key components and phases involved in building and 
running containers. Here are the main ones:

1. **Dockerfile**: The Dockerfile is a text file. It contains 
instructions on how to build a Docker image. Dockerfile defines the base 
image, additional dependencies, and packages needed. The Dockerfile 
is used as input to build an image.

2. **Docker Image**: Docker images contains everything needed to 
run a container, including the application code, runtime, libraries, 
and dependencies. It is built based on the instructions specified in 
the Dockerfile. Images are portable and can be distributed and 
run on any system that supports Docker.

3. **Container**: A container is an instance of a running image. 
It is a lightweight and isolated environment that encapsulates 
the application and its dependencies. Containers are created 
from images and can be started, stopped, moved, and deleted. 
Each container has its own filesystem, network interfaces, 
and process space.


## Installation

### Installing on Mac

### Installing on Windows

### Installinng on Linux