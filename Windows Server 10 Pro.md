# RDP – Windows 10 Pro (Docker)

**Developer:** ZarkosX
**Project:** RDP – Windows 10 Pro

This guide explains how to deploy **Windows 10 Pro with RDP access** using **Docker** and **Docker Compose** on a Linux VPS.

---

## System Requirements

### Minimum Requirements

* **CPU:** 4 vCPU
* **RAM:** 12 GB
* **Storage:** 32 GB SSD
* **OS:** Ubuntu 20.04 / 22.04 (or any modern Linux distro)
* **Access:** Root or sudo privileges

---

## Installation & Setup

Follow the steps below **in order**.

### 1. Switch to root user

```bash
sudo su
```

### 2. Update system packages

```bash
sudo apt update
```

### 3. Install Docker & Docker Compose

```bash
sudo apt install docker.io docker-compose -y
```

---

## 4. Download Configuration File

Download the Windows 10 Pro Docker Compose configuration:

```bash
wget -O WindowsServer.yml https://raw.githubusercontent.com/ZarkosX/ZarkosX-Scripts/refs/heads/main/WindowsServer.yml
```

(Optional) Review the file:

```bash
cat WindowsServer.yml
```

---

## 5. Start Windows 10 Pro Container

### Run normally

```bash
sudo docker-compose -f WindowsServer.yml up
```

### Run in background (recommended)

```bash
sudo docker-compose -f WindowsServer.yml up -d
```

Windows 10 Pro will start automatically.

---

## 6. RDP Access Information

* **RDP Port:** `8006`
* **Protocol:** Remote Desktop (RDP)
* **Client:** Any RDP client (Windows Remote Desktop, Remmina, Microsoft RDP, etc.)

### Example Connection

```
IP: Your_VPS_IP
Port: 8006
```

---

## 7. Container Management

### Stop container

```bash
sudo docker-compose -f WindowsServer.yml down
```

### Restart container

```bash
sudo docker-compose -f WindowsServer.yml restart
```

### View logs

```bash
sudo docker logs windows
```

---

## 8. Notes

* First boot may take **5–10 minutes**.
* Ensure port **8006** is open in your firewall.
* Performance depends on VPS resources.

---

## 9. Credits

**Developed by:** ZarkosX
**Project:** ZarkosX Scripts
**All rights reserved ©**

---

You have successfully deployed Windows 10 Pro RDP using Docker
