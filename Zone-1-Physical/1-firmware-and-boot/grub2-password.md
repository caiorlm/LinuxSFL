# GRUB2 Password Protection - LinuxSFL 🔑

This document describes best practices to secure the GRUB2 bootloader by setting a password, preventing unauthorized users from editing boot parameters or accessing rescue modes.

## 🛡️ Setting GRUB2 Password:

1. **Generate Secure Password Hash**

Use `grub2-mkpasswd-pbkdf2` to generate a hashed password:

```bash
grub2-mkpasswd-pbkdf2
