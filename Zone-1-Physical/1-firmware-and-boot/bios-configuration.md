
# BIOS Configuration - LinuxSFL 🔐

This document provides guidelines for securely configuring BIOS settings, helping to protect the hardware and operating system against physical and virtual threats.

## 🔑 Recommended BIOS Security Settings:

1. **Set Supervisor/Admin Password**
   - Define a strong, unique BIOS admin password to prevent unauthorized modifications.
   - Document the password securely offline.

2. **Disable Unused Hardware**
   - Turn off hardware interfaces such as unused USB ports, serial ports, and parallel ports to reduce attack surfaces.

3. **Configure Boot Order**
   - Limit boot devices strictly to your OS drive.
   - Disable boot from external media (USB, CD/DVD, network boot), unless explicitly required.

4. **Enable BIOS-Level Protection Features**
   - Activate features like Execute Disable Bit (NX/XD bit) to protect against certain malware attacks.
   - Enable Intel VT-x or AMD-V for virtualization security if required.

5. **BIOS Updates**
   - Regularly update BIOS firmware to patch security vulnerabilities.
   - Verify authenticity and integrity of updates provided by the motherboard manufacturer.

## ⚠️ Precautions:

- Always document and securely store BIOS configurations.
- Regularly audit BIOS settings to detect unauthorized changes.
- Periodically test BIOS backup/restore procedures.

---

*[Linux Security Framework Layer – Zone 1: Physical]*
