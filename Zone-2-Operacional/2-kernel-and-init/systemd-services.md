📄 **`systemd-services.md`**

# Systemd Services Management - LinuxSFL ⚙️

This document outlines best practices for configuring and managing critical **systemd** services to improve security, performance, and stability on Linux systems.

---

## ✅ Essential Services Checklist

Ensure the following critical services are enabled and monitored regularly:

| Service   | Description                  | Recommended Status           |
|-----------|------------------------------|------------------------------|
| `firewalld` | Dynamic Firewall Management | ✅ Enabled and Running      |
| `sshd`    | SSH Remote Access            | ✅ Enabled and Secured      |
| `auditd`  | Auditing and Logging         | ✅ Enabled and Running      |
| `fail2ban`| Intrusion Prevention System  | ✅ Enabled and Running      |

---

## 🛠️ Useful Commands for Service Management

**Check service status:**
```bash
sudo systemctl status <service_name>
```

**Enable service on boot:**
```bash
sudo systemctl enable <service_name>
```

**Disable service on boot:**
```bash
sudo systemctl disable <service_name>
```

**Start or restart a service immediately:**
```bash
sudo systemctl start <service_name>
sudo systemctl restart <service_name>
```

---

## 🔍 Service Logs and Auditing

Inspect logs regularly using `journalctl`:
```bash
sudo journalctl -u firewalld
sudo journalctl -u sshd
sudo journalctl -u auditd
sudo journalctl -u fail2ban
```

Configure advanced audit rules for critical services in:
```bash
/etc/audit/rules.d/
```

---

## 📌 Important Recommendations

- Regularly audit active services:
```bash
sudo systemctl list-units --type=service
```

- Immediately disable any unnecessary or unused services.
- Clearly document any exceptions to standard policies.

---

*[Linux Security Framework Layer – Zone 2: Operational]*
