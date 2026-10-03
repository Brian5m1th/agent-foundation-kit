# Registro da consolidação das memórias

Data: **2026-10-03**, America/Bahia. Trabalho documental autorizado pelo responsável: consolidar
memórias no `labs`, atualizar referências locais acessíveis e propor melhorias posteriores.

## Entrega e origem

O [índice](README.md) organiza preferências, fluxos, gestão, operação, evidências, casos, inventário
e propostas. O [manifesto de procedência](fontes-codex.json) registra 31 grupos de `MEMORY.md` e 38
resumos, incluindo dois que não estavam indexados. Nenhum histórico bruto foi importado.
São **35 casos** em quatro páginas: PetJus (17), WakandaAI (4), marketplace (5), labs/ferramentas (9).
O pacote contém 12 arquivos Markdown e um manifesto JSON.

O [inventário](inventario-skills.md) distingue 195 arquivos `SKILL.md` nas cinco bases principais
e 26 adicionais no Cursor, sem tratar duplicações como capacidades independentes. As outras IAs
foram examinadas no escopo declarado em [fontes e cobertura](fontes-e-cobertura.md).

## Alterações no repositório

| Destino | Alteração da tarefa |
|---|---|
| `docs/memorias-ias/` | Novo acervo organizado, fontes com hashes, casos, avaliação MemPalace e propostas de autonomia |
| `README.md` | Links para o acervo e suas oportunidades |
| `kb/README.md` | Entrada do acervo com selo e escopo |
| `skills/README.md` | Distinção entre skills versionadas e migração SDD observada localmente; retirada da orientação de cópia recursiva indiscriminada |
| `kb/mempalace-memory-system.md` | Qualificação da origem, métricas reportadas e limites de preservação/privacidade |
| `experiments/2026-08-08-mempalace-local-memory-integration/README.md` | Identificação explícita de hipótese e ausência de execução demonstrada no documento |

A branch existente `codex/agent-team-loop` foi mantida. Havia alterações anteriores ao início;
o diff completo da branch não representa esta tarefa. Foi registrado um manifesto de hashes de
389 arquivos preexistentes e guardadas cópias anteriores dos documentos editados para comparação.
Na consolidação inicial não houve criação de branch, commit ou publicação. A etapa posterior de
publicação foi autorizada expressamente, conforme registro abaixo; não altera código dos produtos.

## Memórias locais atualizadas

- **Claude labs:** corrigida `sdd-upstream-em-labs.md`; criado `memorias-ias-em-labs.md`; acrescentado
  o link em `MEMORY.md`. Os três arquivos ficam em
  `C:/Users/brian/.claude/projects/C--workspace-labs/memory/`.
- **Codex:** criada somente a nota
  `extensions/ad_hoc/notes/2026-10-03-consolidacao-memorias-labs.md` na base de memória autorizada.
  A nota solicita indexação do acervo e preserva a preferência por sugestões após a consolidação.
- **Outros clientes:** cobertura e lacunas documentadas. Não foram editados bancos internos,
  conversas, configurações proprietárias ou perfis de outros projetos.

Essas alterações comprovam arquivos gravados, não ingestão automática por todos os clientes.
Os arquivos gerenciados do Codex são preservados; sua incorporação futura da nota depende do
mecanismo de memória do ambiente.

## Verificações da consolidação no checkout de origem

