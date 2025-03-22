# Apache Security Configuration - LinuxSFL 🌐🔐

This document provides recommended configurations and best practices for securely managing the Apache HTTP Server, enhancing security, performance, and reliability.

---

## ✅ **Essential Security Checklist for Apache:**

Implement these critical security steps:

- Disable Apache version exposure
- Limit HTTP methods
- Configure secure SSL/TLS protocols
- Enable HTTP security headers
- Secure directories and restrict access
- Set up ModSecurity firewall module (optional but recommended)

---

## ⚙️ **Apache Configuration Examples:**

### 1. **Hide Apache Server Version and OS Information:**
Prevent attackers from identifying server details.
```apache
# /etc/httpd/conf/httpd.conf or /etc/apache2/conf-enabled/security.conf
ServerTokens Prod
ServerSignature Off
```

### 2. **Restricting HTTP Methods:**
Allow only GET, POST, and HEAD methods to enhance security.
```apache
<Directory "/var/www/html">
    <LimitExcept GET POST HEAD>
        Require all denied
    </LimitExcept>
</Directory>
```

### 3. **Secure SSL/TLS Configuration:**
Enforce secure protocols and strong cipher suites.
```apache
<VirtualHost *:443>
    SSLEngine On
    SSLCertificateFile /path/to/fullchain.pem
    SSLCertificateKeyFile /path/to/privatekey.pem
    SSLProtocol -all +TLSv1.2 +TLSv1.3
    SSLCipherSuite HIGH:!aNULL:!MD5
    SSLHonorCipherOrder On
</VirtualHost>
```

### 4. **HTTP Security Headers:**
Reduce common web-based attacks with security headers.
```apache
<IfModule mod_headers.c>
    Header always set X-Frame-Options "SAMEORIGIN"
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "no-referrer-when-downgrade"
    Header always set Content-Security-Policy "default-src 'self';"
</IfModule>
```

### 5. **Directory and File Access Restrictions:**
Prevent access to sensitive files (.htaccess, .git, backups).
```apache
<DirectoryMatch "(\.git|\.svn|\.htaccess|backup|db)">
    Require all denied
</DirectoryMatch>
```

---

## 🛠️ **Useful Apache Commands:**

Reload Apache gracefully (no downtime):
```bash
sudo systemctl reload httpd    # RHEL-based
sudo systemctl reload apache2  # Debian-based
```

Test Apache configuration syntax:
```bash
sudo apachectl configtest
```

Check Apache status:
```bash
sudo systemctl status httpd    # RHEL-based
sudo systemctl status apache2  # Debian-based
```

View Apache logs:
```bash
sudo tail -f /var/log/httpd/error_log
sudo tail -f /var/log/apache2/error.log
```

---

## 📌 **Recommended Best Practices:**

- Regularly update Apache and OpenSSL.
- Automate SSL certificate renewals with Certbot.
- Deploy ModSecurity Web Application Firewall (WAF).
- Periodically review security settings and monitor logs for unusual activity.
- Document and backup all configuration files systematically.

---

*[Linux Security Framework Layer – Zone 3: Network]*
