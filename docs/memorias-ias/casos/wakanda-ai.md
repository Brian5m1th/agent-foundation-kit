# Casos documentados — WakandaAI

Síntese de relatos locais [CAMPO], consolidada em 2026-10-03. Os resultados são históricos e não revalidam produtos, PRs ou ambientes hoje. Preferências permanecem no contexto em que foram expressas; esta página não cria regras universais.

Consulte [fontes e cobertura](../fontes-e-cobertura.md) para resolver as origens locais. `updated_at` indica atualização do resumo, não a data de cada evento. A data no nome identifica a fonte; um resumo pode reunir eventos posteriores. As âncoras são locais à coleção, sem novo namespace na KB.

<a id="datas-ciclo-vida"></a>

## Datas de cadastro, atualização e cancelamento [CAMPO]

**Contexto/problema.** WAI-256 precisava expor datas do ciclo de vida do Wakander sem inventar história. O webhook de exclusão da assinatura e a confirmação interna do cancelamento eram eventos diferentes.

**Decisão/aprendizado.** Usar o evento de criação da assinatura como origem do cadastro no fluxo Asaas. Registrar cancelamento somente na transição interna para CANCELADO, como data sem horário, e limpá-lo na volta a REGULAR. Campos históricos sem fonte verificável permaneceram NULL. A alteração alcançou os contratos de resposta.

**Resultado histórico e limites.** Implementação, testes e CI foram registrados, com entrega em draft PR #266 e evidência de fluxo. O deploy ficou pulado e não houve merge no resultado documentado. Uma execução local capturada pela metade não sustentava aprovação; a conclusão usou evidência posterior completa. Isso não completa datas antigas nem comprova o estado atual do PR.

**Origem no registro:** `MEMORY.md:L1-L42`. Resumos associados:

- `rollout_summaries/2026-09-30T22-04-24-ISZm-implement_wakander_lifecycle_dates_pr_266.md` — UUID `01a0f458-f039-7792-b387-25b356f33274`; data no nome: `2026-09-30`; `updated_at`: `2026-10-02T16:56:23+00:00`.

<a id="jornadas-sequenciais"></a>

## Jornadas sequenciais por Trilha [CAMPO]

**Contexto/problema.** WAI-396 identificou matrícula em todas as jornadas ativas e uma migração antiga com CROSS JOIN. Conclusões concorrentes e jornadas adicionadas depois da matrícula também precisavam ser tratadas.

**Decisão/aprendizado.** Escolher a menor ordem ativa da Trilha; ao concluir, recarregar o catálogo e selecionar a próxima jornada elegível não iniciada. Transação, bloqueios e unicidade protegem a criação concorrente. A migração corretiva preserva história e interrompe situações ambíguas. Missão seguinte inelegível fica pendente sem desfazer a conclusão válida.

**Resultado histórico e limites.** O registro relata validação focal, integrações PostgreSQL, cenários de migração e fluxos no navegador; commits aguardavam aprovação. A própria sessão registrou implementação antes da aprovação solicitada como falha de processo. Durabilidade SNS/outbox era limitação anterior e não virou escopo da correção.

**Origem no registro:** `MEMORY.md:L69-L100`. Resumos associados:

- `rollout_summaries/2026-09-30T03-11-01-uIlf-wai_396_jornadas_sequenciais_por_trilha.md` — UUID `01a0f04b-4ac5-7313-af13-79ed0be2cbb5`; data no nome: `2026-09-30`; `updated_at`: `2026-09-30T04:29:02+00:00`.

<a id="avaliador-missoes"></a>

## Refinamento do avaliador de missões [CAMPO]

**Contexto/problema.** A descoberta tratava de determinar XP e Sabedorias do catálogo de missões, não de avaliar uma entrega do Wakander. Havia proposta de Spring AI sobre uma base com LangChain4j e integrações Memberkit/N8N.

**Decisão/aprendizado.** Rastrear primeiro um fluxo existente e então explicitar Boundary, Contract, Guardrails e Acceptance. Separar porta de IA por finalidade, adaptação externa e validação determinística. Deixar fórmula, rubrica, autoridade da IA, reavaliação, persistência e compatibilidade do SDK como decisões explícitas, sem inventá-las.

**Resultado histórico e limites.** Foram produzidos prompt reutilizável, descoberta, SDD, diagramas e decomposição para discussão no Jira. O material permaneceu rascunho em revisão, sem implementação ou criação automática de tickets. Validação documental não demonstrava compatibilidade Spring AI, qualidade da avaliação ou comportamento produtivo. N8N só estava comprovado como integração de ID/URL.

**Origem no registro:** `MEMORY.md:L102-L158`. Resumos associados:

- `rollout_summaries/2026-09-30T01-19-01-0fTX-refinamento_sdd_avaliador_automatico_de_missoes.md` — UUID `01a0efe4-c24d-7fe1-bff3-cab53071ba39`; data no nome: `2026-09-30`; `updated_at`: `2026-09-30T04:20:54+00:00`.
- `rollout_summaries/2026-09-30T01-11-21-jmg6-prompt_arquitetural_sdd_agente_avaliador_missao.md` — UUID `01a0efdd-bb1d-7a82-9a43-904c38a46aa6`; data no nome: `2026-09-30`; `updated_at`: `2026-09-30T01:17:22+00:00`.

<a id="arquitetura-camadas"></a>

## Arquitetura em camadas e orientação de refatoração [CAMPO]

**Contexto/problema.** O usuário queria transportar princípios do WakandaAI para outro projeto e depois restringiu a explicação a Entity, Service e Repository. A análise usou o fluxo real TipoMissao.

**Decisão/aprendizado.** Distinguir contratos de suas implementações: Service/ApplicationService e Repository/InfraRepository não acrescentam chamadas intermediárias. Manter adaptação HTTP na borda, coordenação e transação no caso de uso, invariantes no domínio e detalhes JPA na infraestrutura. Refatorar preservando contratos e comportamento, com verificação incremental.

**Resultado histórico e limites.** O resultado foi orientação e prompt, não refatoração aplicada. A análise registrou acoplamentos entre domínio, DTOs e erros HTTP. APIException com HttpStatus era escolha local, não regra geral de DDD; documentação arquitetural não provava aplicação uniforme de transações, idempotência ou ACL. Consulta prévia de duplicidade não substituía unicidade no banco sob concorrência.

**Origem no registro:** `MEMORY.md:L743-L790`. Resumos associados:

- `rollout_summaries/2026-09-19T04-03-47-8hdX-arquitetura_camadas_prompt_refatoracao_spring.md` — UUID `01a0b7d5-a5fb-7af1-bad7-16991622d3f5`; data no nome: `2026-09-19`; `updated_at`: `2026-09-20T03:23:04+00:00`.
- `rollout_summaries/2026-09-18T06-37-33-ayUQ-wakandaai_entity_service_repository_architecture_rules.md` — UUID `01a0b33c-0fd3-7940-abac-20f7827fd33c`; data no nome: `2026-09-18`; `updated_at`: `2026-09-20T03:35:33+00:00`.
