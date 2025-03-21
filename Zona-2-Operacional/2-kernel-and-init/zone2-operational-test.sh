#!/bin/bash

# LinuxSFL Zone 2: Operational Security Testing with Scoring
# kernel-parameters | systemd-services | cgroups-namespaces | root-permissions | sudoers
# Execute as root or sudo.

score=0
total=5

echo "=================================================="
echo "🖥️  LinuxSFL Zone 2: Operational Security Testing"
echo "=================================================="
echo ""

# Test 1: Kernel parameters security checks
echo "🔍 [1/5] Checking Kernel Security Parameters..."

if sysctl kernel.dmesg_restrict | grep -q "= 1"; then
    echo " - kernel.dmesg_restrict: [ ✅ SECURED ] (+1 point)"
    ((score++))
else
    echo " - kernel.dmesg_restrict: [ ❌ INSECURE (should be '1') ] (+0 points)"
fi

echo ""

# Test 2: Systemd critical services check (firewalld or ufw enabled)
echo "🔍 [2/5] Verifying Critical systemd Services (Firewall)..."

if systemctl is-active --quiet firewalld || systemctl is-active --quiet ufw; then
    echo " - Firewall Service: [ ✅ RUNNING ] (+1 point)"
    ((score++))
else
    echo " - Firewall Service: [ ❌ STOPPED ] (+0 points)"
fi

echo ""

# Test 3: cgroups and namespaces configuration
echo "🔍 [3/5] Verifying cgroups & namespaces (Docker/Kubernetes compatibility)..."

if grep -q 'cgroup' /proc/filesystems && grep -qw 'user_namespace' /proc/self/status; then
    echo " - cgroups & namespaces: [ ✅ PROPERLY CONFIGURED ] (+1 point)"
    ((score++))
else
    echo " - cgroups & namespaces: [ ❌ NOT FULLY CONFIGURED ] (+0 points)"
fi

echo ""

# Test 4: Root Account Security (Login Disabled)
echo "🔍 [4/5] Checking Root Account Security..."

if passwd -S root | grep -q "L"; then
    echo " - Root Account: [ ✅ LOGIN DISABLED ] (+1 point)"
    ((score++))
else
    echo " - Root Account: [ ❌ LOGIN ENABLED ] (+0 points)"
fi

echo ""

# Test 5: Sudoers and Least Privilege Enforcement
echo "🔍 [5/5] Validating Sudoers File for Security (NOPASSWD)..."

if grep -P '^[^#]*NOPASSWD' /etc/sudoers /etc/sudoers.d/* &>/dev/null; then
    echo " - Sudoers NOPASSWD: [ ❌ FOUND ] (+0 points)"
else
    echo " - Sudoers NOPASSWD: [ ✅ NOT FOUND ] (+1 point)"
    ((score++))
fi

echo ""

# Final scoring summary
echo "=================================================="
echo "🏅 LinuxSFL Zone 2: Operational Security Scoring"
echo "=================================================="
echo "🔖 Total Score: $score / $total"
echo ""

case $score in
  5)
    echo "✅ [EXCELLENT] All operational checks PASSED!"
    ;;
  4)
    echo "✅ [VERY GOOD] Almost all checks passed; minor review suggested."
    ;;
  3)
    echo "⚠️  [GOOD] Moderate adjustments recommended."
    ;;
  2)
    echo "❗ [POOR] Multiple critical items unsecured; fix immediately."
    ;;
  *)
    echo "🚨 [CRITICAL] Immediate remediation required; high risk detected!"
    ;;
esac

echo "=================================================="
echo ""
