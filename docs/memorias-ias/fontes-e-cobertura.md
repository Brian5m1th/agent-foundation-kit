# Fontes, procedência e cobertura

Coleta local: **2026-10-03 — America/Bahia (UTC−03:00)**. Esta consolidação registra o que foi consultado, preserva a origem de cada afirmação e explicita o que continua sem verificação. Não é exportação integral de conversas nem sincronização de assistentes.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## Como interpretar a evidência

| Qualificação | Significado neste pacote |
|---|---|
| **[CAMPO] observado em 2026-10-03** | Arquivo, metadado, trecho ou vínculo inspecionado localmente nesta coleta; o escopo exato está nas tabelas abaixo |
| **[CAMPO] histórico, sem revalidação** | Resultado narrado em memória ou resumo antigo; não atesta que o sistema continua igual ou que testes continuam passando |
| **[HIPÓTESE]** | Proposta, inferência ou possibilidade de reaproveitamento ainda sem prova operacional |
| **[OFICIAL]** | Reservado a afirmação conferida em fonte oficial identificada; o inventário de disco não promove conteúdo de terceiros a oficial |

O inventário de skills e memórias foi local; a avaliação separada de [MemPalace](mempalace-uso.md)
consultou fontes primárias remotas, citadas naquele documento. Nomes de distribuidores como
`openai-*` são diretórios observados, não uma certificação de origem. Ao citar material da KB,
conservar seu selo original; a data desta coleta não altera a força ou a data da evidência original.

## Bases para referências locais

As abreviações evitam confundir arquivos homônimos. Caminhos absolutos são específicos desta máquina; os documentos versionados usam links relativos quando possível.

| Base | Raiz / resolução |
|---|---|
| `LABS:` | `C:/workspace/labs/` |
| `CODEX:` | `C:/Users/brian/.codex/memories/` |
| `CODEX_MEMORY` no manifesto JSON | Mesmo diretório de `CODEX:` |
| `CLAUDE-LABS:` | `C:/Users/brian/.claude/projects/C--workspace-labs/memory/` |
| `CLAUDE-PROJECTS:` | `C:/Users/brian/.claude/projects/` |
| `AGY:` | `C:/Users/brian/.gemini/antigravity/` |
| `AGENTS-SKILLS:` | `C:/Users/brian/.agents/skills/` |
| `CODEX-SKILLS:` | `C:/Users/brian/.codex/skills/` |
| `PLUGINS:` | `C:/Users/brian/.codex/plugins/cache/` |
| `CURSOR-SKILLS:` | `C:/Users/brian/.cursor/skills-cursor/` |

Nas referências aos 31 grupos históricos do Codex, `MEMORY.md` e `rollout_summaries/...` resolvem sob **CODEX**, e não sob a raiz do Git. A skill `skills/petjus-spec-homologation/SKILL.md` citada por essas memórias também pertence a **CODEX**, não a `LABS:skills`.

O manifesto [fontes-codex.json](fontes-codex.json) registra os nomes relativos dos 38 resumos, hashes SHA-256, identificadores de sessão, datas e grupos/linhas do índice. Esses metadados permitem conferir o snapshot sem versionar conversas brutas. Um hash prova identidade dos bytes, não a verdade nem a atualidade do relato.

## Codex — cobertura verificada

| Fonte | Consulta / observação | Limite |
|---|---|---|
| `CODEX:memory_summary.md` | Resumo de navegação disponibilizado no contexto; metadado de disco consultado, modificado em 2026-10-03 | Índice compacto, não substitui as fontes específicas |
| `CODEX:MEMORY.md` | Índice pesquisado por labs, skills e instalação; contagem de **31** cabeçalhos `# Task Group:` confirmada; metadado de disco de 2026-10-03 | Contagem de grupos, não contagem de sessões independentes |
| `CODEX:rollout_summaries/*.md` | **38** arquivos Markdown enumerados; procedência detalhada no manifesto | Resumos são históricos; testes, builds, publicação e estados remotos não foram repetidos por este inventário |
| `CODEX:skills/petjus-spec-homologation/SKILL.md` | Frontmatter e instruções iniciais consultados; arquivo com modificação de 2026-09-29 | Procedimento específico de PetJus; presença não implica ativação automática |
| `CODEX:extensions/ad_hoc/notes/` | Lida a nota de preferência de relatórios de 2026-09-21; criada uma nota de atualização desta consolidação em 2026-10-03 | Nenhuma edição direta dos arquivos de memória gerenciados; veja o registro da entrega |

