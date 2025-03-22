# 🕒 Cron, Nohup, and Systemd Services: Scheduling and Background Tasks - LinuxSFL ⚙️

**Zone 2: Operational**

This document provides clear guidelines and best practices for using **Cron**, **Nohup**, and **Systemd services** to schedule, run, and manage background processes and tasks effectively on Linux systems.

---

## 📌 Overview & Use-Cases

| Tool/Feature       | Description                                    | When to use?                      |
|--------------------|------------------------------------------------|-----------------------------------|
| **Cron**           | Task scheduler based on date/time intervals.   | Scheduled repetitive tasks        |
| **Nohup**          | Detach terminal processes from user sessions.  | Long-running scripts/tasks        |
| **Systemd service**| Standardized process manager & service control | Complex persistent services/tasks |

---

## ⏱️ 1. **Cron (crontab)**

Cron is the standard Linux scheduling tool used for running scripts or commands periodically.

### 🛠️ **Common Cron Commands:**

- Edit cron jobs:
```bash
crontab -e
```

- List active cron jobs:
```bash
crontab -l
```

- Remove cron jobs:
```bash
crontab -r
```

### 📆 **Cron Job Syntax:**
```
* * * * * /path/to/script.sh
- - - - -
| | | | |
| | | | +----- Day of week (0 - 7) (Sunday=0 or 7)
| | | +------- Month (1 - 12)
| | +--------- Day of month (1 - 31)
| +----------- Hour (0 - 23)
+------------- Minute (0 - 59)
```

**Examples:**
```bash
# Run script daily at midnight:
0 0 * * * /home/user/backup.sh

# Run every 15 minutes:
*/15 * * * * /home/user/cleanup.sh
```

### 📌 **When to Use Cron:**
- Scheduled backups, log rotations.
- Regular database maintenance tasks.
- System updates and monitoring tasks.

---

## 🚀 2. **Nohup (No Hangup)**

`nohup` is a command-line tool used to run a script or command independent of a terminal session.

### 🛠️ **Basic Nohup Usage:**

- Run process with nohup:
```bash
nohup ./script.sh &
```

- Redirect nohup output:
```bash
nohup ./script.sh > output.log 2>&1 &
```

- Check running processes:
```bash
ps aux | grep script.sh
```

### 📌 **When to Use Nohup:**
- One-time execution of scripts that need to run even after closing the terminal.
- Quick and temporary detachments from shell sessions.
- Situations where creating a full service is overkill.

---

## ⚙️ 3. **Systemd Services (.service)**

Systemd services offer complete management for system tasks, including starting at boot, logging, automatic restart, and resource management.

### 🛠️ **Creating a Systemd Service:**

- Create a file under `/etc/systemd/system/`, e.g., `/etc/systemd/system/myservice.service`:
```ini
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /path/to/my_script.py
Restart=always
User=root
WorkingDirectory=/path/to/

[Install]
WantedBy=multi-user.target
```

- Enable and start your service:
```bash
sudo systemctl enable myservice.service
sudo systemctl start myservice.service
```

- Check the service status:
```bash
sudo systemctl status myservice.service
```

- Check service logs:
```bash
sudo journalctl -u myservice.service -f
```

### 📌 **When to Use Systemd Service:**
- For services that must start automatically after reboot.
- Long-running processes needing automatic restart on failures.
- Services requiring advanced resource management and system integration.

---

## 🆚 **Comparative Table: Cron vs Nohup vs Systemd**

| Feature                  | Cron                           | Nohup                     | Systemd Service                 |
|--------------------------|--------------------------------|---------------------------|---------------------------------|
| Persistence after reboot | ✅ (if configured)             | ❌                        | ✅                              |
| Task scheduling          | ✅ (detailed schedules)        | ❌                        | ✅ (basic with timers units)    |
| Restart policy           | ❌ (manually handled)          | ❌                        | ✅ (automatic)                  |
| Ease of use/setup        | ✅ (very easy)                 | ✅ (simplest)             | ⚙️ (moderate setup complexity) |
| Resource management      | ❌ (limited)                   | ❌                        | ✅ (full control, cgroups)      |
| Logging/Auditing         | ✅ (logs manually)             | ✅ (manual via redirection)| ✅ (integrated with journalctl) |
| Best suited for          | Scheduled repeating tasks      | Detached one-time scripts | Persistent background services  |

---

## 🌟 **Recommendations & Best Practices:**

- Use **Cron** for regular maintenance, backup, and simple recurring tasks.
- Use **Nohup** for quick, temporary tasks that need to survive closed terminal sessions.
- Prefer **Systemd services** for robust management of long-term, persistent, or critical services.
- Always redirect output and error logs appropriately for monitoring and troubleshooting.

---

## ✅ **Summary & Quick Reference**

### **Cron:**
```bash
crontab -e
*/5 * * * * /path/script.sh
```

### **Nohup:**
```bash
nohup ./longtask.sh &
```

### **Systemd Service:**
```bash
sudo systemctl enable your.service
sudo systemctl start your.service
sudo systemctl status your.service
```

---

*Documented as part of the Linux Security Framework Layer – Zone 2: Operational*
