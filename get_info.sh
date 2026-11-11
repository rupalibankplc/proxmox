cat > /root/proxmox-stack-inventory.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

echo "===== PROXMOX VERSION ====="
pveversion -v

echo "===== NODE ====="
hostname
pvesh get /nodes --output-format yaml

echo "===== CPU ====="
lscpu | grep -E 'Model name|CPU\(s\)|Core|Thread'

echo "===== MEMORY ====="
free -h

echo "===== STORAGE ====="
pvesm status

echo "===== DISKS ====="
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT

echo "===== NETWORK ====="
ip -br addr
ip route

echo "===== EXISTING VMS ====="
qm list

echo "===== EXISTING LXCS ====="
pct list

echo "===== AVAILABLE TEMPLATES ====="
pveam available --section system | grep -E 'ubuntu-24.04|debian-13' | head -10

echo "===== END OF INVENTORY ====="
EOF

chmod +x /root/proxmox-stack-inventory.sh
/root/proxmox-stack-inventory.sh