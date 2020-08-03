#!/bin/bash

# Build docker container and tag it
docker build -t localhost:5000/codehouse .

# Push docker image to the registry
docker push localhost:5000/codehouse

# Apply k8s config
kubectl apply -f kube.yaml

# Forward port from localhost to cluster
kubectl wait --for=condition=ready pod -l app=codehouse
kubectl port-forward service/codehouse 3000:3000
