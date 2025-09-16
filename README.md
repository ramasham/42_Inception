<p align="center">
  <h1>🐳 Inception</h1>

  <img src="https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white">
  <img src="https://img.shields.io/badge/42-000000?style=flat-square&logo=42&logoColor=white">
  <img src="https://img.shields.io/badge/Status-Completed-success?style=flat-square">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square">
</p>

---

## 📌 Project Overview
**Inception** is a **42 School project** focused on **system administration** and **containerization**.  
It sets up a small infrastructure of **Docker containers** orchestrated with **docker-compose**, building each service from scratch (base images: `debian`/`alpine`).

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
