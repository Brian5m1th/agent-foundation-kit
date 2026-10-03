# Colaboração, fluxos e gestão

Síntese `[CAMPO]` de preferências e práticas registradas; coleta em 2026-10-03. As referências
`MEMORY.md:Lx-Ly` são resolvidas pelo [mapa de fontes](fontes-e-cobertura.md). As datas históricas
e resumos de origem estão no [manifesto](fontes-codex.json) e nas páginas de casos.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## Colaboração e autorização

| Contexto | Aprendizado | Fonte e limite |
|---|---|---|
| Planejamento e refinamento | Entregar contratos, critérios, dependências e perguntas abertas antes de implementar quando esse for o escopo solicitado. | `MEMORY.md:L102-L159`, refinamento de missões de setembro de 2026. Documentar não autoriza mudar produto. |
| Execução já autorizada | Concluir o recorte acordado preservando trabalho alheio; dúvidas locais reversíveis podem ser registradas como premissas. | Plano aprovado nesta conversa em 2026-10-03; [AGENTS.md](../../AGENTS.md), P04/ADR-002. Não ampliar contrato, schema ou segurança por inferência. |
| Git e publicação | Antes de um commit solicitado, apresentar o agrupamento por finalidade com arquivos e linhas e obter a aprovação exigida pelo responsável. Commit, push, PR e merge são ações distintas. | `MEMORY.md:L84-L99` e `L1208-L1247`; [RULES.md](../../RULES.md), RGIT. Preferências históricas devem ser reconciliadas com autorização explícita vigente. |
| Auditoria recebida do Cursor | Examinar o que foi entregue e fornecer achados reproduzíveis, sem converter revisão em implementação. | `MEMORY.md:L492-L595`; auditorias PetJus em setembro de 2026. O escopo deve dizer quando correção é permitida. |

Comunicação: usar português claro, indicar resultado e evidência, distinguir concluído, parcial,
bloqueado e não executado. Evitar substituir uma lacuna por uma afirmação confiante.

## Fluxos que já existem

O fluxo SDD canônico está em [AGENTS.md](../../AGENTS.md), no
manifesto (`.specify/kit.json`, snapshot local), na máquina de estados (`.specify/flow.json`, snapshot local) e nas
skills. Este acervo não redefine sua ordem nem mantém uma segunda implementação.

| Trabalho | Reutilizar | Aprendizado que deve acompanhar |
|---|---|---|
| Descobrir uma demanda | SDD Lifecycle (`skills/sdd-lifecycle/SKILL.md`, snapshot local) e documentação do projeto | Rastrear um fluxo existente completo antes de escolher uma solução. Separar realidade observada de proposta. |
| Refinar escopo e contrato | SDD Lifecycle; [grill-me](../../skills/grill-me/SKILL.md) quando pertinente | Escrever problema, exclusões, decisões pendentes e aceite verificável. No caso WakandaAI, avaliação da missão e avaliação da entrega eram coisas diferentes. |
| Planejar e decompor | SDD Lifecycle e templates canônicos | Histórias entregáveis, dependências explícitas e tarefas verificáveis. Preservar o formato exigido pelo ticket. |
| Auditar artefatos ou implementação | SDD Audit (`skills/sdd-audit/SKILL.md`, snapshot local) | Distinguir `analyze` de `converge`; este exige contexto independente do executor. |
| Preparar continuidade entre IAs | [handoff](../../skills/handoff/SKILL.md) | Referenciar spec, decisões e evidências em vez de copiar documentos. Informar estado exato e próxima ação autorizada. |
| Aprender com um incidente | SDD Learn (`skills/sdd-learn/SKILL.md`, snapshot local) | Uma nota não garante prevenção. A promoção para proteção executável requer escopo e prova de eficácia. |

Fontes históricas: `MEMORY.md:L102-L159`, `L520-L595`, `L676-L741` e `L866-L893`.
As páginas [WakandaAI](casos/wakanda-ai.md), [PetJus](casos/petjus.md) e
[labs](casos/labs-e-ferramentas.md) preservam o contexto de aplicação.

## Gestão de backlog e tarefas

`[CAMPO]` Em PetJus, o backlog canônico estava no repositório; presumir um quadro externo atrasava
a localização. Uma SPEC podia ter backend incorporado e frontend pendente, ou um PR original
incorporado com complemento aberto. Fonte: `MEMORY.md:L253-L295`, registros de setembro de 2026.

Para recuperar uma entrega, identificar projeto, SPEC/ticket, dependências, estado por componente,
evidência disponível e próxima ação. Links de PR e relatórios precisam de verificação de atualidade;
o estado remoto antigo é apenas histórico.

`[CAMPO]` No refinamento WakandaAI, a decomposição preservou Como/Quero/Para, regras, cenários e
anexos, com dependências entre tarefas. Fonte: `MEMORY.md:L102-L159`. A decisão daquele trabalho
era produzir material para Jira sem criar tickets. Isso não cancela a regra atual de sincronização
Jira do [AGENTS.md](../../AGENTS.md) em trabalhos que efetivamente estejam no fluxo aplicável.

## Entrega gerencial e técnica

`[CAMPO]` Preferência expressa em 2026-09-21: relatório para a chefia em PDF, visual cuidado,
capturas legíveis e legendadas, centrado no funcionamento demonstrado. Detalhes de desenvolvimento,
SHAs, testes internos, problemas e pendências seguem no chat ou anexo técnico. Fonte local:
`extensions/ad_hoc/notes/2026-09-21T180906Z-relatorios-chefia-provas-visuais.md:L3-L8`.

Essa separação de público não permite declarar aprovação completa de escopo parcial. O relatório
gerencial deve identificar o alcance demonstrado; o anexo técnico conserva critérios não provados,
ambiente, versão, reprodução e devolutiva para o executor. Fonte adicional: `MEMORY.md:L520-L595`.

## O que não deve ser generalizado

Decisões de domínio como cancelamento, obrigatoriedade de datas, regras de pagamento e validade de
documentos pertencem ao projeto e ao momento registrado. Convenções do `labs` e decisões de um
projeto consumidor podem divergir; registrar a diferença e seguir a autoridade aplicável, em vez de
reescrever retrospectivamente o caso para fazê-lo parecer conforme.
