# Zone 2 – Layer 03: Authentication and Root Access (Low-Level Bash)

## Objective
Ensure secure root access and authentication configurations are enforced, preventing unauthorized privilege escalation and weak authentication vectors.

## Key Checks
- Root login restriction in SSH
- Password authentication status
- Existing UID 0 accounts
- Sudoers configuration integrity

---

## 1. SSH Root Login Restriction

### Script: `ssh_root_login_check.sh`
```bash
#!/bin/bash

config="/etc/ssh/sshd_config"

if grep -qEi '^PermitRootLogin\s+no' "$config"; then
  echo "[PASS] Root login via SSH is disabled."
else
  echo "[FAIL] Root login via SSH is enabled or not explicitly disabled."
fi
```

### Explanation:
- Enforces `PermitRootLogin no` in `sshd_config`
- Prevents direct remote root access

---

## 2. Password Authentication Status

### Script: `ssh_password_auth_check.sh`
```bash
#!/bin/bash

config="/etc/ssh/sshd_config"

if grep -qEi '^PasswordAuthentication\s+no' "$config"; then
  echo "[PASS] Password authentication is disabled."
else
  echo "[WARN] Password authentication is enabled. Key-based login recommended."
fi
```

### Explanation:
- Promotes secure key-based authentication
- Helps harden against brute-force attacks

---

## 3. UID 0 Account Enumeration

### Script: `uid_zero_check.sh`
```bash
#!/bin/bash

echo "[INFO] Listing all accounts with UID 0:"
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

### Explanation:
- Only `root` should have UID 0
- Any other account indicates potential backdoor or misconfiguration

---

## 4. Sudoers File Check

### Script: `sudoers_integrity_check.sh`
```bash
#!/bin/bash

file="/etc/sudoers"

if grep -q '^root\s\+ALL=(ALL)' "$file"; then
  echo "[PASS] Sudoers file has default root configuration."
else
  echo "[FAIL] Sudoers root entry is missing or altered."
fi

if visudo -c >/dev/null 2>&1; then
  echo "[PASS] Sudoers syntax is valid."
else
  echo "[FAIL] Sudoers file has syntax errors."
fi
```

### Explanation:
- Checks presence and integrity of `root` sudo permissions
- Validates syntax via `visudo -c`

---

## Recommended Hardening
- Disable remote root login (`PermitRootLogin no`)
- Disable password auth (`PasswordAuthentication no`)
- Ensure no unauthorized UID 0 users exist
- Restrict sudo access with least privilege

---

## Output Sample
```
[PASS] Root login via SSH is disabled.
[WARN] Password authentication is enabled.
[INFO] UID 0 accounts: root
[PASS] Sudoers file has default root configuration.
[PASS] Sudoers syntax is valid.
```

---

## Layer Status
PASS if:
- Root SSH login is blocked
- No unknown UID 0 users
- Sudoers is valid and default root entry exists

FAIL if:
- Any insecure default remains (e.g. root SSH access, weak password access, etc.)

---

**Maintained by:** LinuxSFL Core Team  
**License:** MIT  
**Profile relevance:** All profiles (especially bastion-host, db-server, cloud-hyperscaler)

