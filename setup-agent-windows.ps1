# Azure DevOps Self-Hosted Agent - Setup Script
# Windows PowerShell Setup
# Run as Administrator

Write-Host "=== Azure DevOps Self-Hosted Agent Setup ===" -ForegroundColor Green

# 1. Criar diretório
$agentPath = "C:\Agent"
if (-not (Test-Path $agentPath)) {
    New-Item -ItemType Directory -Path $agentPath | Out-Null
    Write-Host "✅ Diretório criado: $agentPath"
} else {
    Write-Host "✅ Diretório já existe: $agentPath"
}

# 2. Baixar agent
Write-Host "`n📥 Baixando Azure Pipelines Agent..."
$agentUrl = "https://vstsagentpackage.azureedge.net/agent/3.248.0/vsts-agent-win-x64-3.248.0.zip"
$zipPath = "$agentPath\agent.zip"

Invoke-WebRequest -Uri $agentUrl -OutFile $zipPath
Write-Host "✅ Agent baixado"

# 3. Extrair
Write-Host "`n📦 Extraindo agent..."
Expand-Archive -Path $zipPath -DestinationPath $agentPath -Force
Remove-Item $zipPath
Write-Host "✅ Agent extraído"

# 4. Instruções finais
Write-Host "`n=== PRÓXIMOS PASSOS ===" -ForegroundColor Yellow
Write-Host "1. Vá para: cd C:\Agent"
Write-Host "2. Execute: .\config.cmd"
Write-Host "3. Preencha os dados:"
Write-Host "   - Server URL: https://dev.azure.com/SUA_ORGANIZACAO"
Write-Host "   - Personal Access Token: (crie em dev.azure.com > User Settings > Personal access tokens)"
Write-Host "   - Agent pool: Default (ou crie uma nova)"
Write-Host "   - Agent name: seu-computador-name"
Write-Host ""
Write-Host "4. Executar como serviço: .\config.cmd --deploymentGroup --deploymentGroupName 'Default' --agent @(hostname) --replace"
Write-Host ""
Write-Host "✅ Setup concluído!"
