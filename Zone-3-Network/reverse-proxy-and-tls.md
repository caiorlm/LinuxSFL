📄 **`reverse-proxy-and-tls.md`**

# Secure Reverse Proxy and TLS Configuration - LinuxSFL 🔐

This document describes best practices for configuring a secure reverse proxy and implementing robust TLS encryption, enhancing application security, performance, and reliability.

---

## ✅ **Security and Performance Checklist:**

- [ ] Use strong, up-to-date TLS configurations (TLS 1.2/1.3)
- [ ] Disable weak ciphers and protocols (SSLv2, SSLv3, TLSv1.0)
- [ ] Enforce HTTP Strict Transport Security (HSTS)
- [ ] Use robust, well-tested cipher suites
- [ ] Regularly monitor certificate expiration and automate renewal (Let's Encrypt recommended)

---

## ⚙️ **Example Reverse Proxy Configuration (NGINX):**

Secure and optimized reverse proxy configuration:
```nginx
server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers EECDH+AESGCM:EDH+AESGCM;
    ssl_session_cache shared:SSL:10m;
    ssl_session_tickets off;

    add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload" always;

    location / {
        proxy_pass http://localhost:3000/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}
```

---

## 🛠️ **Commands for Managing TLS Certificates (Certbot):**

Install Certbot and obtain certificates automatically:
```bash
# Install Certbot for NGINX (example for Debian-based)
sudo apt install certbot python3-certbot-nginx -y

# Obtain and automatically install certificates
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Automatic renewal
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer
```

---

## 🔍 **Monitoring and Debugging Reverse Proxy:**

Check NGINX configuration syntax:
```bash
sudo nginx -t
```

Reload NGINX configuration safely:
```bash
sudo systemctl reload nginx
```

Inspect TLS certificates:
```bash
openssl s_client -connect yourdomain.com:443 -showcerts
```

---

## 📌 **Recommended Best Practices:**

- Regularly test your TLS configuration with tools like SSL Labs.
- Monitor reverse proxy logs regularly (`/var/log/nginx/access.log`, `/var/log/nginx/error.log`).
- Maintain clear documentation and change logs for proxy configurations.
- Plan and execute regular security audits.

---

*[Linux Security Framework Layer – Zone 3: Network]*
