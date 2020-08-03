#!/bin/bash

# ==============================

# Kind with Registry
# Source: https://kind.sigs.k8s.io/docs/user/local-registry/ 

set -o errexit

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5000'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi

# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${reg_port}"]
    endpoint = ["http://${reg_name}:${reg_port}"]
EOF

# connect the registry to the cluster network
docker network connect "kind" "${reg_name}"

# tell https://tilt.dev to use the registry
# https://docs.tilt.dev/choosing_clusters.html#discovering-the-registry
for node in $(kind get nodes); do
  kubectl annotate node "${node}" "kind.x-k8s.io/registry=localhost:${reg_port}";
done

# ==============================

# Build docker container and tag it
docker build -t localhost:5000/codehouse .

# Push docker image to the registry
docker push localhost:5000/codehouse

# Apply k8s config
kubectl apply -f kube.yaml

# Forward port from localhost to cluster
kubectl wait --for=condition=ready pod -l app=codehouse
kubectl port-forward service/codehouse 3000:3000
