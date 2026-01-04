# RDPWin10

## **RDP – Windows 10 (Docker)**

**Developer:** ZarkosX
**Project:** RDP – Windows 10

This guide explains how to deploy **Windows 10 RDP** using **Docker & Docker Compose** on a Linux VPS.

---

### **System Requirements**

* Minimum:

  * **4 vCPU**
  * **12 GB RAM**
  * **32 GB Disk**
* Root or sudo access

---

### **Setup Instructions**

Run the following commands **in order**:

1. Switch to root:

```bash
sudo su
```

2. Update the system:

```bash
sudo apt update
```

3. Install Docker and Docker Compose:

```bash
sudo apt install docker.io docker-compose -y
```

```bash
docker
```

```bash
pwd
```


4. Download configuration file:

```bash
wget -O WelderWin10.yml https://raw.githubusercontent.com/ZarkosX/ZarkosX-Scripts/refs/heads/main/WelderWin10.yml
```

5. (Optional) Review the file:

```bash
cat WelderWin10.yml
```

---

### **Start Windows 10**

```bash
sudo docker-compose -f WelderWin10.yml up
```

Run in background (detached mode):

```bash
sudo docker-compose -f WelderWin10.yml up -d
```

---

### **RDP Access**

* **RDP Port:** `8006`
* Use any RDP client to connect
* Windows 10 will start automatically

---

### **Credits**

**Developed by:** ZarkosX
**All rights reserved**
