# Oportunidades de autonomia e automação

Propostas `[HIPÓTESE]` elaboradas a partir do acervo consolidado em 2026-10-03. Os casos citados são
evidência histórica `[CAMPO]` do problema; não provam que a melhoria proposta já funciona.
Nenhuma skill, script, hook, monitor ou integração desta página foi criado ou ativado.

**Decisão do responsável em 2026-10-03:** sugestões aceitas, com pedido de apresentação em draft.
A prioridade recomendada passa a ser a direção aprovada para o próximo refinamento. O selo
`[HIPÓTESE]` permanece porque eficácia e ganho ainda não foram medidos. A implementação e a
ativação de cada mecanismo continuam pendentes; esta entrega documenta a decisão.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## Prioridades e critério de escolha

Prioridade considera recorrência nos registros, consequência da falha e possibilidade de reutilizar
o que já existe. Esforço é relativo: **pequeno** significa adaptar documento/template; **médio**
envolve integrar artefatos e validar cenários; **maior** depende de runtime, clientes e operação.
Não há estimativa medida de horas, economia ou retorno financeiro.

| Ordem | Oportunidade | Mecanismo | Reuso principal | Esforço e benefício esperado |
|---|---|---|---|---|
| 1 | Homologação guiada por critério e versão | Fluxo composto + template; script de conferência posteriormente | SDD Audit e skill de homologação PetJus | Médio; reduzir repetição de testes sem objetivo e alegações além da evidência |
| 2 | Passagem de trabalho com próxima ação autorizada | Extensão de handoff + template | handoff e artefatos SDD | Pequeno; reduzir reexploração e perda de decisões entre IAs |
| 3 | Relatório gerencial e anexo técnico a partir das mesmas evidências | Fluxo documental + template | Skill de homologação e ferramentas PDF | Médio; evitar relatórios divergentes e refação da entrega |
| 4 | Detecção de memória desatualizada | Script de comparação + revisão contextual | Manifesto desta coleção, SDD Learn e doctor | Médio; detectar referências quebradas e fatos que exigem nova verificação |
| 5 | Refinamento consistente para tarefas | Composição de skills existentes | SDD Lifecycle, grill-me, to-spec e to-tickets | Pequeno; reduzir tarefas vagas e dependências implícitas |
| 6 | Inventário e seleção de skills | Script de inventário + catálogo | Manifesto do kit e inventário local | Pequeno a médio; evitar instalar duplicatas e escolher cópia incorreta |
| 7 | Preparação de commit e PR | Checklist/template + verificações Git de leitura | RULES.md e convenções atuais | Pequeno; reduzir erros de escopo, autoria e descrição |
| 8 | Acompanhamento de pendências e dependências | Automação agendada de leitura | Matriz de aceite e fontes canônicas de tickets/PRs | Médio; avisar só quando houver mudança acionável |
| 9 | Recuperação semântica do histórico | Piloto de MemPalace | Documentos revisados desta coleção | Maior; avaliar se supera busca textual nos casos reais |

## 1. Homologação guiada por critério e versão

