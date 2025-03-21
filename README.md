LinuxSFL – Linux Security Framework Layer

### 📁 `LinuxSFL/`
```plaintext
├── Zone-1-Physical/
│   └── 1-firmware-and-boot/
│       ├── bios-configuration.md
│           → Technology: BIOS/UEFI firmware settings  
│           → Barrier: Prevents physical or boot-level tampering  
│           → ⚠️ If no password is set, physical access allows full override  

│       ├── grub2-password.md
│           → Technology: GRUB2 bootloader protection  
│           → Barrier: Blocks boot menu edits, kernel parameter changes  
│           → ⚠️ Without password, a user can boot into single-user mode  

│       └── secure-boot.md
│           → Technology: UEFI Secure Boot + MOK (Machine Owner Key)  
│           → Barrier: Prevents unauthorized kernel or driver injection  
│           → ⚠️ Misconfigured systems may fail to boot after kernel update  

├── Zone-2-Operational/
│   ├── 2-kernel-and-init/
│   │   ├── kernel-parameters.md
│   │       → Technology: sysctl, /proc, runtime kernel tuning  
│   │       → Barrier: Reduces attack surfaces (e.g., IP forwarding, core dumps)  
│   │       → ⚠️ Improper settings may disrupt network or services  

│   │   ├── systemd-services.md
│   │       → Technology: systemd unit hardening, service sandboxing  
│   │       → Barrier: Isolates services to reduce lateral privilege escalation  
│   │       → ⚠️ Over-restriction may break application startup  

│   │   └── tuning-cgroups-namespaces.md
│           → Technology: cgroups, namespaces  
│           → Barrier: Limits resource abuse and process visibility  
│           → ⚠️ Improper namespace isolation may leave kernel attack paths open  

│   ├── 3-authentication-and-root/
│   │   ├── root-permissions.md
│   │       → Technology: SSH config, UID 0 scan  
│   │       → Barrier: Prevents direct root access  
│   │       → ⚠️ Root login via SSH = remote full control risk  

│   │   ├── sudoers-and-least-privilege.md
│   │       → Technology: /etc/sudoers, visudo  
│   │       → Barrier: Ensures minimal command scope per admin  
│   │       → ⚠️ Misconfigured sudo = privilege escalation loophole  

│   │   └── users-and-groups.md
│   │       → Technology: /etc/passwd, /etc/group, usermod/usermgmt  
│   │       → Barrier: Separates access roles cleanly  
│   │       → ⚠️ Overlapping group permissions = unintended access  

│   └── 4-mandatory-access-control/
│       ├── selinux-basics.md
│           → Technology: SELinux enforcing + targeted policy  
│           → Barrier: Blocks unauthorized file and process access  
│           → ⚠️ Can block legitimate services if not tuned properly  

│       ├── selinux-advanced-policies.md
│           → Technology: Custom SELinux modules and contexts  
│           → Barrier: Micro-controls on app behavior  
│           → ⚠️ Complex to maintain and troubleshoot  

│       └── apparmor-examples.md
│           → Technology: AppArmor profiles  
│           → Barrier: Profile-based restrictions per binary  
│           → ⚠️ Limited compared to SELinux in multi-role systems  

├── Zone-3-Network/
│   ├── 5-firewall-and-monitoring/
│   │   ├── firewalld-configuration.md
│   │       → Technology: firewalld zones and rich rules  
│   │       → Barrier: Network-level segmentation and filtering  
│   │       → ⚠️ If disabled, server is fully exposed  

│   │   ├── iptables-nftables.md
│   │       → Technology: iptables (legacy) and nftables (modern)  
│   │       → Barrier: Fine-grained packet filtering  
│   │       → ⚠️ Conflicting rule sets = unexpected traffic drops  

│   │   ├── fail2ban-setup.md
│   │       → Technology: Fail2Ban with log parsing  
│   │       → Barrier: Blocks brute-force and login attempts  
│   │       → ⚠️ Weak regex filters may miss attacker patterns  

│   │   └── log-monitoring.md
│   │       → Technology: journalctl, auditd, grep, fail2ban logs  
│   │       → Barrier: Enables real-time alerting and forensics  
│   │       → ⚠️ Lack of log rotation = disk flooding  

│
│   └── 6-web-servers-and-services/
│       ├── nginx-configuration.md
│           → Technology: NGINX reverse proxy  
│           → Barrier: Filters requests, adds TLS, protects backends  
│           → ⚠️ Misconfigured headers = proxy leaks  

│       ├── apache-example.md
│           → Technology: Apache HTTPD  
│           → Barrier: Layered config per directory  
│           → ⚠️ .htaccess overrides can be dangerous if misused  

│       ├── php-node-python-integration.md
│           → Technology: FPM, systemd, socket units  
│           → Barrier: Handles dynamic apps securely  
│           → ⚠️ Poor isolation = script injection risk  

│       └── reverse-proxy-and-tls.md
│           → Technology: Certbot, OpenSSL, proxy_pass  
│           → Barrier: Encrypts communication & hides internal topology  
│           → ⚠️ Expired TLS certs can bring full downtime  

├── Transversal-Architecture-Documentation/
│   └── 7-architecture-and-documentation/
│       ├── architecture-tree.md
│           → Technology: Graphical view of LinuxSFL security tree  
│           → Barrier: Helps identify weak spots in system layers  
│           → ⚠️ Only helpful if kept up to date  

│       ├── mindmap.png
│           → Technology: Visual layout of framework logic  
│           → Barrier: Shows zone/cross-zone dependencies  
│           → ⚠️ Needs to reflect any added features  

│       └── full-setup.md
│           → Technology: Full deployment playbook  
│           → Barrier: Standardized secure-by-default setup  
│           → ⚠️ Customization required per environment  

├── README.md
└── LICENSE
```

