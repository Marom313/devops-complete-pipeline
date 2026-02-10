# DevOps Complete Pipeline – Stage 1

## Overview
Simple Flask application containerized with Docker.  
This repository demonstrates the initial steps of a DevOps workflow.

---

## Current Stage

### 1. Application
- Python Flask app
- Exposes HTTP service on port 5000
- Basic HTML response

### 2. Dockerization
- Dockerfile created
- Image built locally
- Container runs on:

### 3. Local Testing
- Verified container is running
- Verified browser access
- Confirmed rebuild workflow (code change → build → run)

### 4. Version Control
- Git initialized
- Main branch only
- Code pushed to GitHub repository

---

## Next Steps
- Add docker-compose
- Implement Jenkins pipeline
- Improve production readiness (Gunicorn, etc.)
