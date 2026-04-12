#!/bin/bash

echo "🧹 Cleaning previous workloads..."

# Remove ArgoCD to free memory
kubectl delete namespace argocd --ignore-not-found

# Remove operator if exists
kubectl delete deployment prometheus-operator --ignore-not-found

# Optional: stop backend if needed
# kubectl scale deployment blinkit-backend --replicas=0

echo "🚀 Deploying Prometheus..."

kubectl apply -f https://raw.githubusercontent.com/prometheus/prometheus/main/documentation/examples/prometheus-kubernetes.yml

echo "⏳ Waiting for Prometheus..."
sleep 40

kubectl get pods

echo "🌐 Forwarding Prometheus to localhost:9090"

POD_NAME=$(kubectl get pods -o jsonpath="{.items[?(@.metadata.name contains 'prometheus')].metadata.name}")

echo "Using pod: $POD_NAME"

kubectl port-forward pod/$POD_NAME 9090:9090
