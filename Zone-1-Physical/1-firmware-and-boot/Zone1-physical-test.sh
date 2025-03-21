#!/bin/bash

# LinuxSFL Zone 1: Physical Security Testing Script with Scoring
# bios-configuration.md | grub2-password.md | secure-boot.md
# Run as root or with sudo privileges

score=0
total=3

echo "==============================================="
echo "🔐 LinuxSFL Zone 1: Physical Security Testing"
echo "==============================================="
echo ""

# Test 1: Secure Boot status
echo "🔍 [1/3] Checking UEFI Secure Boot..."

if command -v mokutil &>/dev/null; then
  secure_boot_status=$(mokutil --sb-state | grep -i 'SecureBoot' | awk '{print $2}')
  if [[ "$secure_boot_status" == "enabled" ]]; then
    echo " - Secure Boot: [ ✅ ENABLED ] (+1 point)"
    ((score++))
  else
    echo " - Secure Boot: [ ❌ DISABLED ] (+0 points)"
  fi
else
  echo " - Secure Boot: [ ❌ mokutil not installed ] (+0 points)"
fi
echo ""

# Test 2: GRUB2 Password Protection
echo "🔍 [2/3] Verifying GRUB2 Password Protection..."

grub_cfg_path=""
if [[ -f "/boot/grub2/grub.cfg" ]]; then
  grub_cfg_path="/boot/grub2/grub.cfg"
elif [[ -f "/boot/efi/EFI/$(ls /boot/efi/EFI)/grub.cfg" ]]; then
  grub_cfg_path="/boot/efi/EFI/$(ls /boot/efi/EFI)/grub.cfg"
fi

if [[ -n "$grub_cfg_path" ]]; then
  if grep -q "password_pbkdf2" "$grub_cfg_path"; then
    echo " - GRUB2 Password: [ ✅ CONFIGURED ] (+1 point)"
    ((score++))
  else
    echo " - GRUB2 Password: [ ❌ NOT CONFIGURED ] (+0 points)"
  fi
else
  echo " - GRUB2 Config: [ ❌ NOT FOUND ] (+0 points)"
fi
echo ""

# Test 3: BIOS/UEFI Firmware Password
echo "🔍 [3/3] Checking BIOS/UEFI Firmware Password..."

if command -v dmidecode &>/dev/null; then
  bios_password_status=$(dmidecode -t bios | grep -i "password")
  if [[ -n "$bios_password_status" ]]; then
    echo " - Firmware Password: [ ✅ POSSIBLY SET ] (+1 point, Verify manually)"
    ((score++))
  else
    echo " - Firmware Password: [ ❌ NOT DETECTED ] (+0 points, Verify manually)"
  fi
else
  echo " - Firmware Password: [ ❌ dmidecode not installed ] (+0 points)"
fi
echo ""

# Final scoring summary
echo "==============================================="
echo "🏅 LinuxSFL Zone 1: Security Scoring Summary"
echo "==============================================="
echo "🔖 Total Score: $score / $total"
echo ""

case $score in
  3)
    echo "✅ [EXCELLENT] All physical security checks PASSED!"
    ;;
  2)
    echo "⚠️  [GOOD] Most checks passed. Review and fix issues."
    ;;
  1)
    echo "❗ [POOR] Critical items unsecured! Immediate action required."
    ;;
  0)
    echo "🚨 [CRITICAL] All checks failed! Immediate remediation needed!"
    ;;
esac

echo "==============================================="
echo ""
