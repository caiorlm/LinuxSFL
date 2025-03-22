# LinuxSFL – Linux Security Framework Layer

LinuxSFL is a modular, zone-based, open-source framework to audit, harden, and validate Linux infrastructures across all security layers — from firmware and kernel to authentication, firewall, monitoring, and critical services.

Designed to deliver structured compliance for environments such as:
- Web, Database, DNS, Email, API, CI/CD servers
- Critical Infrastructures (Military, Nuclear, Government)
- Public Cloud (AWS, Azure, GCP), Containers, and Bare Metal

Its architecture aligns with widely adopted security standards, including:
- CISA, NIST 800-53, ISO/IEC 27001, PCI DSS, HIPAA, CMMC, and CIS Controls

---

## Zones, Layers, and Security Scope

LinuxSFL divides security validation into three primary zones:

| Zone | Scope                            | Example Layers                             |
|------|----------------------------------|--------------------------------------------|
| 1    | Physical / Firmware / Boot       | BIOS, GRUB2, Secure Boot, Kernel Modules   |
| 2    | Operational / System / Users     | Users, Access Control, Audit, Backup       |
| 3    | Network / Firewall / Monitoring  | Firewall, IDS, Logging, TLS, Redundancy    |

Each zone contains up to 10 layers. Each layer is implemented through a Bash script responsible for performing a specific security validation and returning one of the following states:
- PASS
- FAIL
- WARN
- N/A

---

## Directory Structure

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
│   └── server_profiles.yaml   # Server profile definitions and layer weights
├── logs/
│   └── zoneX/layerY.log       # Per-layer logs
├── reports/
│   └── final_report_DATE.txt
├── zone1/                     # Physical validation scripts
├── zone2/                     # Operational validation scripts
├── zone3/                     # Network validation scripts
```

---

## How It Works

1. `audit.sh` is executed.
2. `detect_environment.sh` identifies:
   - OS distribution, init system, virtualization/cloud/container context
   - Available package manager (APT/YUM/DNF)
3. User selects or passes the target server profile (e.g. web-server, db-server).
4. The framework loads the server profile from `server_profiles.yaml`, which includes:
   - Required compliance standards (e.g., ISO 27001, PCI DSS)
   - Layer weights (e.g., firewall = 10, logging = 10)
   - Minimum technical conditions (e.g., auditd enabled, SSH hardened)
5. All applicable zone layers are executed.
6. Logs are generated and stored; scores are calculated.

### Example Output
```
ZONE 2 - SYSTEM / USERS / SERVICES
[PASS] Layer 01 - User Management .......... 10/10
[FAIL] Layer 04 - OS Hardening ............. 0/10
  Reason: /etc/sysctl.conf missing hardening flags
```

---

## Scoring Logic

- Each layer receives a weight from the server profile.
- Scoring behavior:
  - PASS: full weight
  - FAIL: zero points
  - WARN: partial points (optional implementation)
  - N/A: excluded from denominator
- 100% total score is required to pass a profile.
- Any failure on mandatory layers causes the profile to fail.

---

## CLI Interface (Planned: `sfltop`)

Terminal-based viewer to navigate audit results:
```
[Profile: military-infrastructure]
Zone 1: PHYSICAL
  [PASS] Layer 01 - Inventory .......... 10/10
  [PASS] Layer 03 - Kernel Security .... 10/10

Zone 2: SYSTEM
  [PASS] Layer 04 - OS Hardening ....... 10/10
  [FAIL] Layer 08 - Backup ............. 0/10
    ↳ Press [Enter] to view layer log
```
Navigation Keys:
- Arrow keys: move between zones/layers
- [Enter]: view logs
- [i]: show compliance standards
- [q]: quit viewer

---

## Included Server Profiles (Examples)
- web-server → PCI DSS, OWASP, ISO 27001
- db-server → PCI DSS, ISO 27001, NIST 800-92
- military-infrastructure → CMMC, NIST 800-53 High, CISA
- healthcare → HIPAA, ISO 27799, NIST 800-66
- cloud-hyperscaler → ISO 27017, CSA CCM

Profiles include per-layer weights, compliance bindings, and operational conditions.

---

## Objectives

- Bash-only, modular, auditable framework
- Supports bare metal, VM, container, and cloud deployments
- Real-time logging and compliance reporting
- Hardening coverage mapped to zones/layers
- Independent of external dependencies
- Designed to meet CISA-level audit expectations

---

## License
MIT License — fully open, free to adapt, extend, and contribute.

---

## Roadmap
- Terminal-based audit dashboard (`sfltop`)
- Optional remediation scripting (`auto-fix.sh`)
- CI/CD integration with GitHub Actions
- Slack and webhook integration for alerts
- Ansible-compatible hardening roles

---

## Final Notes
LinuxSFL is designed for accuracy, clarity, and operational hardening — not just compliance.

Security is not achieved by checklists. It is built through continuous validation, modular control, and real-world testing.