**Problema observado.** As auditorias de [timeline](casos/petjus.md#timeline-clinica),
[resumo clínico](casos/petjus.md#resumo-clinico-pdf),
[assinaturas](casos/petjus.md#assinaturas-a1-png) e
[pagamentos](casos/marketplace.md#spec126-homologacao) repetem a necessidade de distinguir
prova parcial, ambiente e versão. Um teste aprovado não preenche automaticamente o aceite.

**Reutilizar e acrescentar.** Manter SDD Audit (`skills/sdd-audit/SKILL.md`, snapshot local) como procedimento
de auditoria; aproveitar a matriz da skill local de homologação identificada no
[inventário](inventario-skills.md). Acrescentar um template de pacote de evidências no upstream,
com adaptadores por projeto apenas onde as jornadas diferem. Não criar uma segunda skill universal
de auditoria com o mesmo conteúdo.

**Gatilho e entradas.** Pedido de homologação com SPEC, critérios, repositórios/worktrees,
versão examinada, ambiente e operações autorizadas. Se a versão ou o aceite não estiverem claros,
produzir lista de lacunas antes de declarar qualquer aprovação.

**Fluxo e saída.** Mapear critério → jornada → evidência necessária; executar as verificações do
recorte; guardar resultados e limites; gerar matriz com comprovado/parcial/não executado e
achados reproduzíveis. A conclusão deve usar o vocabulário de vereditos da skill vigente.

**Autonomia e parada.** O agente pode inspecionar e executar verificações já autorizadas, sem
alterar produto ou banco compartilhado implicitamente. Se o código mudar durante a coleta,
interromper a conclusão e invalidar somente as evidências afetadas. Ambiente indisponível gera
pendência explícita; não repetir indefinidamente nem substituir a jornada por uma simulação oculta.

**Repetição e aceite.** Associar cada evidência ao critério e à versão, reutilizando-a somente
enquanto suas condições forem válidas. Validar a proposta com casos em que falta um portal,
existe um teste aprovado mas a jornada falha, e o HEAD muda após a coleta. O mecanismo deve impedir
aprovação integral nesses três casos e aceitar uma matriz completa com fontes verificáveis.

## 2. Passagem de trabalho com próxima ação autorizada

**Problema observado.** O [backlog clínico](casos/petjus.md#dependencias-backlog) e o
[avaliador de missões](casos/wakanda-ai.md#avaliador-missoes) exigiram reconstruir dependências,
decisões e limites. Os incidentes de autorização mostram o custo de confundir plano com execução.

**Reutilizar e acrescentar.** Estender o uso de [handoff](../../skills/handoff/SKILL.md), que já
referencia artefatos e orienta sanitização. Adicionar um template curto com objetivo, estado atual,
fontes, decisões abertas, restrições vigentes e próxima ação. A saída temporária segue o destino
da skill; documentos permanentes continuam em seus locais canônicos.

**Gatilho e entradas.** Troca de IA/sessão ou pedido de continuidade. Entradas: tarefa atual,
artefatos, diff, resultado dos comandos e autorização explícita aplicável.

**Fluxo e saída.** Conferir os arquivos referenciados, sintetizar o que falta, indicar quais fatos
precisam ser revalidados e sugerir apenas skills pertinentes. O receptor consulta esses arquivos
antes de executar a próxima ação; o pacote não envia mensagens a outro chat por si só.

**Autonomia e parada.** Preparar o documento e recuperar contexto é permitido no escopo do fluxo.
Publicar, comunicar a terceiros ou executar operação ausente da autorização continua sendo decisão
separada. Conflitos entre documento e estado atual devem ser relatados e resolvidos antes da ação
dependente; uma fonte ausente não deve ser reconstruída por invenção.

**Repetição e aceite.** Usar uma versão identificável do handoff por tarefa, marcando a anterior
como superada em vez de criar cópias indistinguíveis. Testar troca Codex/Cursor com tarefa parcial,
arquivo movido e instrução antiga de publicação. O receptor deve localizar a próxima ação correta
e preservar as restrições sem precisar reproduzir toda a investigação.

## 3. Relatório gerencial e anexo técnico a partir das mesmas evidências

**Problema observado.** A [entrega de backlog](casos/petjus.md#backlog-entrega-gestao) e o caso
[SPEC-126](casos/marketplace.md#spec126-homologacao) mostram que localizar provas não basta para
concluir um relatório. A preferência de público e apresentação está em
[colaboração e gestão](colaboracao-fluxos-gestao.md#entrega-gerencial-e-técnica).

**Reutilizar e acrescentar.** Usar a skill de homologação e as capacidades PDF catalogadas; criar
um template de relatório com capturas e legendas e outro de anexo técnico. Ambos devem consumir
o pacote de evidências da oportunidade 1, sem manter duas listas independentes de resultados.

**Gatilho e entradas.** Pedido de entrega para gestão após uma coleta delimitada, com matriz de
aceite, versão, capturas, documentos inspecionados e limitações.

**Fluxo e saída.** Selecionar demonstrações comprovadas; redigir legendas; gerar PDF gerencial e
anexo; renderizar e conferir legibilidade, cortes e consistência das afirmações. O PDF deve
delimitar o alcance demonstrado; o anexo conserva falhas, comandos, versões e próximos passos.

**Autonomia e parada.** Gerar arquivos locais autorizados; não enviar por e-mail, WhatsApp ou
publicar automaticamente. Se falta captura ou a evidência antecede o código entregue, marcar o
limite e pedir nova coleta apenas onde necessário. Não fabricar prova visual.

**Repetição e aceite.** Identificar pacote de entrada e versão do relatório; repetir a geração
sem duplicar entregas indistinguíveis. Verificar um caso parcial, um sem captura e um com relatório
antigo. O fluxo deve conservar limitações e nunca converter ausência de prova em aprovação. A
renderização final deve permitir ler todas as capturas relevantes e suas legendas.

## Demais oportunidades com escopo mínimo

### 4. Detectar memória desatualizada

- **Origem:** caminhos antigos da memória do Claude e divergência do catálogo, registrados em
  [fontes e cobertura](fontes-e-cobertura.md#divergência-encontrada-na-memória-de-labs).
- **Gatilho/entrada:** revisão solicitada ou alteração da fonte canônica; manifesto e referências.
- **Fluxo/saída:** comparar existência e hashes, classificar fonte alterada/ausente e produzir um
  relatório de revisão. Alteração de hash é sinal, não prova de que o aprendizado ficou falso.
- **Autonomia/falha:** leitura automática pode ser autorizada; atualizar memória exige escopo
  explícito. Se a origem não estiver montada, registrar inacessível, nunca apagar. Deduplicar por
  fonte e revisão. Aceite: detectar caminho movido, preservar ausência transitória e não promover
  uma mudança irrelevante a invalidação sem análise.

### 5. Refinar demandas para tarefas

- **Origem:** [avaliador de missões](casos/wakanda-ai.md#avaliador-missoes).
- **Gatilho/entrada:** demanda e contexto do projeto; passar pelas fases SDD já existentes.
- **Fluxo/saída:** descoberta, esclarecimento, plano e tarefas por história, com regras, aceite e
  dependências. Reusar artefatos existentes antes de gerar novos.
- **Autonomia/falha:** documentar dentro do escopo; não decidir fórmula ou contrato bloqueante por
  adivinhação. Jira segue autorização e regras aplicáveis do projeto. Comparar IDs antes de criar
  ou atualizar tickets. Aceite: cada tarefa tem conclusão observável e dependências sem ciclo.

### 6. Inventariar e selecionar skills

- **Origem:** [fontes de instalação](casos/labs-e-ferramentas.md#skills-fontes) e
  [sobreposições locais](inventario-skills.md#resolução-canônica-e-sobreposições).
- **Gatilho/entrada:** instalação solicitada ou revisão do catálogo; raízes permitidas e manifesto.
- **Fluxo/saída:** enumerar, resolver junctions e comparar os arquivos principais; apontar reuso,
  conflito ou falta. Priorizar o upstream declarado, sem supor equivalência apenas pelo nome.
- **Autonomia/falha:** somente leitura no inventário; não remover duplicatas nem atualizar plugins.
  Caminho inacessível vira lacuna. Aceite: uma junction não conta como cópia, homônimos diferentes
  permanecem visíveis e nova execução não duplica linhas.

### 7. Preparar commits e PRs

- **Origem:** [instruções Git](casos/labs-e-ferramentas.md#instrucoes-git) e
  [autoria de drafts](casos/marketplace.md#autoria-drafts).
- **Gatilho/entrada:** pedido de preparação, diff e regras do repositório.
- **Fluxo/saída:** revisar status, agrupar por finalidade, listar arquivos/linhas, propor mensagens
  e descrever validação. Conferir identidade antes de uma publicação posteriormente autorizada.
- **Autonomia/falha:** preparação não faz stage, commit, push ou PR automaticamente. Se o diff mudar,
  atualizar a proposta antes da aprovação dependente. Aceite: mudanças preexistentes ficam fora do
  agrupamento da tarefa e testes não executados aparecem como tal.

### 8. Acompanhar pendências

- **Origem:** [backlog e entregas](casos/petjus.md#backlog-entrega-gestao).
- **Gatilho/entrada:** monitor explicitamente solicitado, fontes e periodicidade escolhidas.
- **Fluxo/saída:** ler estado de dependências/PRs e comparar com o último estado confirmado; avisar
  só sobre mudança relevante, conclusão, falha ou necessidade de ação humana.
- **Autonomia/falha:** leitura e notificação apenas dentro da autorização. Não alterar tickets,
  mesclar nem repetir a mesma notificação; usar identidade do item e transição observada. Falha de
  acesso não equivale a item concluído. Aceite: estado inalterado fica silencioso e mudança produz
  um único aviso com fonte e data.

### 9. Pilotar MemPalace

O [desenho do piloto](mempalace-uso.md#piloto-recomendado-antes-de-automatizar) define entradas,
comparação, critério de aceite, repetição e limites. Requer preparação operacional maior e deve
vir depois da organização das fontes. Não é pré-requisito para as outras oito melhorias.

## Sequência recomendada

Começar pelas oportunidades **1 e 2**, usando uma SPEC e uma passagem de trabalho reais. Com o
pacote de evidências estável, experimentar a **3**. Medir esforço e falhas antes/depois, sem assumir
economia antecipada. Só então escolher quais verificações de **4, 6 e 7** justificam scripts ou
hooks; reaproveitar **5** no próximo refinamento e avaliar **8** quando houver monitor solicitado.

MemPalace fica como piloto de recuperação aceito para refinamento, ainda sem instalação. As
oportunidades aceitas serão executadas em tarefas delimitadas, com as dependências e critérios
acima. A aceitação desta direção não é autorização permanente para o agente expandir suas ações.
