# GNU and Unix Basic Commands

## Overview
Understanding basic GNU and Unix commands is crucial for effective management, operation, and auditing of Linux systems. These commands facilitate everyday administrative tasks and system audits.

## Essential Commands

### File and Directory Management

- **List files and directories (`ls`)** *(list)*
```bash
ls -la # List all files (-a) including details (-l)
```

- **Change directory (`cd`)** *(change directory)*
```bash
cd /path/to/directory
```

- **Create a directory (`mkdir`)** *(make directory)*
```bash
mkdir directory_name
```

- **Remove files/directories (`rm`)** *(remove)*
```bash
rm file_name
rm -r directory_name # Remove recursively (-r)
```

- **Copy files/directories (`cp`)** *(copy)*
```bash
cp source destination
cp -r source_dir destination_dir # Copy recursively (-r)
```

- **Move or rename files/directories (`mv`)** *(move)*
```bash
mv old_name new_name
```

### Text Processing

- **View file contents (`cat`)** *(concatenate and display)*
```bash
cat file_name
```

- **Page through file contents (`less`, `more`)**
```bash
less file_name
more file_name
```

- **Search within files (`grep`)** *(global regular expression print)*
```bash
grep "pattern" file_name
```

- **Stream editing (`sed`)** *(stream editor)*
```bash
sed 's/old/new/g' file_name # Replace globally (g)
```

- **Pattern scanning and processing (`awk`)**
```bash
awk '{print $1}' file_name # Print first column
```

### File Permissions and Ownership

- **Change file permissions (`chmod`)** *(change mode)*
```bash
chmod 755 file_name # Read-write-execute owner, read-execute group and others
```

- **Change file ownership (`chown`)** *(change owner)*
```bash
chown user:group file_name
```

### Disk Usage and Filesystems

- **Check disk space (`df`)** *(disk free)*
```bash
df -h # Human-readable (-h)
```

- **Check disk usage by directory (`du`)** *(disk usage)*
```bash
du -sh /path/to/directory # Summary (-s), human-readable (-h)
```

### Process Management

- **List processes (`ps`)** *(process status)*
```bash
ps aux # List all processes
```

- **Terminate a process (`kill`)**
```bash
kill -9 PID # Force termination (-9)
```

- **Monitor system resources (`top`, `htop`)**
```bash
top
htop
```

### Archive and Compression

- **Create/extract tar.gz archives (`tar`)** *(tape archive)*
```bash
tar -czvf archive.tar.gz directory/ # Create compressed (c,z), verbose (v), file (f)
tar -xzvf archive.tar.gz # Extract (x), compressed (z), verbose (v), file (f)
```

- **Compress/uncompress files (`gzip`, `gunzip`)** *(GNU zip)*
```bash
gzip file_name
gunzip file_name.gz
```

### Disk and File Management Tools

- **Disk cloning (`dd`)** *(data duplicator)*
```bash
dd if=/source of=/destination bs=4M status=progress
# if=input file, of=output file, bs=block size
```

### File Synchronization and Backup

- **Remote and local file synchronization (`rsync`)** *(remote sync)*
```bash
rsync -avz source/ destination/
# archive mode (a), verbose (v), compressed (z)
rsync -avz user@remote_host:/path/source/ /local/destination/
```

### Networking Basics

- **Check network configuration (`ip`, `ifconfig`)** *(interface config)*
```bash
ip addr
ifconfig
```

- **Test connectivity (`ping`)** *(Packet Internet Groper)*
```bash
ping hostname
```

- **Trace packet routes (`traceroute`)**
```bash
traceroute hostname
```

- **Check open ports and connections (`netstat`)** *(network statistics)*
```bash
netstat -tulnp # TCP, UDP, Listening sockets, numerical addresses, processes
```

## Auditing Commands

- **File integrity checking (`md5sum`, `sha256sum`)**
```bash
md5sum file_name
sha256sum file_name
```

- **User login tracking (`last`, `w`, `who`)**
```bash
last # Show recent user logins
w # Display currently logged-in users and activity
who # List currently logged-in users
```

- **System and kernel messages (`dmesg`)** *(display message buffer)*
```bash
dmesg
```

## Recommendations
- Master basic command syntax and frequently used options.
- Use manual pages (`man command`) to explore further details.
- Regularly practice commands in a test environment to build fluency and confidence.

---

## References
- [GNU Coreutils Documentation](https://www.gnu.org/software/coreutils/manual/)
- [Linux Command Line Basics](https://linuxcommand.org/)

