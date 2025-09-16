# 🐳 Inception

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![42 Project](https://img.shields.io/badge/42-000000?style=for-the-badge&logo=42&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

## 📌 Project Overview
Inception is a **42 School project** that introduces you to **system administration** and **containerization**.  
The goal is to set up a small infrastructure composed of multiple **Docker containers**, orchestrated with **docker-compose**, while building each service from scratch (no pre-built images except `debian`/`alpine`).

---

## ⚙️ Mandatory Services

### 🌐 Nginx
- Acts as a **reverse proxy** between the outside world and internal services.  
- Configured with **TLS/SSL certificates** to ensure secure HTTPS connections.  
- Serves WordPress and other web content securely.  

### 📝 WordPress (with PHP-FPM)
- A popular **Content Management System (CMS)** used to build and manage websites.  
- Runs on **PHP-FPM (FastCGI Process Manager)** for optimized PHP execution.  
- Files are stored in a **persistent volume** so data is not lost when the container restarts.  

### 🗄️ MariaDB
- A relational **database management system** forked from MySQL.  
- Stores WordPress user data, posts, settings, and configurations.  
- Data is saved in a **persistent volume** for reliability.  

---

## 🔥 Bonus Services

### ⚡ Redis Cache
- An **in-memory key-value store** used to cache WordPress queries.  
- Improves website performance by reducing database load.  

### 📂 FTP Server
- Provides **remote access** to WordPress files.  
- Allows developers to upload, download, and manage files securely.  

### 🛠 Adminer
- A lightweight **database management tool**.  
- Provides a simple **web-based interface** to interact with MariaDB.  

### 📊 cAdvisor
- **Container monitoring tool** developed by Google.  
- Tracks container **CPU, memory, network, and disk usage** in real time.  

### 🌍 Custom Website
- A **static website** hosted alongside WordPress.  
- Demonstrates hosting multiple services under the same infrastructure.  