Os trechos históricos sobre instalação de Superpowers, Microsoft, find-skills, Caveman e spec-to-code-compliance ajudam a localizar procedência anterior. A verificação atual confirma presença e, em casos delimitados, igualdade de arquivos; não repetiu downloads, autenticação, revisão remota de commits ou testes operacionais.

## Claude Code — leitura seletiva

No levantamento inicial foram enumerados **9 diretórios de projeto** em `CLAUDE-PROJECTS`. Quatro
continham a subpasta `memory` com arquivos Markdown, somando **22 arquivos**. Os demais cinco não
apresentaram `memory` nessa enumeração. Após a atualização autorizada, labs passou de dois para três
arquivos de memória: foi acrescentado `memorias-ias-em-labs.md` e atualizado o índice. Não se abriu
histórico bruto de sessão.

| Subpasta de projeto | Markdown em `memory` | Cobertura |
|---|---:|---|
| `C--workspace-labs` | 2 | Conteúdo de `MEMORY.md` e `sdd-upstream-em-labs.md` lido para comparar orientação do labs |
| `C--workspace-Freelancer-K-A-O-S` | 4 | Somente nomes e tamanhos; categorias sugeridas pelos nomes: modelo do projeto, status e processo SDD |
| `C--workspace-WWMA-Tech-inscreveai-new-project` | 13 | Somente nomes e tamanhos; categorias: feedback, auditoria, ambiente, fuso, Git e sessões paralelas |
| `C--workspace-WWMA-Tech-petJus` | 3 | Somente nomes e tamanhos; categorias: convenções de código e contexto de campanha |

As categorias dos outros projetos são **inferidas dos nomes de arquivos**, não resultado de auditoria do conteúdo. Não foram copiados dados operacionais, identidades Git, valores de configuração ou conteúdo integral dessas memórias.

### Divergência encontrada na memória de labs

Antes da correção documental desta sessão, `CLAUDE-LABS:sdd-upstream-em-labs.md` mantinha relato de **2026-08-02** com `sdd/constitution.md`, `sdd/templates/`, `sdd/install.ps1` e comandos abreviados `sdd-{spec,plan,tasks,impl,verify}`. Os caminhos `LABS:sdd`, `sdd/constitution.md`, `sdd/templates` e `sdd/install.ps1` foram sondados e não existiam no snapshot. A premissa de labs como upstream continua sustentada por `AGENTS.md`; os caminhos e o modelo de distribuição envelheceram.

A referência atual observada é `.specify/`, `specs/NNN-slug`, `tools/labs.ps1` e as quatro skills
canônicas, com junctions locais Claude/Codex. A etapa de consolidação corrigiu essa nota local e
adicionou uma referência ao acervo. Confira [alterações e verificações](registro-consolidacao.md).

## Antigravity / Gemini — metadados, sem conversas

| Local consultado | Resultado observado | Conteúdo acessado |
|---|---|---|
| `AGY:knowledge/` | Diretório presente; apenas `knowledge.lock` como filho imediato | Somente nome/tipo; lock não aberto |
| `AGY:brain/` | **501 entradas imediatas**, **98 arquivos `*.md` recursivos** | Nomes, contagem e categorias de arquivo; nenhum dump bruto |
| Índices convencionais em `brain/` | Nenhum `README.md`, `index.md` ou `MEMORY.md` encontrado entre os 98 Markdown | Nenhum conteúdo de sessão lido |

Entre os nomes de Markdown há 26 `implementation_plan.md`, 21 `walkthrough.md`, 11 `task.md`, 10 `prompt_draft.md`, 8 `content.md` e relatórios de auditoria/análise. Esses nomes demonstram existência de artefatos, não sua qualidade, conclusão ou pertinência a labs. Não foram exportados UUIDs de sessões, planos privados, conteúdo de tarefas ou relatórios de outros projetos. Ausência de índice convencional não equivale à ausência de memória no produto.

## Cursor, OpenCode e Windsurf — sondagem delimitada

