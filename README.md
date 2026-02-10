# 🚀 DevOps Complete Pipeline

## 📌 Project Summary

This project is a complete CI/CD pipeline implementation for a containerized Python (Flask) application using:

- Docker
- Jenkins (CI)
- AWS EC2
- AWS ECR
- SSH-based Deployment

The goal of this assignment was to design and implement a working DevOps workflow that builds, pushes, and deploys an application in an automated manner.

---

# 🧠 Architecture Overview

The system is composed of two EC2 instances inside the same VPC:

### 1️⃣ Jenkins Server (CI)
- Ubuntu 22.04
- Runs Jenkins on port 8080
- Docker installed
- IAM Role attached with ECR permissions
- Builds and pushes Docker images

### 2️⃣ Application Server (CD Target)
- Ubuntu 22.04
- Docker installed
- Runs the application container
- Exposes port 8000 to the public

### 3️⃣ AWS ECR
- Private Docker registry
- Stores application images
- Used by Jenkins for image push
- Used by App server for image pull

---

# 🔄 CI/CD Flow

### Detailed Pipeline Flow

1. Developer pushes code to GitHub
2. Jenkins pulls latest code
3. Docker image is built
4. Jenkins authenticates to AWS ECR
5. Docker image is tagged and pushed
6. Jenkins connects via SSH to App EC2
7. App server pulls latest image
8. Old container is stopped and removed
9. New container is started on port 8000

---

# 🐍 Application Details

The application is a simple Flask service that:

- Runs internally on port 5000
- Is exposed externally on port 8000
- Returns HTTP response
- Includes optional `/health` endpoint for readiness check


# 🐍 Recommendations:
Throughout the implementation of this CI/CD pipeline, several important DevOps principles were reinforced. First, infrastructure reliability and service readiness after instance restarts must never be taken for granted — proper monitoring, health checks, and service validation are critical. Security configuration requires precise control, especially around Security Groups and SSH access, to avoid connectivity issues while maintaining minimal exposure. Additionally, while SSH-based deployment is suitable for learning and small environments, production systems should rely on orchestrated platforms such as ECS or Kubernetes to eliminate manual deployment risks and improve scalability. For a production-grade environment, it is strongly recommended to introduce Elastic IP allocation, Application Load Balancers, HTTPS termination, centralized logging, CloudWatch monitoring, Infrastructure as Code (Terraform) for full environment reproducibility, and deployment strategies such as Blue/Green with automated rollback mechanisms. These improvements would elevate the current solution from a functional CI/CD implementation to a resilient, scalable, and enterprise-ready DevOps architecture.


