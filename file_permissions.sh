#!/bin/bash
# =============================================================================
# Lab 02 - File Permissions
# Description: Demonstrates chmod, chown, and special permission bits
# Use case: Securing files and directories on a Linux server
# =============================================================================

set -e

echo "=============================="
echo "  Lab 02 - File Permissions"
echo "=============================="

WORKDIR="/tmp/permissions-lab"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# --- 1. Create test files ---
echo ""
echo "[1] Creating test files..."
touch secret.txt shared.txt executable.sh
echo "Top secret data" > secret.txt
echo "Shared team data" > shared.txt
echo "#!/bin/bash\necho 'Hello from script'" > executable.sh
echo "    Files created in $WORKDIR"

# --- 2. Show default permissions ---
echo ""
echo "[2] Default permissions (before changes):"
ls -l "$WORKDIR"

# --- 3. Restrict secret.txt to owner only ---
echo ""
echo "[3] Restricting secret.txt — owner read/write only (600):"
chmod 600 secret.txt
ls -l secret.txt
echo "    Only the owner can read or write this file."

# --- 4. Make shared.txt readable by everyone ---
echo ""
echo "[4] Making shared.txt world-readable (644):"
chmod 644 shared.txt
ls -l shared.txt
echo "    Owner: read/write | Group: read | Others: read"

# --- 5. Make executable.sh executable ---
echo ""
echo "[5] Making executable.sh executable (755):"
chmod 755 executable.sh
ls -l executable.sh
echo "    Owner: rwx | Group: r-x | Others: r-x"

# --- 6. Demonstrate chown ---
echo ""
echo "[6] Demonstrating chown (showing syntax — requires sudo to actually change):"
echo "    Command: sudo chown alice:cloudteam shared.txt"
echo "    This would assign 'alice' as owner and 'cloudteam' as group."

# --- 7. Symbolic chmod examples ---
echo ""
echo "[7] Symbolic chmod examples:"
chmod u+x secret.txt    # add execute for user
chmod g-r shared.txt    # remove read from group
chmod o+r secret.txt    # add read for others
echo "    Applied: u+x on secret.txt, g-r on shared.txt, o+r on secret.txt"
ls -l "$WORKDIR"

# --- 8. Explain octal breakdown ---
echo ""
echo "[8] Octal permission reference:"
echo "    --- Permission Table ---"
echo "    7 = rwx (read + write + execute)"
echo "    6 = rw-  (read + write)"
echo "    5 = r-x  (read + execute)"
echo "    4 = r--  (read only)"
echo "    0 = ---  (no permissions)"
echo ""
echo "    Common patterns:"
echo "    600 = private file (e.g. SSH keys)"
echo "    644 = public readable file"
echo "    755 = executable script or public directory"
echo "    700 = private directory"

# --- Cleanup ---
echo ""
echo "[Cleanup] Removing lab directory: $WORKDIR"
rm -rf "$WORKDIR"

echo ""
echo "=============================="
echo "  Lab 02 Complete!"
echo "=============================="
