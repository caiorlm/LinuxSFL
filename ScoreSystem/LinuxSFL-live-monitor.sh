#!/bin/bash

# LinuxSFL Live Security & System Monitor
# Atualiza a cada 3 segundos.

watch -ctn 3 '

echo -e "\033[1;34m
╔════════════════════════════════════════════════════════════════════════╗
║ 🚀 LinuxSFL Live Security & System Monitoring                          ║
╚════════════════════════════════════════════════════════════════════════╝
\033[0m"

# Scores das Zonas
echo -e "\033[1;33m[🛡️ Security Zones Scores]\033[0m"
Z1=$(bash ScoreSystem/Zone1-physical-test.sh | grep "Total Score")
Z2=$(bash ScoreSystem/Zone2-operational-test.sh | grep "Total Score")
Z3=$(bash ScoreSystem/Zone3-network-test.sh | grep "Total Score")

printf "%-25s %-25s %-25s\n" "Zone 1 - Physical" "Zone 2 - Operational" "Zone 3 - Network"
printf "%-25s %-25s %-25s\n\n" "$Z1" "$Z2" "$Z3"

# Exibe Informações Gerais em colunas organizadas
echo -e "\033[1;32m[📊 System Health Overview]\033[0m"

paste <(echo -e "\033[1;35m🔑 Last 10 logins\033[0m"; last -n 10 | awk '"'"'{print $1,$3,$4,$5,$6}'"'"') \
      <(echo -e "\033[1;35m🐏 Top RAM (PID|MEM|CMD)\033[0m"; ps axh -o pid,%mem,cmd --sort=-%mem | head -10) \
      <(echo -e "\033[1;35m🔥 Top CPU (PID|CPU|CMD)\033[0m"; ps axh -o pid,%cpu,cmd --sort=-%cpu | head -10) \
      <(echo -e "\033[1;35m💽 Top Disk I/O\033[0m"; pidstat -dl 1 1 | tail -n +4 | sort -k4 -nr | awk '"'"'{print $4,$7}'"'"' | head -10)

echo ""

# Exibição adicional detalhada abaixo
echo -e "\033[1;32m[🌐 Network Information]\033[0m"
ss -tulnp | grep LISTEN

echo -e "\n\033[1;32m[🚦 Active Services]\033[0m"
systemctl list-units --type=service --state=running | head -n 12

echo -e "\n\033[1;32m[📜 Running Scripts (.py/.js/.sh)]\033[0m"
ps aux | grep -E "(.py|.js|.sh)" | grep -v grep

echo -e "\n\033[1;32m[📒 Last 10 System Logs]\033[0m"
journalctl -n 10 --no-pager --quiet

echo -e "\n\033[1;32m[⌨️ Last 10 Commands Executed]\033[0m"
history | tail -n 10

echo -e "\n\033[1;32m[📁 Users, Home directories and Permissions]\033[0m"
ls -lh /home/

echo -e "\033[1;32m[👤 System Users]\033[0m"
cat /etc/passwd | grep "/bin/bash" | awk -F: '"'"'{print $1,$3,$7}'"'"'

echo -e "\033[1;34m
═══════════════════════════════════════════════════════════════════════════
⏳ Refresh every 3 seconds | Press Ctrl+C to Exit
═══════════════════════════════════════════════════════════════════════════
\033[0m"

'
