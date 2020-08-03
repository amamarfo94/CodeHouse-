#! /bin/bash

kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
kind delete cluster
docker stop kind-registry
docker rm kind-registry
