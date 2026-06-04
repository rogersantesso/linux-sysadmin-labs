# Lab 02 — File Permissions

## 🎯 Objective

Understand and apply Linux file permissions using `chmod` and `chown` — critical for securing servers and following the principle of least privilege.

## 📋 What the Script Does

| Step | Command | Result |
|------|---------|--------|
| Restrict a private file | `chmod 600` | Only owner can read/write |
| Set a shared file | `chmod 644` | Owner writes, everyone reads |
| Make a script executable | `chmod 755` | Owner full control, others execute |
| Change ownership | `chown user:group` | Transfer file ownership |
| Symbolic changes | `chmod u+x`, `g-r` | Granular permission adjustments |

## 🖥️ How to Run

```bash
chmod +x file_permissions.sh
./file_permissions.sh
```

## 🔍 Permission Breakdown

```
-rw-r--r--
 ^  ^  ^  ^
 |  |  |  └─ others (r--)
 |  |  └──── group  (r--)
 |  └─────── owner  (rw-)
 └────────── file type (- = file, d = directory)
```

## 📊 Octal Quick Reference

| Octal | Permissions | Common Use |
|-------|------------|------------|
| `600` | rw------- | SSH private keys, secrets |
| `644` | rw-r--r-- | Config files, web content |
| `700` | rwx------ | Private scripts/directories |
| `755` | rwxr-xr-x | Public scripts, web directories |
| `777` | rwxrwxrwx | ⚠️ Avoid — too permissive |

## ☁️ Why This Matters for Cloud

- EC2 requires `chmod 400` on `.pem` key files or SSH rejects the connection
- Wrong permissions on config files can expose credentials
- Security hardening audits check file permissions across the server
