# GRUB2 Password Protection - LinuxSFL 🔑

This document describes best practices to secure the GRUB2 bootloader by setting a password, preventing unauthorized users from editing boot parameters or accessing rescue modes.

## 🛡️ Setting GRUB2 Password:

1. **Generate Secure Password Hash**

Use `grub2-mkpasswd-pbkdf2` to generate a hashed password:

```bash
grub2-mkpasswd-pbkdf2

Example output:
  Enter password:
  Reenter password:
  PBKDF2 hash of your password is grub.pbkdf2.sha512.10000.ABC123...
  

Configure GRUB2 with Password
  Edit /etc/grub.d/40_custom or /etc/grub.d/01_users and add:

set superusers="admin"
  password_pbkdf2 admin grub.pbkdf2.sha512.10000.ABC123...

Replace the hash with your generated value.
  grub2-mkconfig -o /boot/grub2/grub.cfg
(Location may vary depending on distribution)

Recommendations:
Use strong, unique passwords.
Limit knowledge of GRUB password strictly to authorized administrators.
Monitor /boot/grub2/grub.cfg permissions and audit regularly.
[Linux Security Framework Layer – Zone 1: Physical]