---

## ✅ Summary: Zone & Layer Mapping

| Zone                 | Layer No. | Layer Name                    | Focus Area                         |
|----------------------|-----------|--------------------------------|-------------------------------------|
| **Zone 1 – Physical**     | Layer 1   | Firmware and Boot              | UEFI, GRUB2, Secure Boot             |
| **Zone 2 – Operational**  | Layer 2   | Kernel and Init                | sysctl, systemd, cgroups             |
|                          | Layer 3   | Authentication & Root          | SSH, sudo, user/groups              |
|                          | Layer 4   | Mandatory Access Control       | SELinux, AppArmor                   |
| **Zone 3 – Network**      | Layer 5   | Firewall and Monitoring        | firewalld, iptables, fail2ban       |
|                          | Layer 6   | Web Servers & Services         | nginx, apache, reverse proxy        |
| **Cross-Zone**           | Layer 7   | Architecture & Documentation   | Diagrams, audit maps, setup guide   |

Perfeito! Abaixo está a estrutura do projeto **LinuxSFL**, agora com **as únicas vulnerabilidades em destaque por zona**, ou seja:

🔐 **Cada Zona** traz:
- ✅ As tecnologias implementadas
- 🛡️ A principal barreira de segurança criada
- ⚠️ **A única vulnerabilidade possível** restante, assumindo que **tudo foi corretamente configurado** exceto um único ponto crítico **por camada ou zona**

---

## 🔰 **LinuxSFL – Highlighting the Single Remaining Vulnerability per Zone**

### 🟫 **Zone 1 – Physical**

📁 `1-firmware-and-boot/`

| File                    | Technology                 | Barrier                            | ⚠️ Unique Remaining Risk                         |
|-------------------------|----------------------------|-------------------------------------|--------------------------------------------------|
| `bios-configuration.md` | BIOS/UEFI password         | Prevents physical tampering         | **An attacker with physical access can reset CMOS** to clear passwords. |
| `grub2-password.md`     | GRUB2 user/pass config     | Prevents boot-time kernel edits     | **If GRUB is not set to `superuser`, attacker can still drop to command line.** |
| `secure-boot.md`        | UEFI Secure Boot (mokutil) | Blocks unsigned kernel/drivers      | **If MOK is not password-protected, it may be bypassed with physical access.**

🟡 **Zone 1 – Vulnerability Summary:**  
**Physical access + reset hardware (CMOS or boot device) allows bypass of bootloader protections.**  
Even when everything is configured properly, physical tampering is still the final weak point.

---

### 🟦 **Zone 2 – Operational**

📁 Includes:
- `2-kernel-and-init/`
- `3-authentication-and-root/`
- `4-mandatory-access-control/`

| Layer | Technology                     | Barrier                                        | ⚠️ Unique Remaining Risk |
|--------|----------------------------------|------------------------------------------------|---------------------------|
| Kernel & Init        | `sysctl`, systemd, cgroups        | Controls resources, isolates processes         | **A misconfigured kernel module (e.g. `usb-storage`) may allow physical injection if not blacklisted.** |
| Authentication & Root | SSH config, sudoers, user perms   | Blocks privilege escalation                    | **If a legacy user still has UID 0, they bypass sudo policies silently.** |
| Mandatory Access Control | SELinux / AppArmor              | Blocks unauthorized process/file access        | **If SELinux is in permissive mode, logs are written but no action is taken.**

🟡 **Zone 2 – Vulnerability Summary:**  
**A leftover UID 0 user or permissive SELinux renders protections ineffective**, even if everything else is hardened.

---

### 🟩 **Zone 3 – Network**

📁 Includes:
- `5-firewall-and-monitoring/`
- `6-web-servers-and-services/`

| Layer | Technology                      | Barrier                                  | ⚠️ Unique Remaining Risk |
|--------|-----------------------------------|-------------------------------------------|---------------------------|
| Firewall & Monitoring | firewalld, iptables, fail2ban        | Prevents external scans & brute force     | **If port 22 is open and Fail2Ban regex is weak, SSH brute-force can still succeed.** |
| Web Services          | NGINX, Apache, PHP, reverse proxy   | Filters input, secures backend traffic    | **If TLS certs expire and auto-renew fails, fallback to HTTP leaves system exposed.**

🟢 **Zone 3 – Vulnerability Summary:**  
**A missed brute-force pattern or expired TLS certificate can silently disable network trust layers**, exposing public services.



## ✅ Final Summary: *Most Likely Residual Vulnerability per Zone (Even if Fully Hardened)*

| Zone   | Most Critical Residual Risk (After Hardening)                                   |
|--------|----------------------------------------------------------------------------------|
| 🟫 Zone 1 | **CMOS reset or boot device override**, bypassing firmware and bootloader     |
| 🟦 Zone 2 | **UID 0 backdoor user** or **SELinux in permissive mode**, silently disabling controls |
| 🟩 Zone 3 | **Open port with weak Fail2Ban pattern**, or **expired TLS with fallback to HTTP** |


