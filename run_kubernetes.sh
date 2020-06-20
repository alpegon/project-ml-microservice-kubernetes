#!/usr/bin/env bash

# Step 1:
# This is your Docker ID/path
dockerpath=alpegon/house-price-prediction

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run house-price-prediction\
    --image=$dockerpath\
    --port=80 --labels app=house-price-prediction

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward house-price-prediction 8000:80