| Verificação executada | Resultado observado |
|---|---|
| `pwsh -NoProfile -File tools/labs.ps1 validate -Target . -Json` | Exit 0 no checkout local com mudanças SDD preexistentes; não comprova o snapshot publicado |
| Conferência delimitada de documentos por script temporário | 12 Markdown; 201 links locais, incluindo âncoras, resolvidos; nenhum erro de codificação, espaço final ou marcador de fonte pendente |
| Cobertura dos casos contra o manifesto | 31/31 grupos e 38/38 resumos representados; 35 casos com âncoras |
| SHA-256 das fontes | 41 arquivos de origem conferidos: registro, 38 resumos, nota de relatório e skill de homologação |
| Preservação do checkout | Dos 389 arquivos anteriores, 384 mantiveram bytes idênticos; somente os cinco documentos listados nesta entrega foram alterados |
| Preservação da memória gerenciada Codex | `MEMORY.md`, `memory_summary.md` e `raw_memories.md` mantiveram seus hashes |
| `git diff --check` nos documentos preexistentes editados | Sem erros de whitespace; arquivos novos também conferidos diretamente |
| Busca delimitada de padrões de segredo e leitura editorial | Nenhum valor sensível detectado no conteúdo novo; isso não equivale a auditoria de segurança de todo o repositório |
| Revisão independente documental por amostragem | Sem achados acionáveis em casos, origens, inventário, propostas e diffs dos cinco arquivos anteriores; registro final conferido pelo executor |

O diff específico desta tarefa foi produzido comparando os cinco documentos com as cópias
anteriores e incluindo somente o novo acervo. Evidências locais temporárias de execução:
`C:/Users/brian/AppData/Local/Temp/labs-memorias-235ebd78c78d4e3d98bedc589e256e0c/` contém
`before.json`, `verification.json`, `validator.json`, `verify_memories.py` e `task.diff`.
Esse diretório não faz parte do repositório nem é necessário para navegar no acervo. O manifesto
de fontes e este registro versionável conservam os resultados; os arquivos temporários podem
deixar de existir numa limpeza do sistema.

As verificações desta tabela são documentais e anteriores à publicação. Não houve execução dos testes dos produtos, instalação de skills,
consulta do estado remoto de PRs ou validação operacional do MemPalace. A comparação de fontes
comprova procedência de bytes e cobertura, não a verdade independente de todo relato histórico.

## Sugestões aceitas e preparação do draft

Após a consolidação, em 2026-10-03, o responsável aceitou as sugestões e pediu um draft. A decisão
foi registrada em `autonomia-e-automacao.md`; não equivale a afirmar que os mecanismos já existem.
A publicação foi preparada separadamente porque a branch atual já pertence a outro PR e existem
dependências SDD locais ainda não publicadas. O responsável aprovou o plano dos três commits e a exceção de tamanho e autorizou prosseguir
e integrar todos os PRs abertos de `Brian5m1th/agent-foundation-kit`. A publicação usa a branch
`docs/memorias-ias` em checkout separado, sem incorporar a migração SDD ainda local.

As [nove oportunidades](autonomia-e-automacao.md) priorizam homologação por critério/versão,
passagem de trabalho e relatório gerencial com anexo técnico. O MemPalace tem um piloto proposto
com fontes selecionadas e comparação com busca textual. Nada foi instalado ou ativado.

O grafo `graphify-out/` não foi reconstruído; esta coleção é navegável pelos índices Markdown.
Os testes dos produtos e a execução dos plugins não foram revalidados. A publicação exige
conferência do diff isolado, links na árvore publicável e checks do GitHub no HEAD correspondente.
As referências SDD ausentes dessa árvore foram qualificadas como inventário local, sem links quebrados.

Na preparação para publicação, os 18 arquivos do lote tiveram 210 links locais conferidos contra
a árvore Git e os arquivos novos explicitamente incluídos; nenhum destino ausente foi encontrado.
Duas revisões documentais independentes (escopo e padrões) não apontaram bloqueios.
O índice da KB também passou a descrever os 22 princípios de um projeto externo sem confundi-los
com identificadores do namespace deste repositório.

Os hooks locais foram mantidos sem alteração. Seu validador exige o kernel SDD preexistente:
esse contexto foi copiado para o checkout separado como suporte local, sem entrar nos commits.
O `validate` retornou exit 0 nesse ambiente. Esse resultado não representa validação integral
do snapshot público pelo kernel ainda não publicado; a checagem do lote publicável é separada.
