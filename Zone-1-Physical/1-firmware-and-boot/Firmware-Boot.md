# Zone 1 – Layer 01: Firmware and Boot (Low-Level Bash)

## Objective
Ensure that system firmware (BIOS/UEFI) and bootloader configurations (GRUB2) are securely implemented and auditable.

## Overview
This layer focuses on three key areas:
- BIOS/UEFI Configuration
- GRUB2 Password Protection
- Secure Boot Status

All checks are implemented in pure Bash using native Linux tools, avoiding dependencies such as firewalld, dnf, or Python.

---

## 1. BIOS/UEFI Configuration Check

### Script: `bios_configuration_check.sh`
```bash
#!/bin/bash

if ! command -v dmidecode &>/dev/null; then
  echo "[ERROR] dmidecode is not installed. Install it to inspect BIOS data."
  exit 1
fi

echo "[INFO] BIOS Vendor and Version:"
dmidecode -t bios | grep -E 'Vendor|Version|Release Date'
```

### Explanation:
- Uses `dmidecode` to extract BIOS/UEFI data directly from the DMI table.
- No modification is possible from userspace; this check is for visibility only.

---

## 2. GRUB2 Password Check

### Script: `grub2_password_check.sh`
```bash
#!/bin/bash

if grep -q password_pbkdf2 /etc/grub.d/40_custom 2>/dev/null; then
  echo "[PASS] GRUB2 password is configured."
else
  echo "[FAIL] GRUB2 password is NOT set in /etc/grub.d/40_custom."
fi
```

### Optional Password Setup (secure):
```bash
grub2-mkpasswd-pbkdf2
# Output should be manually inserted into 40_custom
```

### Explanation:
- Checks for the existence of `password_pbkdf2` directive.
- Ensures GRUB CLI cannot be accessed without authentication.

---

## 3. Secure Boot Verification

### Script: `secure_boot_check.sh`
```bash
#!/bin/bash

if [ -d /sys/firmware/efi ]; then
  echo "[INFO] UEFI mode detected."
  status=$(mokutil --sb-state 2>/dev/null | grep -i enabled)
  if [[ "$status" =~ "enabled" ]]; then
    echo "[PASS] Secure Boot is enabled."
  else
    echo "[FAIL] Secure Boot is NOT enabled."
  fi
else
  echo "[WARN] Legacy BIOS mode detected. Secure Boot is not applicable."
fi
```

### Explanation:
- Verifies whether the system is in UEFI mode.
- Uses `mokutil` to query Secure Boot status directly.

---

## Recommended Hardening
- Enable Secure Boot in firmware and verify MOK chain.
- Configure GRUB2 password with hashed PBKDF2.
- Restrict BIOS/UEFI access with admin password and boot order control.

---

## Output Summary (Example)
```
[INFO] BIOS Vendor and Version:
Vendor: American Megatrends
Version: 1.1.0
Release Date: 07/15/2023

[PASS] GRUB2 password is configured.
[PASS] Secure Boot is enabled.
```

---

## Layer Status: PASS/FAIL depends on all 3 checks above.
If any are missing or insecure, the result is FAIL.

---

## Note
This script assumes access to tools like `dmidecode`, `mokutil`, and `grub2-mkconfig`. These tools are typically preinstalled or available via package manager in RPM/DEB based systems. The audit does not alter any configuration — it strictly validates in read-only mode.

---

**Maintained by:** LinuxSFL Core Team  
**License:** MIT  
**Profile relevance:** All profiles (especially bastion-host, military-infrastructure, db-server)

