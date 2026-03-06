# Guia Resumido — Samba + Proxmox + LXC + Docker Compartilhando a Mesma Pasta

Cenário:

```
Windows
   │
Samba (host Proxmox)
   │
/mnt/4tb_dados/projetos
   │
LXC Debian
   │
Docker containers
```

Objetivo:

* Windows editar arquivos
* LXC trabalhar normalmente
* Docker usar os projetos
* sem conflito de permissão
* sem ACL problemática
* grupo único controlando acesso

---

# 1️⃣ Estrutura de Grupo (HOST)

Criar grupo único para controlar acesso.

```bash
groupadd -g 1003 projetos
```

Adicionar usuários necessários:

```bash
usermod -aG projetos can
usermod -aG projetos dockerlxc
```

Verificar:

```bash
getent group projetos
```

Resultado esperado:

```
projetos:x:1003:can,dockerlxc
```

---

# 2️⃣ Preparar a Pasta no Host

Remover ACL antigas (se existirem):

```bash
setfacl -bR /mnt/4tb_dados/projetos
```

Definir dono e grupo:

```bash
chown -R root:projetos /mnt/4tb_dados/projetos
```

Permissões corretas:

```bash
chmod -R 2775 /mnt/4tb_dados/projetos
```

Significado:

```
2 = setgid (herda grupo)
775 = grupo pode editar
```

Resultado esperado:

```
drwxrwsr-x root projetos
```

---

# 3️⃣ Configuração do Samba (HOST)

Arquivo:

```
/etc/samba/smb.conf
```

Share:

```ini
[projetos]
   path = /mnt/4tb_dados/projetos
   browseable = yes
   writable = yes
   guest ok = no
   valid users = @projetos
   force group = projetos
   create mask = 0664
   directory mask = 2775
```

Reiniciar:

```bash
systemctl restart smbd
```

---

# 4️⃣ Configuração do LXC

Arquivo:

```
/etc/pve/lxc/102.conf
```

Configuração essencial:

```
unprivileged: 0
```

Remover qualquer linha:

```
lxc.idmap
```

Montar a pasta do host:

```
mp1: /mnt/4tb_dados/projetos,mp=/projetos
```

Reiniciar container:

```bash
pct restart 102
```

---

# 5️⃣ Garantir Grupo Dentro do LXC

No LXC:

```bash
groupadd -g 1003 projetos
```

Verificar:

```bash
getent group projetos
```

Resultado:

```
projetos:x:1003:
```

---

# 6️⃣ Ajustar UMASK no LXC

Isso garante permissões corretas ao criar arquivos.

Editar:

```
/etc/profile
```

Adicionar no final:

```bash
umask 002
```

Confirmar:

```bash
umask
```

Resultado esperado:

```
0002
```

---

# 7️⃣ Permissões que Devem Surgir

### Pastas novas

```
drwxrwsr-x
```

### Arquivos novos

```
-rw-rw-r--
```

Grupo sempre:

```
projetos
```

---

# 8️⃣ Docker Usando a Pasta

Montagem típica:

```yaml
volumes:
  - /projetos:/dados
```

Opcionalmente definir usuário:

```yaml
user: "1000:1003"
```

---

# 9️⃣ Teste Final

No Windows:

Criar arquivo.

No LXC:

```bash
ls -la /projetos
```

No LXC:

```bash
touch /projetos/teste_lxc.txt
```

No Windows:

* editar
* renomear
* apagar

Tudo deve funcionar.

---

# 🔎 Regras de Ouro para Esse Tipo de Ambiente

Não misturar:

```
ACL complexa
+
chmod tradicional
```

Usar sempre:

```
grupo único
setgid
umask 002
```

Evitar:

```
force user
ACL mask
idmap
```

Arquitetura simples = menos conflito entre:

```
Windows
Linux
Docker
Samba
```

---

# Resultado Final

Sistema consistente onde:

* Windows trabalha normalmente
* LXC usa root sem problema
* Docker escreve nos projetos
* todos os arquivos ficam no grupo **projetos**
* sem erros de permissão.
