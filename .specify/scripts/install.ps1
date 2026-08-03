<#
.SYNOPSIS
    Instala o fluxo SDD (upstream: C:\workspace\labs) em outro projeto ou globalmente.

.DESCRIPTION
    Estrutura espelhada do GitHub Spec Kit (github.github.io/spec-kit), em português e com as
    extensões do corpus de Engenharia de Intenção (docs/intent-engineering).

    Sem -Target: instala apenas os slash commands em ~/.claude/commands.
    Com -Target <pasta>: instala em <pasta>/.claude/commands e copia .specify/ (constitution,
    templates) para o projeto.

    Commands sdd-*.md são SOBRESCRITOS — labs é a fonte de verdade.
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

if (-not (Test-Path $srcCommands)) {
    throw "Commands de origem não encontrados em $srcCommands"
}

if ($Target) {
    if (-not (Test-Path $Target)) { throw "Target não existe: $Target" }
    $dstCommands = Join-Path $Target '.claude\commands'
    $dstSpecify  = Join-Path $Target '.specify'
} else {
    $dstCommands = Join-Path $HOME '.claude\commands'
    $dstSpecify  = $null
}

New-Item -ItemType Directory -Force -Path $dstCommands | Out-Null

$installed = foreach ($cmd in Get-ChildItem -Path $srcCommands -Filter 'sdd-*.md' | Sort-Object Name) {
    Copy-Item -Path $cmd.FullName -Destination $dstCommands -Force
    $cmd.BaseName
}

Write-Host "Commands instalados em $dstCommands" -ForegroundColor Green
$installed | ForEach-Object { Write-Host "  /$_" }

if ($dstSpecify) {
    New-Item -ItemType Directory -Force -Path (Join-Path $dstSpecify 'memory'),
                                             (Join-Path $dstSpecify 'templates') | Out-Null

    $pairs = @(
        @{ From = (Join-Path $specifyRoot 'memory\constitution.md')
           To   = (Join-Path $dstSpecify  'memory\constitution.md') }
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
