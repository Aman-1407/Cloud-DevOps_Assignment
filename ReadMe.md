# Cloud & DevOps Engineer Assessment Task

## Overview
This project deploys a static web application on an AWS-based Kubernetes cluster with Terraform, Docker, and Prometheus monitoring.

## Prerequisites
- AWS CLI and EKS
- Terraform
- Kubectl
- Docker
- Helm (for Prometheus)

## Deployment Steps

### Step 1: Set Up Infrastructure with Terraform
terraform init
terraform apply -auto-approve

### Step 2: Upgrading AWS CLI, recreate your kubeconfig

To bind with my Loacal system Kube Config :-
aws eks --region us-east-1 update-kubeconfig --name eks_cluster_demo

To verify - kubectl get nodes

### Step 3: Build and Push Docker Image

docker build -t aman1407/devops-webapp:latest .

docker push aman1407/devops-webapp:latest

### Step 4: Deploy to Kubernetes

kubectl apply -f deployment.yaml

kubectl apply -f service.yaml

- Get the LoadBalancer IP:
kubectl get svc webapp-service

Open in a browser: http://<LoadBalancer-IP>

### Step 5: Set Up Monitoring
helm repo add prometheus-community https://prometheus-community.github.io/

helm-charts

helm repo update

helm install prometheus-demo prometheus-community/prometheus 

kubectl get svc

kubectl expose service prometheus-demo-server --type=LoadBalancer --target-port=9090 --name=prometheus-demo-server-ext

- Get the LoadBalancer IP:
kubectl get svc prometheus-demo-server-ext

- Open in a browser: http://<LoadBalancer-IP>:9090


### step 6: Cleanup
terraform destroy --auto-approve

