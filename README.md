# Overview
This project demonstrates the deployment of a static web application on an AWS-based Kubernetes cluster. The setup leverages Terraform for infrastructure provisioning, Docker for containerization, and Prometheus for monitoring.

# Prerequisites
Ensure you have the following tools installed on your local machine:

- AWS CLI (for managing AWS resources)
- Terraform (for Infrastructure as Code)
- Kubectl (for interacting with the Kubernetes cluster)
- Docker (for containerizing the application)
- Helm (for deploying Prometheus for monitoring)

# Step 1: Set Up Infrastructure with Terraform
Terraform automates the creation of cloud resources. Navigate to the directory containing main.tf and execute the following commands:

1- Initialize Terraform (downloads necessary provider plugins):
terraform init

2- Validate the Terraform configuration to ensure there are no syntax errors:
terraform validate

3- Create an execution plan to preview the infrastructure changes:
terraform plan

4- Apply the changes to provision the infrastructure:
terraform apply -auto-approve

This step will create an AWS EKS (Elastic Kubernetes Service) cluster to host the application.

# Step 2: Configure kubectl to Connect to AWS EKS
Once the EKS cluster is set up, configure your local system to communicate with it.

1- Run the following command to update your kubeconfig file:
aws eks --region us-east-1 update-kubeconfig --name eks_cluster_demo

2- Verify that the cluster nodes are available:
kubectl get nodes

If successful, you should see a list of worker nodes ready to run workloads.

# Step 3: Build and Push Docker Image
The web application needs to be packaged into a Docker container before deployment.

Navigate to the folder containing the Dockerfile.

1- Build the Docker image:
docker build -t aman1407/devops-webapp:latest .

2- Push the image to Docker Hub (or any container registry):
docker push aman1407/devops-webapp:latest

This step ensures that the containerized application is available for deployment on Kubernetes.

# Step 4: Deploy the Application to Kubernetes

Navigate to the Kubernetes folder where the deployment and service YAML files are located.

1- Deploy the application using the following commands:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
2- Get the LoadBalancer IP to access the application:
kubectl get svc webapp-service

Open a browser and enter:
http://<LoadBalancer-IP>

This should display your deployed web application.

# Step 5: Set Up Monitoring with Prometheus
Prometheus is used to monitor the application and collect metrics.

1- Add the Prometheus Helm repository:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

2- Update Helm repositories:
helm repo update

3- Install Prometheus using Helm:
helm install prometheus-demo prometheus-community/prometheus

4- Verify that the services are running:
kubectl get svc

5- Expose the Prometheus server using a LoadBalancer:
kubectl expose service prometheus-demo-server --type=LoadBalancer --target-port=9090 --name=prometheus-demo-server-ext

6- Get the LoadBalancer IP for Prometheus:
kubectl get svc prometheus-demo-server-ext

Open a browser and enter:
http://<LoadBalancer-IP>:9090

This should open the Prometheus web interface for monitoring.

# Step 6: Cleanup (Destroy Infrastructure)
To remove all resources and avoid unnecessary AWS costs, run the following command in the directory where the main.tf file is located:

terraform destroy --auto-approve

This will delete the EKS cluster, networking components, and any associated resources.
