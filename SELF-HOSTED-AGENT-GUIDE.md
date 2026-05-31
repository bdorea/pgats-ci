# 🖥️ Self-Hosted Agent Setup Guide

## O que é um Self-Hosted Agent?

Um agente self-hosted é um computador (seu PC, servidor local, VM) que você configura para executar pipelines do Azure DevOps.

**Vantagens:**
- ✅ Acesso a rede privada
- ✅ Builds incrementais + cache
- ✅ Sem limite de tempo de execução
- ✅ Grátis (você já tem o hardware)
- ✅ Maior controle

**Desvantagens:**
- ❌ Você mantém a máquina
- ❌ Precisa estar ligada/conectada
- ❌ Sem auto-scaling automático

---

## 📋 Pré-requisitos

### Para Windows:
- Windows 10/11 ou Server 2016+
- PowerShell 5.0+
- Git
- Node.js 24.x
- Yarn
- Permissões de Administrador

### Para Linux:
```bash
sudo apt-get update
sudo apt-get install curl git -y
# Instalar Node.js 24.x
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt-get install nodejs -y
npm install -g yarn
```

---

## 🚀 Passo 1: Criar Personal Access Token (PAT)

1. Vá para: https://dev.azure.com
2. Clique em seu avatar (canto superior direito)
3. **User settings** → **Personal access tokens**
4. Clique em **New Token**
5. Preencha:
   - **Name:** `agent-token`
   - **Expiration:** 1 year
   - **Scopes:** Selecione **Agent Pools (read, manage)**
6. Clique em **Create**
7. **Copie o token** (aparece uma única vez!)

---

## 🔧 Passo 2: Registrar o Agent

### Windows (PowerShell como Administrador):

```powershell
cd C:\Agent

# Configurar agent
.\config.cmd
```

Preencha os prompts:

```
Enter server URL > https://dev.azure.com/SUA_ORGANIZACAO

Enter authentication type (press enter for PAT) > (Enter)

Enter personal access token > (cole o token)

Enter agent pool (press enter for Default) > (Enter ou nome da pool)

Enter agent name (press enter for seu-pc-name) > (Enter ou nome customizado)

Enter work folder (press enter for _work) > (Enter)

Enter run agent as service? (Y/N) (press enter for N) > Y

Enter Windows logon account (press enter for NT AUTHORITY\NETWORK SERVICE) > (Enter)

Enter Windows logon password > (Enter - deixe em branco)
```

### Linux/macOS:

```bash
cd ~/agent

./config.sh
```

Preencha os mesmos prompts.

---

## ✅ Passo 3: Verificar o Agent

1. Vá para: https://dev.azure.com/SUA_ORGANIZACAO
2. **Project Settings** → **Agent Pools**
3. Selecione a pool (Default)
4. Clique em **Agents**
5. Você deve ver seu agent **online** e **idle**

---

## 🔄 Passo 4: Usar no Pipeline

No `azure-pipelines.yml`, altere o pool:

```yaml
pool:
  name: 'Default'  # Nome da pool do seu agent
  demands:
    - agent.os -equals Windows  # Se quiser especificar SO
```

Ou para qualquer agent:

```yaml
pool:
  name: 'Default'
```

---

## 📊 Exemplo Completo com Self-Hosted Agent

```yaml
trigger: none

pool:
  name: 'Default'  # Usar seu self-hosted agent
  demands:
    - node  # Agent precisa ter Node.js instalado

stages:
  - stage: Tests
    displayName: 'Testes no Self-Hosted Agent'
    jobs:
      - job: RunTests
        displayName: 'Executar testes'
        steps:
          - script: node --version
            displayName: 'Verificar Node.js'

          - script: yarn install
            displayName: 'Instalar dependências'

          - script: yarn test
            displayName: 'Executar testes'

          - script: yarn run e2e
            displayName: 'Executar E2E'
```

---

## 🔐 Boas Práticas de Segurança

1. **Usar token com expiração limitada** (1 year máximo)
2. **Agent pool específico** para cada projeto sensível
3. **Limitar acesso** (apenas colaboradores confiáveis)
4. **Firewall:** Se está em rede privada, configure firewall
5. **Não compartilhar** token ou credenciais
6. **Manter atualizado:** `.\run.cmd` auto-update está habilitado

---

## 🛠️ Gerenciar o Agent

### Verificar status:
```bash
cd C:\Agent
# O agent roda como serviço, veja em Services (services.msc)
```

### Parar/Reiniciar:
```powershell
# Windows Service
Stop-Service -Name "vstsagent.SUA_ORGANIZACAO.Default.seu-pc-name"
Start-Service -Name "vstsagent.SUA_ORGANIZACAO.Default.seu-pc-name"
```

### Desregistrar:
```bash
cd C:\Agent
.\config.cmd remove --auth PAT --token SEU_TOKEN
```

---

## 🧹 Limpeza Automática

O agent auto-limpa a pasta `_work` entre execuções. Para manter cache:

```yaml
jobs:
  - job: CachedBuild
    workspace:
      clean: outputs  # Limpa apenas outputs, mantém node_modules
```

---

## 💡 Dicas

- **Usar em branch de teste primeiro** (`test/opencommit-demo`)
- **Monitorar performance** em Project Settings → Agent Pools
- **Logs do agent** estão em: `C:\Agent\_diag\`
- **Para testes paralelos:** Configure múltiplos agents (1 por máquina!)

---

## ❓ Troubleshooting

### Agent não aparece como online:
1. Verifique se o serviço está rodando: `services.msc`
2. Verifique logs: `C:\Agent\_diag\`
3. Reinicie o agente

### Erros de permissão:
1. Rode PowerShell como Administrador
2. Verifique firewall/proxy

### Não consegue conectar ao Azure DevOps:
1. Verifique URL da organização
2. Verifique token (expirou?)
3. Verifique internet

---

**Próximo passo:** Use seu self-hosted agent na pipeline!
