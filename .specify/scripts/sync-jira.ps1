<#
.SYNOPSIS
    Script de automação para transição de status no Jira alinhado ao fluxo SDD e Agentes AI.

.DESCRIPTION
    Transiciona a issue do Jira entre os estados:
    - "To Do" (Transition 11)        -> Ao especificar/planejar (sdd-specify, sdd-plan)
    - "In Progress" (Transition 21)   -> Ao iniciar implementação (sdd-implement)
    - "In Review" (Transition 31)      -> Ao solicitar code review / convergência (sdd-converge)
    - "Done" (Transition 41)           -> Ao concluir / aprovar / mergear na main

.PARAMETER IssueKey
    Chave do ticket Jira (ex: IA-148).

.PARAMETER Stage
    Fase do fluxo SDD: 'todo', 'implement', 'review', 'done'.

.EXAMPLE
    pwsh .specify/scripts/sync-jira.ps1 -IssueKey "IA-148" -Stage "implement"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$IssueKey,

    [Parameter(Mandatory=$true)]
    [ValidateSet("todo", "implement", "review", "done")]
    [string]$Stage
)

$TransitionMap = @{
    "todo"      = @{ Id = "11"; Name = "To Do" }
    "implement" = @{ Id = "21"; Name = "In Progress" }
    "review"    = @{ Id = "31"; Name = "In Review" }
    "done"      = @{ Id = "41"; Name = "Done" }
}

$TargetTransition = $TransitionMap[$Stage]

Write-Host "🔄 [Jira Sync] Transicionando $IssueKey para '$($TargetTransition.Name)' (Stage: $Stage)..." -ForegroundColor Cyan

# Suporte duplo de variáveis de ambiente (gajira vs padrão customizado)
$JiraBaseUrl = if ($env:JIRA_BASE_URL) { $env:JIRA_BASE_URL } else { $env:JIRA_SITE_URL }
$JiraEmail   = if ($env:JIRA_USER_EMAIL) { $env:JIRA_USER_EMAIL } elseif ($env:JIRA_EMAIL) { $env:JIRA_EMAIL } else { $env:JIRA_API_USER }
$JiraApiToken = $env:JIRA_API_TOKEN

if ($JiraBaseUrl -and $JiraEmail -and $JiraApiToken) {
    $AuthString = "$($JiraEmail):$($JiraApiToken)"
    $Headers = @{
        Authorization = "Basic " + [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($AuthString))
        "Content-Type"  = "application/json"
    }

    $Body = @{
        transition = @{ id = $TargetTransition.Id }
    } | ConvertTo-Json

    $Url = "$($JiraBaseUrl.TrimEnd('/'))/rest/api/3/issue/$IssueKey/transitions"

    try {
        $Response = Invoke-RestMethod -Uri $Url -Method Post -Headers $Headers -Body $Body
        Write-Host "✅ [Jira Sync] Status atualizado no Jira para '$($TargetTransition.Name)'!" -ForegroundColor Green
    } catch {
        Write-Error "❌ Falha ao transicionar no Jira REST API: $_"
    }
} else {
    Write-Host "ℹ️ Variáveis de ambiente JIRA_BASE_URL (ou JIRA_SITE_URL), JIRA_USER_EMAIL (ou JIRA_EMAIL) e JIRA_API_TOKEN não encontradas." -ForegroundColor Yellow
    Write-Host "💡 Transição simulada localmente / delegada ao Atlassian MCP Tool (transitionJiraIssue)." -ForegroundColor Yellow
    Write-Host "   Issue: $IssueKey | Transição Alvo ID: $($TargetTransition.Id) ($($TargetTransition.Name))" -ForegroundColor Gray
}
