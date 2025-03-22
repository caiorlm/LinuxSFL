# Firewalld Configuration and Best Practices - LinuxSFL 🔥

This document describes recommended practices for configuring and managing the **firewalld** dynamic firewall in Linux environments to enhance network security and protection.

---

## ✅ **Essential Zones and Their Usage**

**Default Zones:**

| Zone      | Purpose/Description                              | Recommended Usage |
|-----------|---------------------------------------------------|-------------------|
| **public**    | General public networks.                        | Default zone for public interfaces ✅ |
| **internal**  | Internal trusted networks.                      | For internal LAN traffic ✅ |
| **dmz**       | Demilitarized Zone, for exposed services.       | For services accessible from the internet ✅ |
| **trusted**   | Fully trusted connections (minimal filtering).  | For highly secure networks only ⚠️ |

---

## 🛠️ **Key Commands for Firewalld:**

**Check active zones and services:**
```bash
sudo firewall-cmd --get-active-zones
```

**List current rules for a zone:**
```bash
sudo firewall-cmd --zone=public --list-all
```

**Add permanent service or port to a zone:**
```bash
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
```

**Remove a permanent service or port:**
```bash
sudo firewall-cmd --zone=public --remove-service=https --permanent
sudo firewall-cmd --zone=public --remove-port=8080/tcp --permanent
```

**Apply changes immediately:**
```bash
sudo firewall-cmd --reload
```

---

## 🔍 **Rich Rules for Advanced Configuration:**

Firewalld Rich Rules allow more granular and flexible firewall rules:

**Allow SSH only from a specific subnet:**
```bash
sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" source address="192.168.10.0/24" service name="ssh" accept'
```

**Block traffic from an IP address:**
```bash
sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" source address="203.0.113.10" reject'
```

---

## 📌 **Recommendations:**

- **Regularly audit firewall configuration**:
  ```bash
  sudo firewall-cmd --list-all-zones
  ```
  
- **Document clearly** all added services, ports, and rich rules.
- **Regularly back up** firewall configuration:
  ```bash
  sudo firewall-cmd --runtime-to-permanent
  ```
- Minimize exposed ports/services and enforce least-privilege access.

---

*[Linux Security Framework Layer – Zone 3: Network]*
