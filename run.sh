#!/bin/bash

# Build docker container
docker build -t codehouse .

# Run docker container on port 3000 as a daemon
docker run -p 3000:3000 -d codehouse
