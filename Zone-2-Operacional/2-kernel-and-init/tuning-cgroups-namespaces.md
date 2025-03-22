📄 **`tuning-cgroups-namespaces.md`**

# Cgroups and Namespaces Tuning - LinuxSFL 🚀

This document covers best practices for configuring and optimizing **Control Groups (cgroups)** and **Namespaces** to enhance security, isolation, and optimal performance on Linux systems.

---

## 📌 What are Cgroups and Namespaces?

- **Cgroups (Control Groups)** enable granular control over system resources such as CPU, memory, and I/O for individual processes or process groups.
- **Namespaces** provide system-level isolation, allowing processes to run in isolated environments as if they were running on separate machines.

---

## 🚦 Tuning Cgroups

### 🔹 Install Required Tools:

```bash
sudo dnf install libcgroup libcgroup-tools
```

### 🔹 Create a Basic Cgroup Configuration:

```bash
sudo mkdir /sys/fs/cgroup/my_cgroup
echo 512M | sudo tee /sys/fs/cgroup/my_cgroup/memory.max
echo 50 | sudo tee /sys/fs/cgroup/my_cgroup/cpu.max
```

*(Replace values according to your specific resource allocation requirements.)*

### 🔹 Assigning Processes to Cgroups:

```bash
sudo cgclassify -g memory,cpu:my_cgroup <pid>
```

Replace `<pid>` with your target process ID.

---

## 🌐 Configuring Namespaces

### 🔹 Create and Use Namespaces:

- Run a shell inside a new isolated namespace:

```bash
sudo unshare --pid --mount --uts --net --fork /bin/bash
```

- Parameters explained:
  - `--pid`: New PID namespace
  - `--mount`: Isolated mount points
  - `--uts`: Separate hostname and domain
  - `--net`: Network isolation
  - `--fork`: Fork the command execution

---

## ✅ Best Practices:

- Regularly monitor resource utilization and adjust limits based on workload.
- Document each namespace and cgroup configuration thoroughly.
- Ensure proper isolation by reviewing and testing configurations periodically.

---

*[Linux Security Framework Layer – Zone 2: Operational]*