| Assistente | Destinos sondados | Resultado e limite |
|---|---|---|
| Cursor | `~/.cursor`, `~/.cursor/memories`, `~/.cursor/memory`, `~/.cursor/skills`, `~/.cursor/skills-cursor` | Raiz presente; três destinos `memories`, `memory`, `skills` ausentes. `rules` e `skills-cursor` presentes; 26 SKILL.md catalogados. Regras e conversas não foram lidas |
| OpenCode | `~/.opencode`, `~/.config/opencode`, `~/.local/share/opencode` | Primeiro ausente; as duas raízes restantes presentes. Apenas nomes de arquivos e subpastas imediatas foram enumerados |
| OpenCode — memória | `~/.config/opencode/memories`, `~/.config/opencode/memory`, `~/.local/share/opencode/storage/memory` | Nenhum desses três destinos encontrado. Banco de dados, autenticação, logs, snapshots e configurações não foram abertos |
| Windsurf | `~/.codeium/windsurf`, `~/.codeium/windsurf/memories`, `~/.windsurf`, `~/.windsurf/memories` | Os quatro destinos não foram encontrados |

`~` nesta tabela significa `C:/Users/brian`. Não foram pesquisados perfis alternativos, armazenamento em nuvem, `%APPDATA%`, bancos internos de editores ou outras máquinas. Portanto, não há base para afirmar ausência global de memória nesses assistentes.

## Skills, plugins e recursos de labs

O [inventário de skills](inventario-skills.md) contém os caminhos, gatilhos resumidos, duplicações e resolução canônica: **195 SKILL.md físicos** nas cinco bases principais, mais **26** descobertos no Cursor. O cache possui **23 identidades distribuição/plugin**; múltiplas versões e pacotes sem skills também foram registrados. Foram lidos apenas frontmatters do cache, sem configurações de conectores.

| Recurso local | Consulta realizada | Valor e limite |
|---|---|---|
| `LABS:AGENTS.md` e `RULES.md` | Conteúdo lido | Processo, upstream, segurança e limites de publicação; instruções atuais do checkout |
| `LABS:skills/README.md` | Conteúdo lido antes da revisão | Detectada recomendação antiga de cópia recursiva e ausência das quatro canônicas |
| `LABS:skills/{sdd-lifecycle,sdd-audit,sdd-project,sdd-learn}/SKILL.md` | Conteúdo lido | Entradas canônicas; não confundir catálogo com execução do fluxo |
| Recursos referenciados pelas quatro SDD | Existência de `references/{phases,transitions,routing,audits,operations,promotion}.md`, nas respectivas skills, confirmada | Contratos de dependência, sem executar as fases |
| `LABS:.specify/flow.json` e `tools/labs.ps1` | Existência e metadados confirmados | CLI/doctor não executados por este inventário; não atesta saúde de consumidores |
| `LABS:.agents/skills` e `.claude/skills` | Junctions inspecionadas: 4 por diretório | Oito aliases resolvem para quatro pastas canônicas; não contados como cópias |
| `LABS:skills/handoff/SKILL.md` | Conteúdo lido | Reuso por referência a artefatos e sanitização da passagem de contexto |
| `LABS:skills/graphify/SKILL.md` e `AGENTS-SKILLS:graphify/SKILL.md` | Frontmatter/catalogação e comparação de hashes; início do procedimento L lido | Arquivos principais diferentes; nenhum grafo foi reconstruído |
| `LABS:graphify-out/graph.json` e `GRAPH_REPORT.md` | Existência e metadados confirmados, mtime local de 2026-08-27 | Conteúdo não revalidado contra o checkout; mtime não prova data de geração nem completude |
| `CODEX-SKILLS:sanitizar-task-spec/SKILL.md` | Conteúdo lido; script e referências citadas tiveram existência confirmada | Reutilização local por escopo; scanner não executado nesta coleta |

O MemPalace tem inspeção própria em [mempalace-uso.md](mempalace-uso.md). Esse documento distingue o código disponível de uma memória efetivamente inicializada e utilizável.

## Fronteiras de confidencialidade e manutenção

Não integram o pacote: credenciais, tokens, cookies, certificados, arquivos `.env`, dumps, bancos de estado dos assistentes, conversas brutas ou configurações de conexão. O inventário usa nomes de skills, categorias, datas e caminhos suficientes para localizar a fonte. Caminhos pessoais não são portáveis: ao levar estes documentos para outra máquina, remapear as bases, sem copiar perfis inteiros.

Para atualizar: repetir apenas a enumeração nas raízes declaradas, comparar o snapshot e registrar a nova data de coleta. Revalidar o sistema responsável antes de transformar um relato antigo em afirmação atual. Revalidar a fonte oficial antes de aplicar `[OFICIAL]`. Não converter presença no cache em instalação/ativação, nem uma execução de teste em aceite de escopo mais amplo.
