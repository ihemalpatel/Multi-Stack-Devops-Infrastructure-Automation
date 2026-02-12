<!-- © 2024 | Ironhack -->

# Multi-Stack Voting Application

This repository contains a **multi-tier, multi-language voting application** developed as a **DevOps automation project**.  
The project demonstrates how modern applications are provisioned, deployed, and operated using **Terraform, Ansible, Docker, and AWS**, while addressing real-world challenges such as service communication, container networking, and platform compatibility.

The application intentionally combines **multiple technologies** to simulate production-like complexity and strengthen practical DevOps troubleshooting skills.

---

## Architecture Overview

The system follows a **three-tier distributed architecture**:

### Application Components

- **Vote Service (Python / Flask)**  
  A web interface where users cast votes between two options.

- **Redis (In-memory Queue)**  
  Temporarily stores votes and acts as a message queue.

- **Worker Service (.NET)**  
  Consumes votes from Redis and writes them into the database.

- **PostgreSQL (Database)**  
  Persists voting data for long-term storage.

- **Result Service (Node.js / Express)**  
  Displays real-time voting results from the database.

### Data Flow
User → Vote App → Redis → Worker → PostgreSQL → Result App

---

## DevOps & Infrastructure Stack

This project focuses on **Infrastructure as Code (IaC)** and automation:

- **Terraform** – Infrastructure provisioning on AWS  
- **Ansible** – Configuration management and application deployment  
- **Docker** – Containerization of all services  
- **Docker Compose** – Local orchestration and testing  
- **AWS EC2** – Hosting frontend, backend, and database tiers  
Multi-Stack-Devops-Infrastructure-Automation/
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.ini
│   ├── group_vars/
│   ├── playbooks/
│   │   └── site.yml
│   ├── roles/
│   │   ├── docker/
│   │   ├── database/
│   │   ├── backend/
│   │   └── frontend/
│   └── collections/
│       └── requirements.yml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── vote/        # Python Flask app
├── worker/      # .NET worker service
├── result/      # Node.js result app
├── healthchecks/
│
├── .gitignore
├── LICENSE
└── README.md

---

## What We Learned

Through this project, **we learned how to**:

- Deploy and connect multi-service applications
- Automate infrastructure provisioning and configuration
- Manage container networking across multiple hosts
- Debug real-world service communication issues
- Handle platform differences (amd64 vs arm64)
- Validate end-to-end data flow across distributed systems

This project emphasized **practical problem-solving** over idealized architecture.

---

## Major Challenge & Solution

### Challenge  
The voting application initially failed to display live results due to:
- Redis and PostgreSQL connectivity issues
- Incorrect environment variables
- Platform mismatches between Docker images
- Containers waiting indefinitely for dependencies

### Solution  
These issues were resolved by:
- Correctly exposing Redis and PostgreSQL services
- Aligning environment variables across services
- Building amd64-compatible Docker images
- Verifying network connectivity between hosts
- Restarting services in the correct dependency order

This resulted in a fully functional **end-to-end voting system**.

---

## Accessing the Application

- **Vote Application**  
  👉 http://18.184.236.82:5000/

- **Result Application**  
  👉 http://18.184.236.82:5001/

---

## Platform Notes

On Apple Silicon (arm64) systems, some services required amd64 images:
```bash
docker buildx build --platform linux/amd64 -t image:tag .


Authors

Shishir Pariyar

Hemal Patel

Fawad