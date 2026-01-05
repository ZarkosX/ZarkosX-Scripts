# RDP – Windows 10 Pro (Docker)

**Developer:** ZarkosX
**Project:** RDP – Windows 10 Pro

This guide explains how to deploy **Windows 10 Pro with RDP access** using **Docker** and **Docker Compose** on a Linux VPS.

---

## 1. System Requirements

### 1.1 Minimum Requirements

* **CPU:** 4 vCPU
* **RAM:** 12 GB
* **Storage:** 32 GB SSD
* **OS:** Ubuntu 20.04 / 22.04 (or any modern Linux distro)
* **Access:** Root or sudo privileges

---

## 2. Installation & Setup

Follow the steps below **in order**.

### 1️⃣ 2.1 Switch to root user

```bash
sudo su
```

### 2️⃣ 2.2 Update system packages

```bash
sudo apt update
```

### 3️⃣ 2.3 Install Docker & Docker Compose

```bash
sudo apt install docker.io docker-compose -y
```

Verify installation:

```bash
docker --version
docker-compose --version
```

---

## 3. Download Configuration File

Download the Windows 10 Pro Docker Compose configuration:

```bash
wget -O RDPWin10.yml https://raw.githubusercontent.com/ZarkosX/ZarkosX-Scripts/refs/heads/main/RDPWin10.yml
```

(Optional) Review the file:

```bash
cat RDPWin10.yml
```

---

## 4. Start Windows 10 Pro Container

### Run normally

```bash
sudo docker-compose -f RDPWin10.yml up
```

### Run in background (recommended)

```bash
sudo docker-compose -f RDPWin10.yml up -d
```

Windows 10 Pro will start automatically.

---

## 5. RDP Access Information

* **RDP Port:** `8006`
* **Protocol:** Remote Desktop (RDP)
* **Client:** Any RDP client (Windows Remote Desktop, Remmina, Microsoft RDP, etc.)

### Example Connection

```
IP: Your_VPS_IP
Port: 8006
```

---

## 6. Container Management

### Stop container

```bash
sudo docker-compose -f RDPWin10.yml down
```

### Restart container

```bash
sudo docker-compose -f RDPWin10.yml restart
```

### View logs

```bash
sudo docker logs windows
```

---

## 7. Notes

* First boot may take **5–10 minutes**.
* Ensure port **8006** is open in your firewall.
* Performance depends on VPS resources.

---

## 8. Credits

**Developed by:** ZarkosX
**Project:** ZarkosX Scripts
**All rights reserved ©**

---

You have successfully deployed Windows 10 Pro RDP using Docker
