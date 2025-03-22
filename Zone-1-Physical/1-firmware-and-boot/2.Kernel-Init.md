# Zone 1 – Layer 02: Kernel and Init (Low-Level Bash)

## Objective
Validate that the Linux kernel, its modules, and the init system (e.g. systemd or SysV) are securely configured and verifiable through low-level Bash commands.

## Key Checks
- Kernel version and configuration
- Loaded kernel modules
- Init system detection
- Runlevel or target state
- Secure sysctl parameters (basic validation)

---

## 1. Kernel Version and Boot Parameters

### Script: `kernel_version_check.sh`
```bash
#!/bin/bash

echo "[INFO] Kernel Version:"
uname -r

echo "[INFO] Boot parameters (/proc/cmdline):"
cat /proc/cmdline
```

### Explanation:
- `uname -r`: shows current kernel version
- `/proc/cmdline`: shows the boot parameters passed to the kernel by the bootloader

---

## 2. Kernel Modules Loaded

### Script: `kernel_modules_check.sh`
```bash
#!/bin/bash

echo "[INFO] Currently loaded kernel modules:"
cat /proc/modules | awk '{print $1}'
```

### Explanation:
- `/proc/modules`: gives a list of modules currently active
- The script parses and displays only the module names

---

## 3. Init System Detection

### Script: `init_detection.sh`
```bash
#!/bin/bash

if [ -d /run/systemd/system ]; then
  echo "[INFO] Init system detected: systemd"
elif [ -f /etc/init.d/cron ]; then
  echo "[INFO] Init system detected: SysVinit"\else
  echo "[WARN] Init system could not be reliably detected."
fi
```

### Explanation:
- Checks for `systemd` directories or legacy `/etc/init.d` to detect the init system in use

---

## 4. Runlevel or Target

### Script: `runlevel_or_target.sh`
```bash
#!/bin/bash

if command -v systemctl &>/dev/null; then
  echo "[INFO] Current systemd target:"
  systemctl get-default
else
  echo "[INFO] Current SysV runlevel:"
  runlevel
fi
```

### Explanation:
- Determines if system is in graphical, multi-user, or single-user mode (used for enforcement decisions)

---

## 5. Basic Sysctl Security Parameters

### Script: `sysctl_basics_check.sh`
```bash
#!/bin/bash

echo "[INFO] Checking sysctl network hardening parameters:"

params=(
  "net.ipv4.conf.all.rp_filter"
  "net.ipv4.icmp_echo_ignore_broadcasts"
  "kernel.kptr_restrict"
)

for param in "${params[@]}"; do
  value=$(sysctl -n "$param" 2>/dev/null)
  echo "$param = $value"
done
```

### Explanation:
- Lists a few critical hardening parameters (expandable)
- Checks current runtime values

---

## Recommended Hardening
- Disable unneeded kernel modules (blacklist in `/etc/modprobe.d/`)
- Use a hardened sysctl policy
- Avoid running in graphical.target on servers unless required
- Minimize init services at boot

---

## Output Sample
```
[INFO] Kernel Version:
5.14.0-427.el9.x86_64

[INFO] Boot parameters:
ro crashkernel=auto rhgb quiet

[INFO] Init system detected: systemd
[INFO] Current systemd target: multi-user.target

[INFO] Checking sysctl:
net.ipv4.conf.all.rp_filter = 1
kernel.kptr_restrict = 1
```

---

## Layer Status
PASS if:
- Kernel version and cmdline detected
- Init system identified
- Sysctl values align with hardening

FAIL if:
- Missing detection
- Sysctl returns insecure values

---

**Maintained by:** LinuxSFL Core Team  
**License:** MIT  
**Profile relevance:** All profiles (required for all servers)

