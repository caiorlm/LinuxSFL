# 🔒 Secure Boot Configuration - LinuxSFL

**[Linux Security Framework Layer – Zone 1: Physical]**

This document describes best practices for securely configuring **UEFI Secure Boot**, ensuring that only authenticated operating system kernels and bootloaders execute, effectively reducing risks from rootkits or malicious boot code.

---

## 🔐 Enabling Secure Boot

### 1. ✅ Check Compatibility

- Ensure your hardware (motherboard) and operating system fully support **UEFI Secure Boot**.

---

### 2. ✅ Enable UEFI Secure Boot

- Reboot the machine and access the BIOS/UEFI firmware interface.
- Locate the **Secure Boot** settings.
- Set **Secure Boot** to `Enabled`.
- Choose the boot mode:
  - **Standard Mode** (recommended for most users)
  - **Custom Mode** (for advanced management with your own keys)

---

### 3. ✅ Signing Bootloaders and Kernels (Custom Mode)

- Generate or import your own keys:
  - **Platform Key (PK)**
  - **Key Exchange Key (KEK)**
  - **Signature Database Keys (db)**

- Utilize utilities such as `efibootmgr`, `mokutil`, or your distribution-specific tools to enroll keys securely.

**Example with `mokutil`:**

```bash
mokutil --import public_key.der
```

- After running this command, reboot the system and follow the on-screen instructions to enroll your keys.

---

## 🔍 Verification and Testing

- **Verify Secure Boot status** on Linux by running:

```bash
mokutil --sb-state
```

- Alternatively, inspect kernel logs to confirm Secure Boot activity:

```bash
dmesg | grep Secure
```

---

## 📌 Best Practices:

- ✅ Maintain control and detailed documentation of all enrolled keys.
- ✅ Regularly update keys and immediately revoke any that are compromised.
- ✅ Conduct periodic audits of key management procedures and secure storage of keys.

---

**[Linux Security Framework Layer – Zone 1: Physical]**
