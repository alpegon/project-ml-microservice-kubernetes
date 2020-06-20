#!/usr/bin/env bash

# Step 1:
# This is your Docker ID/path
username=$1
container_name=$2
dockerpath=$username/$container_name

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run $container_name\
    --image=$dockerpath\
    --port=80 --labels app=$container_name

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward $container_name 8000:80
