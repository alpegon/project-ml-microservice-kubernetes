#!/usr/bin/env bash

container_name=$1

# Step 1:
# Build image and add a descriptive tag
docker build --tag=$container_name .

# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run flask app
docker run -p 8000:80 $container_name
