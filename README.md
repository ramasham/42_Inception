<div align="center" style="margin-bottom:30px;">
  <h1>🐳 Inception</h1>
  
  <p>
    <img src="https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Docker" style="margin:0 5px;">
    <img src="https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx&logoColor=white" alt="Nginx" style="margin:0 5px;">
    <img src="https://img.shields.io/badge/MariaDB-003545?style=flat-square&logo=mariadb&logoColor=white" alt="MariaDB" style="margin:0 5px;">
    <img src="https://img.shields.io/badge/HTTPS-007ACC?style=flat-square" alt="HTTPS" style="margin:0 5px;">
  </p>

  <img src="https://github.com/user-attachments/assets/d25d06c7-634f-4204-a017-1b2179ff735f" 
       alt="Inception Overview" 
       width="300" 
       style="border-radius:12px; box-shadow:0 6px 20px rgba(0,0,0,0.25); margin-top:15px;">
</div>

---

## 📌 Project Overview

**Inception** is a **42 School project** designed to give students hands-on experience with **containerization**, **orchestration**, and **system administration**. The goal is to simulate a real-world small-scale infrastructure, where multiple services work together seamlessly inside isolated environments.  

This project is more than just spinning up Docker containers—it challenges you to:  
- Understand how **services communicate** over a network inside containers.  
- Configure **web servers, databases, and CMS platforms** in a secure and scalable way.  
- Use **persistent storage** to ensure your data survives container restarts.  
- Implement **security best practices**, including TLS/SSL for encrypted connections.  

By the end of the project, you will have a fully functional setup where:  
- **WordPress** runs as a dynamic website engine.  
- **MariaDB** stores all user data and content reliably.  
- **Nginx** acts as a reverse proxy, routing traffic efficiently and securely.  
- Optional **bonus services** like Redis, FTP, Adminer, and cAdvisor enhance performance, accessibility, and monitoring.  

This project is perfect for anyone looking to:  
- Learn **modern DevOps practices** and containerized deployment.  
- Build a small, production-like environment **from scratch**.  
- Explore **multi-service orchestration** in a controlled, hands-on setting.  

In short, **Inception** combines education and practicality, giving you a miniature yet realistic experience of running a service-oriented architecture—just like in real-world companies.  

---

## ⚙️ Core Services

### 🌐 Nginx
- Reverse proxy routing external traffic to services.  
- Configured with **TLS/SSL** for HTTPS.  
- Serves WordPress and static websites securely.  

### 📝 WordPress (PHP-FPM)
- Popular **CMS** for website management.  
- Runs with **PHP-FPM** for optimized PHP execution.  
- Uses **persistent volumes** to preserve files across restarts.  

### 🗄️ MariaDB
- Relational **database system** (MySQL fork).  
- Stores WordPress content and user data.  
- Data persisted in dedicated volumes.

---

## 🔥 Bonus Services

### ⚡ Redis
- **In-memory key-value store** for caching.  
- Reduces database load and improves performance.  

### 📂 FTP Server
- Provides secure **file access** to WordPress files.  

### 🛠 Adminer
- Lightweight web-based **database management tool**.  

### 📊 cAdvisor
- Real-time **container monitoring** tool.  
- Tracks CPU, memory, network, and disk usage.  

### 🌍 Custom Website
- **Static website** hosted alongside WordPress.  
- Demonstrates multiple service hosting.

---

## 🛠️ Tech Stack
<p align="center">
  <img src="https://www.vectorlogo.zone/logos/docker/docker-icon.svg" width="40" title="Docker">
  <img src="https://www.vectorlogo.zone/logos/nginx/nginx-icon.svg" width="40" title="Nginx">
  <img src="https://www.vectorlogo.zone/logos/wordpress/wordpress-icon.svg" width="40" title="WordPress">
  <img src="https://www.vectorlogo.zone/logos/mysql/mysql-icon.svg" width="40" title="MariaDB">
  <img src="https://www.vectorlogo.zone/logos/redis/redis-icon.svg" width="40" title="Redis">
  <img src="https://www.vectorlogo.zone/logos/google/google-icon.svg" width="40" title="cAdvisor">
</p>

This project showcases the power of containerization and orchestration, giving you a solid foundation to build, deploy, and manage real-world services efficiently.
