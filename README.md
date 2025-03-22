# LinuxSFL – Linux Security Framework Layer

**LinuxSFL** is a modular, zone-based, open-source framework to audit, harden, and validate Linux infrastructures across all security layers — from firmware and kernel to authentication, firewall, monitoring, and critical services.

Designed to deliver structured compliance for environments like:
- Web, Database, DNS, Email, API, CI/CD servers
- Critical Infrastructures (Military, Nuclear, Government)
- Public Cloud (AWS, Azure, GCP), Containers, and Bare Metal

Its architecture is aligned with security standards including:
- **CISA**, **NIST 800-53**, **ISO/IEC 27001**, **PCI DSS**, **HIPAA**, **CMMC**, and **CIS Controls**.

---

## 🔰 Zones, Layers & Security Scope

LinuxSFL divides security checks into **3 core zones**:

| Zone | Scope                            | Example Layers                             |
|------|----------------------------------|--------------------------------------------|
| 1    | Physical / Firmware / Boot       | BIOS, GRUB2, Secure Boot, Kernel Modules   |
| 2    | Operational / System / Users     | Users, Access Control, Audit, Backup       |
| 3    | Network / Firewall / Monitoring  | Firewall, IDS, Logging, TLS, Redundancy    |

Each zone includes **up to 10 layers**, each with a corresponding Bash script responsible for checking security posture and returning a status: `PASS`, `FAIL`, `WARN`, or `N/A`.

---

## 🧩 Directory Structure (Audit Engine)

```
framework/
├── audit.sh                  # Main entrypoint
├── core/
│   ├── detect_environment.sh
│   ├── load_profile.sh
│   ├── run_zone.sh
│   ├── score_engine.sh
│   └── report_output.sh
├── profiles/
│   └── server_profiles.yaml   # Profile weights + required layers
├── logs/
│   └── zoneX/layerY.log       # Logs for each layer
├── reports/
│   └── final_report_DATE.txt
├── zone1/                     # Physical zone scripts
├── zone2/                     # Operational zone scripts
├── zone3/                     # Network zone scripts
```

---

## 📦 How It Works

### Step-by-Step Audit Flow:
1. `audit.sh` is executed
2. **detect_environment.sh** gathers distro, virtualization/container/cloud, init, package manager (APT/YUM/DNF)
3. User selects or passes the **server profile** (web-server, db-server, military, etc.)
4. The framework loads its profile from `server_profiles.yaml`, including:
   - Required standards (e.g. ISO 27001, PCI DSS)
   - Layer weights (e.g. firewall = 10, audit = 10)
   - Required configurations (e.g. auditd, TLS 1.2+, SSH hardened)
5. All layers per zone are executed sequentially
6. Results are scored, stored, and exported in `/reports` and `/logs`

### Sample Output:
```
ZONE 2 - SYSTEM / USERS / SERVICES
[✔] Layer 01 - User Management (OK) .............. 10/10
[✘] Layer 04 - OS Hardening (FAIL) ............... 0/10
    → Reason: /etc/sysctl.conf missing hardening flags
```

---

## 🧠 Dynamic Scoring Logic

- Each layer has a maximum **weight** defined by the selected profile
- Layers return:
  - ✔ PASS → Full weight
  - ✘ FAIL → Zero weight
  - ⚠ WARN → Partial weight
  - 🟡 N/A → Removed from total score (e.g. BIOS check inside Docker)
- Total score must reach **100%** per profile
- **Zero tolerance** for critical failures in mandatory layers

---

## 📊 Interactive CLI Interface (soon: `sfltop`)

Terminal-based dashboard for viewing zones, layers, scores, and logs:
```
┌────────────────────────────────────────────────────────┐
│ LINUXSFL - AUDIT VIEWER (Profile: military-infra)      │
├────────────────────────────────────────────────────────┤
│ Zone 1: PHYSICAL                                       │
│   [✔] Layer 01 - Inventory ................... 10/10   │
│   [✔] Layer 03 - Kernel Modules .............. 10/10   │
│                                                        │
│ Zone 2: SYSTEM                                         │
│   [✔] Layer 04 - Hardening ................... 10/10   │
│   [✘] Layer 08 - Backup ....................... 0/10   │
│     ↳ Press [Enter] to view failure log                │
└────────────────────────────────────────────────────────┘
```

Navigation:
- ↑↓ navigate between layers
- [Enter] open log
- [i] view standard (NIST/PCI/etc.)
- [q] quit viewer

---

## ✅ Profiles Included (examples)
- **web-server** → PCI DSS, OWASP, ISO 27001
- **db-server** → PCI DSS, ISO 27001, NIST 800-92
- **military-infrastructure** → CMMC, NIST 800-53 High, CISA
- **healthcare/hospital** → HIPAA, ISO 27799, NIST 800-66
- **cloud-hyperscaler** → ISO 27017, CSA CCM

Each profile defines per-layer **weight**, **mandatory checks**, and linked **compliance frameworks**.

---

## 🧱 Goals of LinuxSFL
- Modular, bash-only, extensible auditing system
- Transparent logs per zone/layer
- Real-time and post-audit visibility (interactive & static)
- Score enforcement per critical environment
- Profiles designed for **CISA-compliant** infrastructures

---

## 📜 License
MIT License — Free to use, fork, adapt, and contribute.

---

## 📡 Coming Soon
- CLI dashboard (`sfltop`) and auto-fix CLI options
- GitHub Actions integration for CI compliance
- Slack / Webhook notifications
- Ansible-compatible module structure

---

## 🔒 Final Insight
LinuxSFL is not just a checklist — it is a structured way to **control, harden, and validate security** layer-by-layer.

🧠 "Security is not binary — it is layered, modular, and must be visible."
