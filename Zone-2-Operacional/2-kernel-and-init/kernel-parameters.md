# Kernel Parameters Security Hardening - LinuxSFL 🔧

This document describes recommended kernel parameters for security hardening on Linux systems, aimed at preventing exploits and protecting system information.

---

## 🛠️ Recommended Kernel Security Parameters:

Edit `/etc/sysctl.conf` or create custom files under `/etc/sysctl.d/*.conf`.

### 1. 🔒 Restrict Kernel Logs Access

Protect sensitive kernel log information from unauthorized users.

```bash
kernel.dmesg_restrict = 1
```

---

### 2. ⌨️ Disable Magic SysRq Keys

Prevent unauthorized reboot, crash dumps, or debugging actions via keyboard shortcuts.

```bash
kernel.sysrq = 0
```

---

### 3. 🌐 Prevent IP Spoofing (Reverse Path Filtering)

Enable reverse path filtering to validate packet sources and stop IP spoofing attacks.

```bash
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
```

---

### 4. 🚨 Ignore ICMP Broadcast Requests

Reduce vulnerability to broadcast-based ICMP attacks, such as smurf attacks.

```bash
net.ipv4.icmp_echo_ignore_broadcasts = 1
```

---

## ✅ Applying Changes:

After adding or modifying parameters, apply the configuration:

```bash
sudo sysctl -p
```

---

## 📌 Recommendations:

- Regularly audit applied settings (`sysctl -a`).
- Document clearly all reasons for deviations from defaults.
- Consider additional kernel parameters depending on your specific security needs and operational environment.

---
