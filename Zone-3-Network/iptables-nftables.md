# iptables & nftables Firewall Management - LinuxSFL 🛡️

This document details recommended practices for managing and securing Linux firewall rules using **iptables** and its successor, **nftables**, enhancing security and flexibility in network management.

---

## ✅ **Choosing Between iptables and nftables**

- **iptables**: Traditional firewall widely used in legacy systems.
- **nftables**: Modern successor offering enhanced performance, readability, and management flexibility.

**Recommendation**: Migrate gradually from `iptables` to `nftables` for future-proof management.

---

## 🛠️ **Common iptables Commands:**

**View current firewall rules:**
```bash
sudo iptables -L -n -v
```

**Block incoming traffic from specific IP:**
```bash
sudo iptables -A INPUT -s 203.0.113.10 -j DROP
```

**Allow incoming SSH traffic:**
```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

**Save iptables rules permanently:**
```bash
sudo iptables-save > /etc/iptables/rules.v4
```

---

## 🛠️ **Common nftables Commands:**

**List current ruleset:**
```bash
sudo nft list ruleset
```

**Create basic ruleset with nftables:**
```bash
sudo nft add table inet filter
sudo nft add chain inet filter input { type filter hook input priority 0 \; policy drop \; }
sudo nft add rule inet filter input tcp dport {22, 80, 443} accept
```

**Block traffic from specific IP:**
```bash
sudo nft add rule inet filter input ip saddr 203.0.113.10 drop
```

**Save nftables rules permanently:**
```bash
sudo nft list ruleset > /etc/nftables.conf
```

---

## 🔄 **Migration from iptables to nftables**

Convert iptables rules to nftables format automatically:
```bash
sudo iptables-save > rules.v4
sudo iptables-translate -f rules.v4 > nftables.rules
sudo nft -f nftables.rules
```

---

## 📌 **Best Practices:**

- Regularly audit firewall rulesets.
- Clearly document each firewall rule and its purpose.
- Maintain backups of firewall rules:
  ```bash
  sudo nft list ruleset > nft-backup-$(date +%Y-%m-%d).conf
  ```
- Ensure minimal exposure of services; default-deny incoming traffic is recommended.

---

*[Linux Security Framework Layer – Zone 3: Network]*
