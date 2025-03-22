📄 **`systemd-services.md`**

# Systemd Services Management - LinuxSFL ⚙️

Este documento descreve as melhores práticas para configuração e gerenciamento de serviços críticos do **systemd** visando maior segurança, desempenho e estabilidade do sistema Linux.

## ✅ Lista de Verificação de Serviços Essenciais

Garanta que os seguintes serviços críticos estejam ativados e monitorados regularmente:

| Serviço       | Descrição                    | Status Recomendado   |
|---------------|------------------------------|----------------------|
| `firewalld`   | Firewall dinâmico            | ✅ Ativado e rodando |
| `sshd`        | Acesso remoto via SSH        | ✅ Ativado e seguro  |
| `auditd`      | Registro de auditoria        | ✅ Ativado e rodando |
| `fail2ban`    | Sistema prevenção de intrusão| ✅ Ativado e rodando |

---

## 🛠️ Comandos Úteis para Gerenciamento de Serviços

### Verificar o status de um serviço:

```bash
sudo systemctl status <nome_do_serviço>
```

### Ativar um serviço durante o boot:

```bash
sudo systemctl enable <nome_do_serviço>
```

### Desativar um serviço no boot:

```bash
sudo systemctl disable <nome_do_serviço>
```

### Iniciar ou reiniciar um serviço imediatamente:

```bash
sudo systemctl start <nome_do_serviço>
sudo systemctl restart <nome_do_serviço>
```

---

## 🔍 Logs e Auditoria de Serviços:

Inspecione logs com frequência usando `journalctl`:

```bash
sudo journalctl -u firewalld
sudo journalctl -u sshd
sudo journalctl -u auditd
sudo journalctl -u fail2ban
```

Configure regras avançadas de auditoria para serviços críticos em:

```bash
/etc/audit/rules.d/
```

---

## 📌 Recomendações Importantes:

- Audite regularmente os serviços ativos com:

```bash
sudo systemctl list-units --type=service
```

- Desative imediatamente quaisquer serviços desnecessários ou não utilizados.
- Documente claramente qualquer exceção às políticas padrão.

---

**[Linux Security Framework Layer – Zone 2: Operational]**
