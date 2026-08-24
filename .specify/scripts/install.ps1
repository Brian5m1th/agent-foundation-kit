<#
.SYNOPSIS
    Instala o fluxo SDD, Git Hooks e comandos (upstream: C:\workspace\labs) em outro projeto ou globalmente.

.DESCRIPTION
    Estrutura espelhada do GitHub Spec Kit (github.github.io/spec-kit), em português e com as
    extensões do corpus de Engenharia de Intenção (docs/intent-engineering) e Loop Engineering.

    Sem -Target: instala slash commands e a skill loop-engineering globalmente, além dos Git Hooks
    no repositório labs local.
    Com -Target <pasta>: instala commands, a skill em .agents/.claude, Git Hooks em
    <pasta>/.git/hooks e copia .specify/ para o projeto.

    Commands *.md são SOBRESCRITOS — labs é a fonte de verdade.
    Git Hooks em templates/githooks/ são instalados para garantir o enforcamento do RGIT-02, RGIT-05, RSEC-01.
    constitution.md e templates NÃO são sobrescritos, para preservar edições do projeto.
    Use -Force para sobrescrever também esses.

.EXAMPLE
    pwsh C:\workspace\labs\.specify\scripts\install.ps1
    pwsh C:\workspace\labs\.specify\scripts\install.ps1 -Target C:\workspace\WWMA-Tech
#>
[CmdletBinding()]
param(
    [string] $Target,
    [switch] $Force
)

$ErrorActionPreference = 'Stop'

$specifyRoot = Split-Path -Parent $PSScriptRoot          # <labs>\.specify
$labs        = Split-Path -Parent $specifyRoot           # <labs>
$srcCommands = Join-Path $labs '.claude\commands'
$srcLoopSkill = Join-Path $labs 'skills\loop-engineering'
$srcHooks    = Join-Path $labs 'templates\githooks'

if (-not (Test-Path $srcCommands)) {
    throw "Commands de origem não encontrados em $srcCommands"
}
if (-not (Test-Path $srcLoopSkill)) {
    throw "Skill de origem não encontrada em $srcLoopSkill"
}

if ($Target) {
    if (-not (Test-Path $Target)) { throw "Target não existe: $Target" }
    $dstCommands = Join-Path $Target '.claude\commands'
    $dstSpecify  = Join-Path $Target '.specify'
    $dstSkillRoots = @(
        (Join-Path $Target '.agents\skills'),
        (Join-Path $Target '.claude\skills')
    )
    $targetGit   = Join-Path $Target '.git'
} else {
    $userProfile = [Environment]::GetFolderPath('UserProfile')
    $dstCommands = Join-Path $userProfile '.claude\commands'
    $dstSpecify  = $null
    $dstSkillRoots = @(
        (Join-Path $userProfile '.agents\skills'),
        (Join-Path $userProfile '.claude\skills')
    )
    $targetGit   = Join-Path $labs '.git'
}

New-Item -ItemType Directory -Force -Path $dstCommands | Out-Null

$installed = foreach ($cmd in Get-ChildItem -Path $srcCommands -Filter '*.md' | Sort-Object Name) {
    Copy-Item -Path $cmd.FullName -Destination $dstCommands -Force
    $cmd.BaseName
}

Write-Host "Commands instalados em $dstCommands" -ForegroundColor Green
$installed | ForEach-Object { Write-Host "  /$_" }

Write-Host ''
foreach ($skillRoot in $dstSkillRoots) {
    $dstLoopSkill = Join-Path $skillRoot 'loop-engineering'
    New-Item -ItemType Directory -Force -Path $dstLoopSkill | Out-Null
    foreach ($sourceFile in Get-ChildItem -Path $srcLoopSkill -Recurse -File) {
        $relative = [IO.Path]::GetRelativePath($srcLoopSkill, $sourceFile.FullName)
        $destination = Join-Path $dstLoopSkill $relative
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
        Copy-Item -LiteralPath $sourceFile.FullName -Destination $destination -Force
    }
    Write-Host "Skill instalada em $dstLoopSkill" -ForegroundColor Green
}

# Instalação de Git Hooks
if ((Test-Path $srcHooks) -and (Test-Path $targetGit)) {
    $dstHooks = Join-Path $targetGit 'hooks'
    New-Item -ItemType Directory -Force -Path $dstHooks | Out-Null
    Write-Host ''
    Write-Host "Instalando Git Hooks em $dstHooks..." -ForegroundColor Green
    foreach ($hook in Get-ChildItem -Path $srcHooks) {
        $hookTarget = Join-Path $dstHooks $hook.Name
        Copy-Item -Path $hook.FullName -Destination $hookTarget -Force
        Write-Host "  hook instalado: $($hook.Name)" -ForegroundColor Green
    }
}

if ($dstSpecify) {
    New-Item -ItemType Directory -Force -Path (Join-Path $dstSpecify 'memory'),
                                             (Join-Path $dstSpecify 'templates'),
                                             (Join-Path $dstSpecify 'scripts'),
                                             (Join-Path $Target '.github\workflows') | Out-Null

    $pairs = @(
        @{ From = (Join-Path $specifyRoot 'memory\constitution.md')
           To   = (Join-Path $dstSpecify  'memory\constitution.md') },
        @{ From = (Join-Path $specifyRoot 'scripts\sync-jira.ps1')
           To   = (Join-Path $dstSpecify  'scripts\sync-jira.ps1') },
        @{ From = (Join-Path $labs        '.github\workflows\jira-sdd-sync.yml')
           To   = (Join-Path $Target      '.github\workflows\jira-sdd-sync.yml') }
    )
    foreach ($tpl in Get-ChildItem -Path (Join-Path $specifyRoot 'templates') -Filter '*.md') {
        $pairs += @{ From = $tpl.FullName
                     To   = (Join-Path $dstSpecify "templates\$($tpl.Name)") }
    }

    Write-Host ''
    foreach ($p in $pairs) {
        if ((Test-Path $p.To) -and -not $Force) {
            Write-Host "  preservado: $($p.To)" -ForegroundColor DarkYellow
        } else {
            Copy-Item -Path $p.From -Destination $p.To -Force
            Write-Host "  copiado:    $($p.To)" -ForegroundColor Green
        }
    }

    New-Item -ItemType Directory -Force -Path (Join-Path $Target 'specs') | Out-Null

    Write-Host ''
    Write-Host "Próximo passo: rode /sdd-constitution em $Target para escrever os princípios reais do projeto." -ForegroundColor Cyan
}
