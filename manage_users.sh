#!/bin/bash
# =============================================================================
# Lab 01 - User Management
# Description: Creates users, assigns groups, sets passwords, and locks accounts
# Use case: Simulates onboarding/offboarding users on a Linux server
# =============================================================================

set -e  # Exit immediately if a command fails

echo "=============================="
echo "  Lab 01 - User Management"
echo "=============================="

# --- 1. Create a new group ---
GROUP="cloudteam"
echo ""
echo "[1] Creating group: $GROUP"
if getent group "$GROUP" > /dev/null 2>&1; then
    echo "    Group '$GROUP' already exists. Skipping."
else
    sudo groupadd "$GROUP"
    echo "    Group '$GROUP' created."
fi

# --- 2. Create two users ---
USERS=("alice" "bob")

for USER in "${USERS[@]}"; do
    echo ""
    echo "[2] Creating user: $USER"
    if id "$USER" > /dev/null 2>&1; then
        echo "    User '$USER' already exists. Skipping."
    else
        sudo useradd -m -s /bin/bash -G "$GROUP" "$USER"
        echo "    User '$USER' created and added to '$GROUP'."

        # Set a default password (would use stronger method in production)
        echo "$USER:ChangeMe123!" | sudo chpasswd
        echo "    Password set for '$USER'."

        # Force password change on first login
        sudo chage -d 0 "$USER"
        echo "    '$USER' must change password on first login."
    fi
done

# --- 3. Display user info ---
echo ""
echo "[3] User details:"
for USER in "${USERS[@]}"; do
    echo "    --- $USER ---"
    id "$USER"
done

# --- 4. Lock a user account (simulating offboarding) ---
echo ""
echo "[4] Locking account: bob (simulating offboarding)"
sudo usermod -L bob
echo "    Account 'bob' locked."

# Verify lock (locked accounts show '!' in shadow)
echo "    Verifying lock status..."
sudo passwd -S bob | grep -q "L" && echo "    Confirmed: bob is LOCKED." || echo "    bob is UNLOCKED."

# --- 5. Show /etc/passwd entries ---
echo ""
echo "[5] /etc/passwd entries for created users:"
grep -E "^(alice|bob):" /etc/passwd

echo ""
echo "=============================="
echo "  Lab 01 Complete!"
echo "=============================="
