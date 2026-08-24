# templates/ — artefatos de contexto reutilizáveis

Dois arquivos que trabalham em par. A regra que os governa está na
[ADR-001](../kb/11-adrs.md#adr-001--um-par-claudemd--agentsmd-sem-duplicação):

> **`AGENTS.md`** carrega as regras de engenharia **portáveis** (valem em qualquer agente).
> **`CLAUDE.md`** importa o primeiro com `@AGENTS.md` e acrescenta **só** o que é do Claude Code.
> Uma regra mora em um lugar só.

Isso existe para evitar um problema real e observado: dois arquivos de norma vigentes definindo os
**mesmos identificadores** com significados **diferentes**
([AP-14 · Namespace Colidido](../kb/05-antipadroes.md)).

## Instalar num projeto

```powershell
$p = 'C:\workspace\<projeto>'
Copy-Item C:\workspace\labs\templates\AGENTS.template.md "$p\AGENTS.md"
Copy-Item C:\workspace\labs\templates\CLAUDE.template.md "$p\CLAUDE.md"
```

Depois: preencha os `<placeholders>`, **apague todos os comentários HTML**, e rode uma sessão real para
observar se o comportamento mudou.

## As quatro regras de manutenção

1. **Teste de inclusão, linha a linha:** *"remover isto faria o agente errar?"* Se não, apague.
2. **Tamanho:** AGENTS.md 60–120 linhas · CLAUDE.md 40–80 próprias. Passou de 150 somadas, alguma regra
   já está sendo ignorada.
3. **Onde cada coisa mora** — use a
   [árvore AD-02](../kb/09-decisao-estados-algoritmos.md#ad-02--onde-este-conhecimento-deve-morar):
   muda com frequência → `STATUS.md` · vale só num diretório → `<dir>/CLAUDE.md` · vale só às vezes →
   skill · precisa valer sem exceção → hook/CI · portátil → `AGENTS.md` · específico do Claude Code →
   `CLAUDE.md`.
4. **Teste de eficácia:** mude uma linha e observe se o comportamento muda de fato. Se não muda, a
   linha não está fazendo nada.

## Diagnóstico rápido

| Sintoma | Causa provável | Ação |
|---|---|---|
| O agente ignora uma regra escrita | arquivo longo demais | podar |
| O agente pergunta algo já respondido | redação ambígua | reescrever a linha |
| A informação envelheceu sozinha | estado volátil no arquivo permanente | mover para `STATUS.md` |
| A regra é violada mesmo estando escrita | instrução é advisory | converter em hook/CI |
| Duas definições do mesmo identificador | AP-14 | renumerar uma das fontes |
| Cópias divergindo entre harnesses | AP-15 | fonte única + geração |

## O que NÃO instalar por aqui

O fluxo SDD (`/sdd-*`) e a skill portátil `loop-engineering` têm instalador próprio:

```powershell
pwsh C:\workspace\labs\.specify\scripts\install.ps1 -Target C:\workspace\<projeto>
```

O instalador copia a fonte canônica da skill para `.agents/skills/loop-engineering` e
`.claude/skills/loop-engineering`, evitando edição manual divergente (AP-15). Também instala o comando
opcional `/sdd-loop`, que produz `specs/NNN-slug/loop.md` depois de `tasks`/`analyze` e antes de
`implement` quando feedback realmente muda a próxima ação.

## Fundamentação

Tudo nestes templates deriva de [`kb/`](../kb/README.md) — em especial
[anthropic-claude-code.md](../kb/anthropic-claude-code.md) (regra de inclusão, camadas, modos de
falha), [03-principios.md](../kb/03-principios.md) (P05–P07, P10–P11) e
[05-antipadroes.md](../kb/05-antipadroes.md) (AP-02, AP-14, AP-15, AP-26).
