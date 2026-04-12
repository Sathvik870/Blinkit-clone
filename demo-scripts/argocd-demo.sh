#!/bin/bash

echo "🚀 Starting ArgoCD Demo..."

# Apply ArgoCD
kubectl create namespace argocd 2>/dev/null
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for ArgoCD pods..."
sleep 60

kubectl get pods -n argocd

# Expose ArgoCD UI
kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "LoadBalancer"}}'

echo "🌐 ArgoCD Service:"
kubectl get svc -n argocd

# Get password
echo "🔑 ArgoCD Admin Password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
echo ""

echo "✅ ArgoCD is ready. Open EXTERNAL-IP in browser"
