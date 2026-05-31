# 📊 Comparação: Self-Hosted vs Microsoft-Hosted Agents

## Azure DevOps

| Aspecto | Microsoft-Hosted | Self-Hosted |
|--------|------------------|------------|
| **Manutenção** | ✅ Automática | ❌ Manual |
| **Custo** | 💰 Pago (minutos) | ✅ Grátis |
| **Cache** | ❌ Limpo a cada job | ✅ Persiste |
| **Builds incrementais** | ❌ Não | ✅ Sim |
| **Segurança** | 🔒 Hosted | 🔐 Seu controle |
| **Tempo startup** | ⏱️ 2-5 min | ⚡ Instantâneo |
| **Acesso rede privada** | ❌ Difícil | ✅ Nativo |
| **Software customizado** | ⚠️ Pré-instalado | ✅ Qualquer coisa |
| **Performance** | 📊 Previsível | 📈 Depende HW |
| **Parallelização** | 📦 Paga extra | ✅ Ilimitado |

---

## GitHub Actions

| Aspecto | GitHub-Hosted Runners | Self-Hosted Runners |
|--------|----------------------|-------------------|
| **Setup** | ✅ Instantâneo | ⚠️ Manual |
| **Escalabilidade** | ✅ Automática | ❌ Manual |
| **Custo** | 💰 Minutos/mês | ✅ Grátis |
| **Customização** | ⚠️ Limitada | ✅ Total |
| **Labels** | ✅ Pré-definidos | ✅ Customizáveis |
| **Offline access** | ❌ Não | ✅ Sim |

---

## GitLab

| Aspecto | GitLab-Hosted Runners | Self-Managed Runners |
|--------|----------------------|-------------------|
| **Setup** | ✅ Zero | ⚠️ Manual |
| **Executores** | 📦 Docker/Shell | ✅ Docker/Shell/K8s |
| **Redundância** | ✅ Alta | ⚠️ Depende setup |
| **Custo** | 💰 Baseado uso | ✅ Grátis |
| **Compartilhamento** | 🔗 Instance runners | 🔗 Group/Project runners |

---

## 🎯 Quando usar cada um?

### Use **Microsoft-Hosted** quando:
- ✅ Prototipagem inicial
- ✅ Projetos públicos
- ✅ Não há restrição orçamentária
- ✅ Máximo 2-3 builds simultâneos
- ✅ Sem requisitos de hardware especial

### Use **Self-Hosted** quando:
- ✅ Acesso a rede corporativa/privada
- ✅ Builds pesadas (>10 min)
- ✅ Muitos builds simultâneos (>5/dia)
- ✅ Requisitos de segurança rígidos
- ✅ Hardware especializado (GPU, RAM)
- ✅ Economia: >500 min/mês em Microsoft-Hosted

### Use **Hybrid** (Recomendado):
- ✅ Microsoft-Hosted para: lint, testes rápidos
- ✅ Self-Hosted para: builds pesados, deploy
- ✅ Melhor custo-benefício!

---

## 💰 Análise de Custo (Azure DevOps)

### Cenário: 20 builds/mês de 15 min cada = 300 min

**Microsoft-Hosted:**
- Free tier: 1 job paralelo = 300 min/mês (OK, grátis!)
- Paid: Se exceder, ~$40/mês

**Self-Hosted (PC usado):**
- Eletricidade: ~$10/mês (24h ligado)
- Internet: Já tem
- **Total: $10/mês** ✅

**Break-even:** Ocorre com ~20-30 builds/mês

---

## 🚀 Recomendação para seu projeto PGATS

**Usar HYBRID:**

```yaml
# Para testes rápidos (lint, unit)
pool:
  vmImage: 'ubuntu-latest'  # Microsoft-Hosted

# Para builds pesados (E2E, Mutation)
pool:
  name: 'Default'  # Self-Hosted
  demands:
    - node
```

**Benefício:**
- Testes rápidos no hosted (CI barato)
- Builds pesados no seu PC (cache + velocidade)
- Economia: ~50%

---

## 📈 Monitoramento

### Azure DevOps - Ver performance:
1. **Project Settings** → **Agent Pools** → **Default**
2. Clique em **Agents**
3. Veja: CPU, Memória, Jobs executados

### GitHub Actions - Ver status:
1. **Settings** → **Actions** → **Runners**
2. Veja: Online/Offline, Jobs executados

---

## 🔄 Próximas Ações

1. **Setup self-hosted agent** (seguir SELF-HOSTED-AGENT-GUIDE.md)
2. **Teste com branch** `test/self-hosted-agent`
3. **Monitore performance** vs Microsoft-Hosted
4. **Implementar hybrid** conforme necessário

---

**Seu projeto:** Comece com **hybrid** para máxima eficiência! 🎯
