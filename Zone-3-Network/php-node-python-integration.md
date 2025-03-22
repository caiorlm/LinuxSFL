# Secure PHP, Node.js, and Python Integration - LinuxSFL 🐘🚀🐍

This document provides best practices for securely integrating PHP, Node.js, and Python applications with web servers, focusing on security, stability, and performance.

---

## ✅ **Integration Security Checklist:**

- Isolate applications using separate users and groups
- Run applications with least privileges
- Secure communication between app and web server
- Use secure configurations for PHP-FPM, Node.js PM2, and Python Gunicorn
- Regularly audit dependencies and libraries

---

## ⚙️ **Integration Configuration Examples:**

### 1. **Secure PHP Integration with PHP-FPM:**

Configure secure PHP-FPM pools (`www.conf`):
```ini
; /etc/php-fpm.d/www.conf
user = php-user
group = php-group
listen = /run/php-fpm/php-fpm.sock
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
pm = dynamic
pm.max_children = 50
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 15
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
```

### 2. **Secure Node.js Integration with PM2:**

Run Node.js applications securely with PM2:
```bash
# Install PM2 globally
npm install pm2 -g

# Start application securely
sudo -u node-user pm2 start app.js --name secure-node-app

# Auto-start PM2 on boot
sudo pm2 startup systemd -u node-user --hp /home/node-user
sudo pm2 save
```

### 3. **Secure Python Integration with Gunicorn and Systemd:**

Run Python applications securely behind Gunicorn:
```ini
# /etc/systemd/system/gunicorn.service
[Unit]
Description=Gunicorn instance for secure-python-app
After=network.target

[Service]
User=python-user
Group=python-group
WorkingDirectory=/var/www/secure-python-app
ExecStart=/usr/local/bin/gunicorn --workers 3 --bind unix:/var/www/secure-python-app/app.sock wsgi:app

[Install]
WantedBy=multi-user.target
```

---

## 🛠️ **Integration Verification Commands:**

Check PHP-FPM status:
```bash
sudo systemctl status php-fpm
```

Check Node.js app status with PM2:
```bash
sudo -u node-user pm2 status
```

Check Gunicorn status:
```bash
sudo systemctl status gunicorn
```

---

## 🔍 **Logging and Debugging:**

View PHP-FPM logs:
```bash
tail -f /var/log/php-fpm/error.log
```

View PM2 logs for Node.js:
```bash
sudo -u node-user pm2 logs secure-node-app
```

View Gunicorn logs (Python):
```bash
journalctl -u gunicorn -f
```

---

## 📌 **Recommended Best Practices:**

- Regularly update runtime environments (PHP, Node.js, Python).
- Automate dependency updates and vulnerability scans.
- Configure rate limiting and security headers at the web server.
- Perform regular backups and security audits.

---

*[Linux Security Framework Layer – Zone 3: Network]*
