# Lab 01 — User Management

## 🎯 Objective

Simulate real sysadmin tasks: creating users, assigning them to groups, setting passwords, and locking accounts (offboarding).

## 📋 What the Script Does

| Step | Command Used | Purpose |
|------|-------------|---------|
| Create a group | `groupadd` | Organise users by team/role |
| Create users | `useradd -m -s /bin/bash -G` | New users with home dir and shell |
| Set passwords | `chpasswd` | Assign initial password |
| Force password change | `chage -d 0` | Security best practice |
| Lock account | `usermod -L` | Offboarding / access removal |
| Verify lock | `passwd -S` | Confirm account status |

## 🖥️ How to Run

```bash
chmod +x manage_users.sh
sudo ./manage_users.sh
```

> Requires `sudo` because creating users and modifying `/etc/passwd` needs root privileges.

## 🔍 Key Commands Reference

```bash
# Create a user with home directory
sudo useradd -m username

# Add user to a group
sudo usermod -aG groupname username

# Check user info
id username

# Lock a user
sudo usermod -L username

# Unlock a user
sudo usermod -U username

# Delete a user and their home directory
sudo userdel -r username
```

## ☁️ Why This Matters for Cloud

On AWS EC2 or any Linux server:
- You manage SSH users for team access
- IAM concepts mirror Linux user/group permissions
- Security audits require knowing who has access and when to remove it
