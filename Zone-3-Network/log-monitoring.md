# Log Monitoring and Analysis - LinuxSFL 📊

This document describes best practices for effective log monitoring and analysis to detect suspicious activities and ensure the operational integrity and security of Linux systems.

---

## 📁 **Key Log Files to Monitor:**

Regularly inspect and analyze these critical log files:

| Log File                     | Description                                |
|------------------------------|--------------------------------------------|
| `/var/log/auth.log`          | Authentication attempts (Debian-based)     |
| `/var/log/secure`            | Authentication attempts (RHEL-based)       |
| `/var/log/messages`          | General system activities                  |
| `/var/log/syslog`            | System messages and daemons                |
| `/var/log/fail2ban.log`      | Fail2Ban intrusion detection activities    |
| `/var/log/audit/audit.log`   | System auditing logs                       |

---

## 🛠️ **Log Monitoring Tools and Commands:**

View logs in real-time:
```bash
sudo tail -f /var/log/auth.log
sudo tail -f /var/log/secure
```

Filter logs by keyword (e.g., failed SSH logins):
```bash
sudo grep "Failed password" /var/log/secure
```

Using `journalctl` to inspect logs (Systemd-based):
```bash
sudo journalctl -u sshd.service --since "1 hour ago"
```

---

## ⚙️ **Centralized Log Monitoring:**

For enhanced monitoring, consider using centralized log management solutions such as:

- **Elastic Stack (ELK):** Elasticsearch, Logstash, Kibana  
- **Graylog:** Centralized logging and analytics platform  
- **Splunk:** Comprehensive log analysis and monitoring  

These solutions provide:

- Centralized collection, indexing, and analysis of logs  
- Real-time dashboards and alerts  
- Historical data retention for compliance audits  

---

## 🔔 **Recommended Alerts and Notifications:**

Configure alerts based on patterns:

- Multiple authentication failures  
- Unauthorized sudo or root access  
- Unexpected system shutdowns/reboots  
- Changes to critical files and configurations  

---

## 📌 **Recommended Best Practices:**

- Regularly review log files and adjust alert thresholds based on your security policy.
- Ensure logs are rotated to manage disk space effectively (`logrotate`).
- Limit log file access strictly to authorized administrators.

---

*[Linux Security Framework Layer – Zone 3: Network]*
