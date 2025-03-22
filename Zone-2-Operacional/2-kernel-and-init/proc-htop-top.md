---

# 📁 **Understanding `/proc` Filesystem and System Monitoring Tools (`htop` & `top`) – LinuxSFL**

**Zone 2: Operational**

This document explains the interaction of the **`/proc` filesystem** with key Linux monitoring tools (**`top`** and **`htop`**), their usage, differences, and recommendations for operational monitoring and troubleshooting.

---

## 📂 **1. The `/proc` Filesystem**

The `/proc` filesystem is a virtual filesystem provided by the Linux kernel. It acts as a dynamic interface for kernel data structures, processes, and hardware statistics.

### 📌 **Important Characteristics:**

- Located at `/proc`.
- Does not contain actual files; rather, it exposes runtime kernel data.
- Provides detailed information about running processes and system resources.

### 📋 **Common `/proc` Directories and Files:**

| Path                         | Description                                          |
|------------------------------|------------------------------------------------------|
| `/proc/[PID]`                | Directory containing info for a specific process     |
| `/proc/cpuinfo`              | CPU architecture and specs                           |
| `/proc/meminfo`              | RAM and memory usage                                 |
| `/proc/loadavg`              | System load averages                                 |
| `/proc/uptime`               | System uptime since last reboot                      |
| `/proc/stat`                 | CPU usage statistics                                 |
| `/proc/version`              | Kernel version details                               |
| `/proc/net/`                 | Network-related information (sockets, connections)   |

### ⚙️ **Examples of Accessing `/proc`:**

- Checking memory usage:
```bash
cat /proc/meminfo
```

- Viewing detailed CPU info:
```bash
cat /proc/cpuinfo
```

- Checking a process’s status:
```bash
cat /proc/[PID]/status
```

---

## 🖥️ **2. Using `top` for System Monitoring**

**`top`** provides real-time monitoring of running processes, CPU load, memory utilization, and overall system health. It reads its information directly from `/proc`.

### 🚀 **Starting `top`:**
```bash
top
```

### 🛠️ **Basic Usage and Shortcuts in `top`:**
- `h`: Display help screen
- `q`: Quit `top`
- `k`: Kill a process (by entering its PID)
- `M`: Sort by memory usage
- `P`: Sort by CPU usage
- `u`: Show processes of a specific user

### 📌 **When to Use `top`:**
- For quick, simple monitoring of server resource utilization.
- Quick identification of resource-heavy processes.

---

## 🎛️ **3. Enhanced Monitoring with `htop`**

**`htop`** is an advanced, user-friendly alternative to `top`. It provides better visual representation, intuitive interactions, and colorized output.

### ✅ **Installing `htop`:**
```bash
sudo apt install htop       # Debian/Ubuntu
sudo yum install htop       # RHEL/CentOS/Rocky Linux
sudo dnf install htop       # Fedora/RHEL 8+
```

### 🚀 **Starting `htop`:**
```bash
htop
```

### 🛠️ **Common Shortcuts in `htop`:**
- `F3`: Search processes by name
- `F4`: Filter by keyword
- `F5`: Toggle tree-view of processes
- `F6`: Sort processes (by CPU, memory, etc.)
- `F9`: Kill selected process
- Arrow keys: Navigate through processes
- `Space`: Tag a process (for batch operations)
- `q`: Quit

### 📌 **When to Use `htop`:**
- Detailed analysis of system load and process relationships.
- Quick filtering and easy process management.
- Interactive monitoring and troubleshooting.

---

## 🆚 **Comparison Table: `/proc`, `top`, and `htop`**

| Feature             | `/proc` filesystem    | `top`                | `htop`                        |
|---------------------|-----------------------|----------------------|-------------------------------|
| Real-time monitoring| ✅ (manual reading)  | ✅ (automatic update)| ✅ (automatic & user-friendly)|
| User Interface      | ❌ (text-based)      | ⚠️ (simple text UI) | ✅ (enhanced, intuitive UI)   |
| Process management  | ⚠️ (manual via files)| ⚠️ (limited)         | ✅ (advanced, easy shortcuts) |
| Customization       | ❌                   | ⚠️ (limited)         | ✅ (highly customizable)      |
| Quick visibility    | ❌                   | ✅                   | ✅✅ (high visibility)        |

---

## 🔎 **How `top` and `htop` Interact with `/proc`**

Both tools continuously query files under `/proc` to retrieve information such as CPU load (`/proc/stat`), memory statistics (`/proc/meminfo`), and per-process details (`/proc/[PID]/status`, `/proc/[PID]/stat`). They format and display this data in an easy-to-understand, interactive format.

### 🗂️ **Example of process information source:**
```bash
cat /proc/$(pidof sshd)/status
```

This will display detailed information about the SSH daemon process, similar to what `top` and `htop` represent visually.

---

## 🔑 **Best Practices:**

- **Use `/proc` filesystem directly** for scripts or automated monitoring solutions.
- **Use `top`** for quick checks or basic monitoring tasks.
- **Prefer `htop`** for interactive troubleshooting, detailed visibility, and intuitive process management.

---

## 🚩 **Summary & Quick Commands**

**Quick `/proc` checks:**
```bash
cat /proc/loadavg
cat /proc/meminfo
cat /proc/cpuinfo
```

**Start monitoring tools:**
```bash
top
htop
```

**Interactive process management (`htop`):**
- Search: `F3`
- Sort processes: `F6`
- Kill process: `F9`

---

*Documented as part of Linux Security Framework Layer – Zone 2: Operational.*
