# 🔑 GRUB2 Password Protection - LinuxSFL

**[Linux Security Framework Layer – Zone 1: Physical]**

This document provides recommended security practices for protecting the **GRUB2** bootloader by configuring password protection. This approach prevents unauthorized users from editing boot parameters or gaining access to rescue and recovery modes.

---

## 🛡️ Setting Up GRUB2 Password

### Step 1: 🔑 Generate Secure Password Hash

Use the command `grub2-mkpasswd-pbkdf2` to create a strong hashed password:

```bash
grub2-mkpasswd-pbkdf2
```

**Example output:**

```bash
Enter password:
Reenter password:
PBKDF2 hash of your password is grub.pbkdf2.sha512.10000.ABC123...
```

*Note*: Store the generated hash securely for the next step.

---

### Step 2: ⚙️ Configure GRUB2 with Password

Edit the GRUB2 custom configuration file:

- `/etc/grub.d/40_custom` *(recommended)*
- Alternatively, `/etc/grub.d/01_users`

Insert the following lines, replacing `admin` and the hash (`grub.pbkdf2.sha512.10000.ABC123...`) with your administrator username and the previously generated password hash:

```bash
set superusers="admin"
password_pbkdf2 admin grub.pbkdf2.sha512.10000.ABC123...
```

After updating, regenerate the GRUB2 configuration file:

```bash
grub2-mkconfig -o /boot/grub2/grub.cfg
```

*Note*: The path may vary depending on your Linux distribution (e.g., `/boot/efi/EFI/<distribution>/grub.cfg` for UEFI systems).

---

## ✅ Recommendations & Best Practices

- **Strong Passwords**: Always use strong, unique passwords for GRUB2.
- **Restrict Access**: Limit GRUB password knowledge strictly to authorized system administrators.
- **Audit Regularly**: Regularly review permissions on `/boot/grub2/grub.cfg` and associated configuration files.

---

**[Linux Security Framework Layer – Zone 1: Physical]**
