# Nginx Security Configuration - LinuxSFL 🌐🔒

This document outlines best practices for securely configuring the Nginx web server to ensure robust performance, security, and stability.

---

## ✅ **Basic Security Checklist for Nginx:**

Ensure these key practices are implemented:

- Disable unnecessary modules
- Hide Nginx server version
- Configure secure SSL/TLS settings
- Restrict HTTP methods
- Enable HTTP Security Headers
- Implement rate-limiting and request filtering

---

## ⚙️ **Nginx Configuration Examples:**

### 1. **Hide Nginx Server Tokens:**
Prevent attackers from seeing Nginx version details.
```bash
# /etc/nginx/nginx.conf
http {
    server_tokens off;
}
```

### 2. **Secure SSL/TLS Configuration:**
Ensure modern cipher suites and disable older protocols.
```nginx
server {
    listen 443 ssl;
    ssl_certificate /path/to/your/fullchain.pem;
    ssl_certificate_key /path/to/your/privatekey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-AES256-GCM-SHA384';
}
```

### 3. **HTTP Security Headers:**
Protect against common web vulnerabilities.
```nginx
server {
    add_header X-Content-Type-Options "nosniff";
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header Referrer-Policy "no-referrer-when-downgrade";
    add_header Content-Security-Policy "default-src 'self';";
}
```

### 4. **Restricting HTTP Methods:**
Allow only necessary HTTP methods (e.g., GET, POST).
```nginx
server {
    if ($request_method !~ ^(GET|POST)$) {
        return 444;
    }
}
```

### 5. **Rate Limiting:**
Protect against brute force and DoS attacks.
```nginx
http {
    limit_req_zone $binary_remote_addr zone=one:10m rate=5r/s;

    server {
        location / {
            limit_req zone=one burst=10 nodelay;
        }
    }
}
```

---

## 🛠️ **Useful Nginx Commands:**

Reload Nginx without downtime:
```bash
sudo nginx -s reload
```

Test Nginx configuration syntax:
```bash
sudo nginx -t
```

Check Nginx status:
```bash
sudo systemctl status nginx
```

View Nginx logs:
```bash
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```

---

## 📌 **Recommended Best Practices:**

- Regularly update Nginx and OpenSSL.
- Automate SSL certificate renewal using Let's Encrypt and Certbot.
- Periodically audit security configurations and logs.
- Document and backup configuration files systematically.

---

*[Linux Security Framework Layer – Zone 3: Network]*
