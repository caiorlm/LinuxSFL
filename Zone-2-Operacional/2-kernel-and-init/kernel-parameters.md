# Kernel Parameters Security Hardening - LinuxSFL 🔧

This document describes recommended kernel parameters for security hardening on Linux systems, aimed at preventing exploits and protecting system information.

## 🛠️ Recommended Kernel Security Parameters:

Edit `/etc/sysctl.conf` or create custom files under `/etc/sysctl.d/*.conf`.

### 1. Restrict Kernel Logs Access
```bash
kernel.dmesg_restrict = 1
Protects sensitive kernel log information.

2. Disable Magic SysRq Keys
bash
Copiar
Editar
kernel.sysrq = 0
Prevents unauthorized reboot and system dumps via keyboard.

3. Prevent IP Spoofing
bash
Copiar
Editar
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
Enables reverse-path filtering to stop IP spoofing.

4. Ignore ICMP Broadcast Requests
bash
Copiar
Editar
net.ipv4.icmp_echo_ignore_broadcasts = 1
Reduces vulnerability to broadcast ping attacks.

✅ Applying changes:
bash
Copiar
Editar
sudo sysctl -p
📌 Recommendations:
Regularly audit applied settings.
Document reasons for all deviations from default.
Consider additional parameters based on environment specifics.
