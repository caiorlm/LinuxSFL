# Fail2Ban Intrusion Prevention Setup - LinuxSFL 🚫

This document outlines best practices for installing, configuring, and managing **Fail2Ban**, an intrusion prevention tool that monitors logs for suspicious activity and dynamically blocks offending IP addresses.

---

## ✅ **Installation of Fail2Ban:**

On RHEL-based distributions (Rocky, CentOS, Fedora):
```bash
sudo dnf install fail2ban -y
```

On Debian-based distributions (Ubuntu, Debian):
```bash
sudo apt install fail2ban -y
```

---

## 🛠️ **Basic Fail2Ban Configuration:**

**Copy the default configuration file to start customizing:**
```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Edit the configuration file:
```bash
sudo nano /etc/fail2ban/jail.local
```

Basic configuration example (`jail.local`):
```ini
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1
bantime  = 1h
findtime  = 10m
maxretry = 5

[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
```

---

## ⚙️ **Fail2Ban Service Management:**

Enable and start Fail2Ban service immediately:
```bash
sudo systemctl enable --now fail2ban
```

Check Fail2Ban status:
```bash
sudo systemctl status fail2ban
```

---

## 🔍 **Inspecting Fail2Ban Logs and Banned IPs:**

View Fail2Ban logs:
```bash
sudo tail -f /var/log/fail2ban.log
```

Check currently banned IPs for SSH jail:
```bash
sudo fail2ban-client status sshd
```

Unban specific IP manually:
```bash
sudo fail2ban-client set sshd unbanip 203.0.113.10
```

---

## 📌 **Recommended Best Practices:**

- Regularly review banned IP addresses and logs.
- Adjust `maxretry` and `findtime` based on threat levels.
- Monitor the effectiveness and adjust rules promptly to reduce false positives.

---

*[Linux Security Framework Layer – Zone 3: Network]*
