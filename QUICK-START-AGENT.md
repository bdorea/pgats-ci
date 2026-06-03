 ⚡ Quick Start: Self-Hosted Agent em 5 minutos

## Pré-requisitos (já tem? ✅)
- Windows 10/11 ou Server 2016+
- PowerShell (padrão no Windows)
- Git (já tem!)
- Node.js 24.x (já tem!)
- Yarn (já tem!)

---

## 🚀 Setup Rápido

### 1️⃣ Gerar Token (2 min)

```
1. Abra: https://dev.azure.com/SEU_USER
2. Clique seu avatar (canto superior direito)
3. "User settings" → "Personal access tokens" → "New Token"
4. Nome: agent-token
5. Scope: Agent Pools (read, manage)
6. Expiration: 1 year
7. Create → COPIE O TOKEN
```

### 2️⃣ Registrar Agent (2 min)

**PowerShell como Administrador:**

```powershell
# Criar pasta
mkdir C:\Agent
cd C:\Agent

# Baixar agent
$url = "https://vstsagentpackage.azureedge.net/agent/3.248.0/vsts-agent-win-x64-3.248.0.zip"
Invoke-WebRequest -Uri $url -OutFile agent.zip
Expand-Archive -Path agent.zip -DestinationPath .
Remove-Item agent.zip

# Configurar
.\config.cmd
```

**Preencha os prompts:**
```
Server URL: https://dev.azure.com/SEU_USER

Auth type: (Enter - PAT)

PAT: (Cole o token gerado acima)

Agent pool: (Enter - Default)

Agent name: (Enter - seu-pc-name)

Work folder: (Enter - _work)

Run as service: Y

Logon account: (Enter - Network Service)
```

### 3️⃣ Verificar (1 min)

```
1. Abra: https://dev.azure.com/SEU_USER
2. Project Settings → Agent Pools → Default
3. Agents → Procure seu PC
4. Status deve ser: ONLINE 🟢
```

---

## 🧪 Testar o Agent

### Opção A: Testar com branch (recomendado)

```bash
cd C:\projetos\pgats\pgats-ci
git checkout -b test/self-hosted-agent

# Editar arquivo simples
echo "Teste" >> README.md

git add README.md
git commit -m "Testar self-hosted agent"
git push origin test/self-hosted-agent
```

Depois no Azure DevOps:
1. Vá em **Pipelines**
2. Clique na pipeline
3. Mude para usar `azure-pipelines-self-hosted.yml`
4. Run → Dispara manualmente
5. Veja executar no seu PC! 

### Opção B: Testar command line

```powershell
# Forçar check no seu agent
cd C:\Agent
.\run.cmd --once
```

---

## 📊 Monitorar Execução

```
Enquanto a pipeline roda:

1. Azure DevOps → Pipelines → [sua pipeline]
2. Veja o log em tempo real
3. Seu PC vai:
   - Clonar repo
   - Instalar dependências
   - Rodar testes
   - Upload de artefatos

Tudo no seu PC! 🎉
```

---

## ⚠️ Se der erro:

### Agent não aparece online:
```powershell
# Reiniciar o serviço
Restart-Service -Name "vstsagent.*" -Force
```

### Token expirou:
```powershell
cd C:\Agent
.\config.cmd remove --auth PAT --token VELHO_TOKEN
# Depois faça config.cmd de novo com novo token
```

### Firewall bloqueando:
```
Verifique se Dev.Azure.com está acessível:
ping dev.azure.com
```

---

## ✅ Próximos Passos

- [ ] Gerar Personal Access Token
- [ ] Executar setup-agent-windows.ps1 ou config.cmd
- [ ] Verificar agent como ONLINE
- [ ] Testar com branch test/self-hosted-agent
- [ ] Usar azure-pipelines-self-hosted.yml na pipeline
- [ ] Monitor de performance em Agent Pools

---

## 📚 Documentação Completa

👉 Ver: `SELF-HOSTED-AGENT-GUIDE.md`

---

**Tempo estimado:** 5-10 minutos ⏱️

**Resultado:** Pipeline rodando no seu PC! 🚀
