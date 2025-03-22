#!/bin/bash

# LinuxSFL Zone 2: Operational Security Testing Script with Scoring
# Kernel parameters | Systemd services | cgroups & namespaces tuning
# Run as root or with sudo privileges

score=0
total=3

echo "==============================================="
echo "🛡️ LinuxSFL Zone 2: Operational Security Testing"
echo "==============================================="
echo ""

# Test 1: Kernel Parameters Hardening
echo "🔍 [1/3] Checking Kernel Security Parameters..."

if sysctl kernel.dmesg_restrict | grep -q '= 1'; then
  echo " - Kernel dmesg_restrict: [ ✅ SECURED ] (+1 point)"
  ((score++))
else
  echo " - Kernel dmesg_restrict: [ ❌ UNSECURED ] (+0 points)"
fi
echo ""

# Test 2: Essential Systemd Services
echo "🔍 [2/3] Checking Essential Systemd Services..."

services=("firewalld" "sshd" "auditd" "fail2ban")
services_status=0
for svc in "${services[@]}"; do
  if systemctl is-active --quiet "$svc"; then
    echo " - $svc: [ ✅ ACTIVE ]"
    ((services_status++))
  else
    echo " - $svc: [ ❌ INACTIVE ]"
  fi
done

if [[ $services_status -eq ${#services[@]} ]]; then
  echo "All essential services active (+1 point)"
  ((score++))
else
  echo "Some essential services inactive (+0 points)"
fi
echo ""

# Test 3: cgroups & Namespaces
echo "🔍 [3/3] Checking cgroups & namespaces configuration..."

if mount | grep -q "cgroup"; then
  echo " - cgroups: [ ✅ CONFIGURED ] (+0.5 point)"
  ((score+=0.5))
else
  echo " - cgroups: [ ❌ NOT CONFIGURED ] (+0 points)"
fi

if grep -q "user_namespace.enable=1" /proc/cmdline; then
  echo " - namespaces: [ ✅ CONFIGURED ] (+0.5 point)"
  ((score+=0.5))
else
  echo " - namespaces: [ ❌ NOT CONFIGURED ] (+0 points)"
fi
echo ""

# Final scoring summary
echo "==============================================="
echo "🏅 LinuxSFL Zone 2: Security Scoring Summary"
echo "==============================================="
echo "🔖 Total Score: $score / $total"
echo ""

case $score in
  3)
    echo "✅ [EXCELLENT] All operational security checks PASSED!"
    ;;
  2|2.5)
    echo "⚠️  [GOOD] Most checks passed. Review and fix minor issues."
    ;;
  1|1.5)
    echo "❗ [POOR] Several operational issues found! Immediate action required."
    ;;
  *)
    echo "🚨 [CRITICAL] Operational security severely compromised!"
    ;;
esac

echo "==============================================="
echo ""
