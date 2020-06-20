#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
username=$1
container_name=$2
dockerpath=$username/$container_name

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username $username
docker tag $container_name $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath
