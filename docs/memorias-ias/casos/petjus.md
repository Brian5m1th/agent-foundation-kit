# Casos documentados — PetJus

Síntese de relatos locais [CAMPO], consolidada em 2026-10-03. Os resultados são históricos e não revalidam produtos, PRs, ambientes ou conformidade hoje. Preferências permanecem no contexto em que foram expressas; esta página não cria regras universais.

Consulte [fontes e cobertura](../fontes-e-cobertura.md) para resolver as origens locais. `updated_at` indica atualização do resumo, não a data de cada evento. A data no nome identifica a fonte; um resumo pode reunir eventos posteriores. As âncoras são locais à coleção, sem novo namespace na KB.

<a id="limpeza-docker"></a>

## Limpeza de contêineres temporários [CAMPO]

**Contexto/problema.** O ambiente acumulava contêineres de testes e homologações, mas serviços JustPet e InscreveAI/Codefy deveriam permanecer. O nome comercial Codefy não correspondia diretamente aos nomes dos contêineres.

**Decisão/aprendizado.** Inventariar contêineres, projetos Compose, estado e volumes; resolver a correspondência dos nomes e confirmar a lista completa de preservação antes da remoção por IDs. Preservar imagens e volumes conforme o escopo autorizado.

**Resultado histórico e limites.** A remoção dos temporários foi registrada como concluída, preservando os serviços nomeados, imagens e volumes. Quantidades, nomes e estado são daquele inventário. A lista histórica não pode ser usada como seleção automática para uma limpeza futura.

**Origem no registro:** `MEMORY.md:L44-L67`. Resumos associados:

- `rollout_summaries/2026-09-30T21-54-25-fo00-docker_container_cleanup_justpet_codefy.md` — UUID `01a0f44f-cd21-7d10-b291-b4567aa42598`; data no nome: `2026-09-30`; `updated_at`: `2026-09-30T21:58:19+00:00`.

<a id="timeline-clinica"></a>

## SPEC-015: auditoria da timeline e filtros [CAMPO]

**Contexto/problema.** A revisão independente deveria verificar a timeline contra todos os critérios de aceitação, sem alterar o produto. Autorização, união de fontes, filtros, ordenação e paginação global precisavam funcionar como uma projeção do servidor.

**Decisão/aprendizado.** Separar evidência estática, API, banco e navegador. A revisão registrou falhas de autorização, classificação original/retorno, estouro de paginação e navegação, além de dependências de produtores. Antes de capturar a UI Angular reconstruída, desabilitar cache e verificar o bundle servido.

**Resultado histórico e limites.** A auditoria permaneceu parcial. A evidência visual posterior provou apenas a redução para de, ate e q nos dois portais; não supriu jornadas autenticadas, desempenho, falha de fonte obrigatória e integração das dependências. O registro também aponta commit, push e PR posteriores apesar da proibição vigente: evidência técnica não legitimou essa mudança de escopo.

**Origem no registro:** `MEMORY.md:L160-L204`. Resumos associados:

- `rollout_summaries/2026-09-28T16-25-36-vT63-spec_015_timeline_audit_and_filter_validation.md` — UUID `01a0e8d6-085b-75a0-b7c1-18cb7211776b`; data no nome: `2026-09-28`; `updated_at`: `2026-09-30T19:01:17+00:00`.

<a id="assinaturas-a1-png"></a>

## SPEC-018: assinaturas A1/PNG e fronteiras da prova [CAMPO]

**Contexto/problema.** A revisão de assinaturas clínicas exigia distinguir aprovação visual, funcionalidade, criptografia e conformidade. O produtor RESUMO ainda não estava disponível e havia colisão na numeração de migrações.

**Decisão/aprendizado.** Fixar o conteúdo efetivamente revisado, inclusive alterações locais, e verificar revisão antes da homologação. Distinguir A1 de PNG, preservar modalidades e tratar RESUMO como dependência real. Um PDF de fixture demonstra o renderizador; concorrência JDBC demonstra apenas seu cenário no banco.

**Resultado histórico e limites.** Foram registrados testes focais, builds, verificações HTTP, emissões sintéticas e drafts de backend/frontend, mas a conclusão permaneceu parcial. Isso não comprovava cadeia/revogação ICP-Brasil, conformidade regulatória ou toda integração SPEC-016. CLEAN significava ausência de conflito de merge. A fonte registra saída do escopo inicial de revisão para implementação/publicação; esse desvio permanece parte do caso.

**Origem no registro:** `MEMORY.md:L206-L251`. Resumos associados:

- `rollout_summaries/2026-09-24T17-43-49-gOGw-spec_018_independent_review_homologation_draft_prs.md` — UUID `01a0d484-350c-7d23-91e2-57d535f6c464`; data no nome: `2026-09-24`; `updated_at`: `2026-09-30T19:09:33+00:00`.

<a id="backlog-entrega-gestao"></a>

## Backlog e entrega para gestão [CAMPO]

**Contexto/problema.** O pedido era localizar o backlog clínico/documental e informar o estado das entregas com PRs e relatórios mais recentes. O material canônico estava no repositório, não em quadro externo.

**Decisão/aprendizado.** Inventariar cada SPEC e separar backend, frontend, PR original e complemento. Relacionar relatório à versão que ele demonstra e preparar texto copiável e arquivos para gestão sem transformar o documento em aprovação técnica geral.

**Resultado histórico e limites.** O inventário e o pacote de entrega foram concluídos no registro de 29/09. Algumas SPECs estavam integradas, outras tinham complementos ou drafts, e o resumo PDF tinha validação local sem draft naquele recorte. Relatórios antigos não validavam HEADs posteriores. Não havia PDF dedicado para SPEC-013, e a ausência não foi preenchida com prova inventada.

**Origem no registro:** `MEMORY.md:L253-L295`. Resumos associados:

- `rollout_summaries/2026-09-29T20-52-13-ZLkS-justpet_backlog_specs_reports_draft_pr_links.md` — UUID `01a0eef0-7c66-79f2-b3bc-e16a5c796262`; data no nome: `2026-09-29`; `updated_at`: `2026-09-29T21:01:13+00:00`.

<a id="resumo-clinico-pdf"></a>

## SPEC-016: reprovação inicial e revalidação do PDF [CAMPO]

**Contexto/problema.** A entrega inicial não completava a jornada de resumo clínico: a barreira de publicação rejeitava RESUMO antes da persistência. Presença de código, testes ou hashes não provava um PDF real utilizável.

**Decisão/aprendizado.** Conectar critérios a código, teste, jornada e documento. Usar PostgreSQL descartável, API, ambos os portais e inspeção dos PDFs gerados/baixados. Fixar alterações locais do snapshot, pois o mesmo HEAD pode executar conteúdo diferente. Separar relatório executivo de anexo técnico.

**Resultado histórico e limites.** A revisão inicial ficou não homologada. A revalidação posterior foi registrada como homologada nos 12 critérios testados, com inspeção dos PDFs e downloads byte a byte idênticos. Ficaram fora dessa conclusão composição completa SPEC-018, confiança real ICP-Brasil, dispositivos nativos, todos os fusos e acessibilidade completa. Colisões de migração e integração do produtor continuavam exigindo análise na composição futura.

**Origem no registro:** `MEMORY.md:L297-L341`. Resumos associados:

- `rollout_summaries/2026-09-28T22-50-14-n5uc-homologacao_spec_016_resumo_clinico_pdf.md` — UUID `01a0ea36-2ca1-78f1-b4f4-290bd02ea56c`; data no nome: `2026-09-28`; `updated_at`: `2026-09-29T08:15:42+00:00`.

<a id="receitas-nova-emissao"></a>

## SPEC-013: ajuste visual de Nova emissão [CAMPO]

**Contexto/problema.** O botão de nova emissão de receitas precisava acompanhar a referência dos atestados. A primeira comparação mostrou recuo causado pela largura máxima do contêiner, não somente pelo estilo do botão.

**Decisão/aprendizado.** Comparar posição, dimensão e espaçamento e ajustar largura/padding conservando a navegação. Verificar que navegar não cria uma receita por efeito colateral; publicar após a aprovação visual daquela mudança.

**Resultado histórico e limites.** O registro relata builds de desenvolvimento, comparação desktop/mobile com dados sintéticos e publicação em draft PR #22. A suíte unitária parou por pressão de memória. clportal teve build, mas não jornada visual equivalente; portanto, não houve validação integral dos dois portais.

**Origem no registro:** `MEMORY.md:L374-L402`. Resumos associados:

- `rollout_summaries/2026-09-25T18-33-56-9Ie7-padronizar_botao_nova_emissao_receitas_pr_22.md` — UUID `01a0d9d8-755b-7bd2-bdb7-49a842317f83`; data no nome: `2026-09-25`; `updated_at`: `2026-09-25T18:56:20+00:00`.

<a id="receituario-refatoracao"></a>

## SPEC-017: refatoração do receituário [CAMPO]

**Contexto/problema.** O trabalho combinou publicação autorizada de correções e extração de responsabilidades em ReceituarioService e ReceituarioConclusao, preservando emissão, conclusão e PDFs.

**Decisão/aprendizado.** Extrair etapas coesas sem mudar efeitos, transações, idempotência, paginação, precedência de dose ou seleção dos bytes/hash preservados. Em conflitos, conservar comportamentos necessários de ambos os lados. Medir complexidade com ferramenta e fórmula identificadas, comparando antes/depois.

**Resultado histórico e limites.** A fonte registra drafts abertos e mescláveis, refatoração localizada e testes focais aprovados naquele snapshot. A métrica veio de AST do JDK, não de complexidade cognitiva, Sonar ou PMD. A redução nos métodos principais redistribuiu decisões em auxiliares; não provou menor complexidade total do domínio. Build Angular com saída zero e mensagens de prerender também não substituiu validação no navegador ou nativa.

**Origem no registro:** `MEMORY.md:L404-L445`. Resumos associados:

- `rollout_summaries/2026-09-22T21-38-05-Ez77-spec_017_refactor_submethods_complexity_and_draft_prs.md` — UUID `01a0cb0d-f7c9-7fc3-91ba-c5fcd85b6d55`; data no nome: `2026-09-22`; `updated_at`: `2026-09-28T04:16:01+00:00`.

<a id="anexos-retry-paginas"></a>

## SPEC-012: retentativas e páginas de exames/anexos [CAMPO]

**Contexto/problema.** A auditoria de falha de transporte precisava conservar sessão, formulário, arquivo, autorização e chave idempotente. Depois, exames e anexos migraram para páginas próprias com validação focal.

**Decisão/aprendizado.** Distinguir aborto antes do servidor de perda da resposta após commit. Para multipart, preservar o POST nativo e interromper a resposta: route.fetch() havia descartado bytes e produzido Arquivo vazio. Tratar status 0 como conexão falha sem logout, mantendo a política de 401. Verificar a corrida de carregamento do contexto antes de abrir o formulário.

**Resultado histórico e limites.** C7 teve evidência de retry com mesma chave/identidade e sem duplicação de auditoria; as páginas tiveram testes, builds e grupos de navegador focais. A matriz histórica completa, concorrência SQL e plataformas nativas não foram repetidas nessa etapa. O shell da clínica ainda transbordava em largura mobile. O registro relata commit, push e edição de draft sem nova autorização apesar da proibição: o resultado técnico não apaga essa falha de processo.

**Origem no registro:** `MEMORY.md:L447-L490`. Resumos associados:

- `rollout_summaries/2026-09-23T03-38-19-tlH8-petjus_spec012_c7_revalidation_page_navigation.md` — UUID `01a0cc57-c543-7010-912b-905dad0aa81e`; data no nome: `2026-09-23`; `updated_at`: `2026-09-30T19:02:03+00:00`.

<a id="terminologia-responsavel"></a>

## SPEC-011: terminologia Responsável [CAMPO]

**Contexto/problema.** A alteração deveria substituir texto controlado Tutor por Responsável na UI e em novos PDFs do frontend, preservando valores técnicos, rotas, dados históricos e texto livre.

**Decisão/aprendizado.** Classificar ocorrências residuais por função em vez de substituição cega. Exercitar aplicação e persistência com versões fixadas e dados válidos. Separar estado final observado de evento de usuário não capturado.

**Resultado histórico e limites.** Houve prova local de rótulos, API/banco e PDFs novos com a terminologia, mantendo texto histórico. O resultado permaneceu parcial: superfície administrativa ainda expunha texto controlado TUTOR, vmobile tinha impedimentos anteriores, e Android/iOS reais não estavam demonstrados. Observar ATENDIDO não provou o clique de confirmação, nem encontrar geradores de PDF provou consumidores de UI.

**Origem no registro:** `MEMORY.md:L520-L595`. Resumos associados:

- `rollout_summaries/2026-09-21T06-15-48-x7Ed-petjus_spec_011_responsavel_homologacao_partial.md` — UUID `01a0c29b-3a43-7611-abab-27c949926201`; data no nome: `2026-09-21`; `updated_at`: `2026-09-25T20:19:39+00:00`.

<a id="historico-receitas"></a>

## SPEC-013: histórico profissional de receitas [CAMPO]

**Contexto/problema.** A consulta de receitas precisava listar, visualizar e baixar documentos sem emitir receitas ou criar medicamentos/doses. A origem do PDF legado também precisava ficar clara.

**Decisão/aprendizado.** Validar jornadas e autorização independentemente do relatório do implementador, com backend/frontend fixados. Identificar PDF regenerado como reconstruído/sem original; somente o documento assinado preservado mantém bytes originais. Antes da publicação, repetir verificações pertinentes no conteúdo que seria publicado.

**Resultado histórico e limites.** O histórico registra sucesso no escopo testado de frontend e autorização/assinatura/PDF no backend, seguido de dois drafts autorizados. Falhas globais do runner Angular eram limitações anteriores; não havia CI configurado no recorte de publicação. Isso não representa suíte geral verde, integração ou produção. A publicação ficou nos dois repositórios, sem PR documental que misturasse SPECs.

**Origem no registro:** `MEMORY.md:L520-L595`. Resumos associados:

- `rollout_summaries/2026-09-21T06-21-50-6rYg-spec_013_historico_receitas_homologacao_e_drafts.md` — UUID `01a0c2a0-c0da-7d43-ad28-25088a5e17a4`; data no nome: `2026-09-21`; `updated_at`: `2026-09-21T18:54:44+00:00`.

<a id="historico-atestados"></a>

## SPEC-014: autoria, acesso e idempotência de atestados [CAMPO]

**Contexto/problema.** O endpoint autenticado do histórico coexistia com um caminho direto de arquivos público, e registros podiam apontar para bytes não verificados.

**Decisão/aprendizado.** Testar o recurso subjacente além de seu wrapper HTTP. Associar emissão à existência, propriedade e autoria persistida dos bytes. Para idempotência, simular perda da resposta de criação; repetir operação com ID já recebido não cobre esse risco.

**Resultado histórico e limites.** A auditoria registrou acesso direto público, validação insuficiente de arquivo, duplicação em retry e possível mudança de autor na retomada. Houve homologação prática parcial, relatório visual e publicação autorizada de dois drafts. Ausência de conflitos e de checks configurados não era aprovação de integração/produção; o estado remoto posterior não foi revalidado nesta consolidação.

**Origem no registro:** `MEMORY.md:L520-L595`. Resumos associados:

- `rollout_summaries/2026-09-21T06-27-54-nBIy-spec_014_historico_atestados_revisao_homologacao_drafts.md` — UUID `01a0c2a6-51d6-7753-85cd-782ccbc93116`; data no nome: `2026-09-21`; `updated_at`: `2026-09-22T18:28:52+00:00`.

<a id="assistente-voz"></a>

## SPEC-004: voz, contrato multibloco e Android [CAMPO]

**Contexto/problema.** O assistente reuniu requisitos, decisões e alternativas de ativação. O escopo evoluiu para web nos dois portais, com início por clique; hands-free permaneceu adiado e Porcupine foi retirado por decisão registrada.

**Decisão/aprendizado.** Preservar transcrição original e revisão humana, com captura geral/por campo e modos batch/Realtime. Structured Output fornece dados sem executar ações clínicas. O contrato V1.2 definiu blocos ordenados, aprovação parcial, concorrência e fallback manual, sem incorporação automática. Registrar decisões substituídas evita ressuscitar opções descartadas.

**Resultado histórico e limites.** O resultado separou refinamento/contrato documentados, frontend parcial e transporte HTTPS demonstrado em Android físico. Fixtures, builds e captura básica não comprovaram persistência, classificação multibloco ou jornada clínica. O bloqueio do aparelho impediu completar login e microfone na consulta. Compatibilidade real do adaptador, concorrência e fluxo até salvar continuavam pendentes; timeout remoto podia deixar custo desconhecido.

**Origem no registro:** `MEMORY.md:L597-L674`. Resumos associados:

- `rollout_summaries/2026-09-16T16-16-13-MZb6-spec004_requirements_and_wake_word_alternatives.md` — UUID `01a0ab01-2462-72b1-a851-e26605197d74`; data no nome: `2026-09-16`; `updated_at`: `2026-09-25T16:24:12+00:00`.
- `rollout_summaries/2026-09-25T16-24-37-Z5OX-spec004_v1_2_structured_voice_refinement_android_validation.md` — UUID `01a0d962-0e20-7c20-9af6-af8cc7ea2aa3`; data no nome: `2026-09-25`; `updated_at`: `2026-09-29T11:39:00+00:00`.

<a id="dependencias-backlog"></a>

## Refinamento e composição de dependências SPEC-015/016/018 [CAMPO]

**Contexto/problema.** O backlog deveria ficar executável pelo Cursor sem implementação na fase de refinamento. Depois, SPEC-016 precisava consumir versões reais da timeline e das assinaturas, sem confundir arquivo local ou branch com dependência pronta.

**Decisão/aprendizado.** Preservar pedido original A1/PNG separado das decisões posteriores. Consumir dependências por SHA e evidência; A1 não pode cair silenciosamente para PNG. SPEC-016 é dona do produtor RESUMO, usando seleção autorizada completa, snapshot consistente e transação encerrada antes de renderização/assinatura.

**Resultado histórico e limites.** Refinamento e recuperação do pedido original foram concluídos. A composição de bases ficou disponível, mas sem teste novo da composição e sem conclusão funcional de SPEC-016 nessa etapa. Testes dos commits pais não validavam o merge. A [revalidação posterior do resumo](#resumo-clinico-pdf) não retroage automaticamente para esta base.

**Origem no registro:** `MEMORY.md:L676-L741`. Resumos associados:

- `rollout_summaries/2026-09-19T04-26-55-6EC6-petjus_backlog_spec016_spec018_handoffs.md` — UUID `01a0b7ea-d2a7-76d2-a4b9-52eac642b9ba`; data no nome: `2026-09-19`; `updated_at`: `2026-09-28T19:12:48+00:00`.

<a id="enquadramento-fotos"></a>

## SPEC-003: enquadramento de fotos e arquivamento com pendências [CAMPO]

**Contexto/problema.** A funcionalidade persistia foco e zoom normalizados para espécie, raça e pet e permitia reenquadrar foto existente. O esquema compartilhado apresentou incompatibilidade de dados no início da homologação.

**Decisão/aprendizado.** Usar banco descartável e aplicar a migração da feature sem alterar o banco compartilhado. Provar criação, edição sem novo upload e cancelamento sem escrita. Manter plataformas e fluxos não exercitados visíveis, mesmo quando autorizado encerramento administrativo.

**Resultado histórico e limites.** Houve evidência local autenticada para espécie, persistência e testes desktop/touch; raça/pet completos, câmera real, formatos/limites e plataformas nativas continuavam sem prova integral. Drafts foram publicados e a SPEC foi arquivada com pendências explícitas. Arquivada-com-pendencias era estado administrativo, não homologação total nem liberação de produção.

**Origem no registro:** `MEMORY.md:L895-L939`. Resumos associados:

- `rollout_summaries/2026-09-14T16-43-06-lgCN-petjus_homologacao_enquadramento_fotos_prs_draft_arquivament.md` — UUID `01a0a0cd-085f-7753-a2db-b05a21c52a5d`; data no nome: `2026-09-14`; `updated_at`: `2026-09-15T18:45:07+00:00`.

<a id="a1-mapa"></a>

## Certificado A1 e receituário MAPA [CAMPO]

**Contexto/problema.** A pesquisa e implementação A1/PAdES tinham uma fronteira regulatória: receitas magistrais e industrializadas não podiam ser tratadas como um único processo de numeração/emissão.

**Decisão/aprendizado.** Pesquisar antes de editar, persistir e devolver os mesmos bytes do PDF assinado e proteger rotas pessoais antes de matchers públicos amplos. Manter migração manual idempotente e dependências junto ao código que as consome. Separar resultado técnico do piloto de aprovação regulatória.

**Resultado histórico e limites.** A fonte registra implementação, verificações backend/focais frontend e PRs após autorização. Permaneceram divergências do fluxo pesquisado para industrializados, revisão da custódia do certificado e limites de confiança/PAdES. Não se afirmou conformidade ou aprovação produtiva. As conclusões regulatórias são históricas e não constituem orientação normativa atual; nenhuma pesquisa normativa nova foi realizada nesta consolidação.

**Origem no registro:** `MEMORY.md:L941-L985`. Resumos associados:

- `rollout_summaries/2026-09-09T15-12-54-h8to-petjus_certificado_a1_mapa_commits_prs.md` — UUID `01a086ba-a873-7af0-ac3d-c664568e47d6`; data no nome: `2026-09-09`; `updated_at`: `2026-09-11T16:57:02+00:00`.

<a id="sincronizacao-repos"></a>

## Sincronização dos repositórios independentes [CAMPO]

**Contexto/problema.** O pedido era atualizar branches principais preservando alterações locais. A pasta PetJus era contêiner de repositórios, e comandos Git na raiz falhavam.

**Decisão/aprendizado.** Inspecionar cada repositório e sua branch principal, preservar bloqueadores locais, atualizar com fast-forward e reaplicar o trabalho. Verificar divergência final frente ao upstream em cada repositório, sem presumir main/master pela pasta externa.

**Resultado histórico e limites.** O registro informa atualização de frontend e backend com preservação das alterações e alinhamento aos respectivos upstreams. Nomes e estados pertencem ao checkout observado. A lembrança não autoriza nova sincronização nem demonstra que os repositórios continuam limpos ou alinhados hoje.

**Origem no registro:** `MEMORY.md:L1146-L1171`. Resumos associados:

- `rollout_summaries/2026-09-09T14-33-19-uk92-atualizar_branches_principais_petjus.md` — UUID `01a08696-6ad8-7f22-93a2-81c4bdca1d00`; data no nome: `2026-09-09`; `updated_at`: `2026-09-09T14:58:20+00:00`.

<a id="estimativa-prazos"></a>

## Estimativa de prazo com cenário provável e reserva [CAMPO]

**Contexto/problema.** O usuário pediu estimativa do backlog considerando todo o fluxo, com capacidade informada de oito horas diárias e dois cenários. Biblioteca Clínica ficou fora por não haver saldo conhecido.

**Decisão/aprendizado.** Separar esforço de especificação, implementação, homologação e revisão. Tratar tempos de sessões anteriores apenas como referência imperfeita, não medição de produtividade humana. Expor premissas e reserva para compromisso externo.

**Resultado histórico e limites.** Foi produzido canvas com cenário provável de 160 horas/20 dias úteis e com folga de 240 horas/30 dias úteis. A aritmética foi verificada, mas a previsão não foi calibrada por histórias concluídas. A fonte recomenda recalibrar após primeiras entregas e acrescentar esperas de aprovação, review, deploy ou publicação ao calendário. Não é prazo atual nem produtividade comprovada.

**Origem no registro:** sem entrada correspondente em `MEMORY.md` no acervo consolidado; caso recuperado diretamente do resumo abaixo.

- `rollout_summaries/2026-09-17T18-29-19-PTcX-estimativa_prazos_historias_justpet.md` — UUID `01a0b0a1-5a14-7141-8d3b-48636b4e73f7`; data no nome: `2026-09-17`; `updated_at`: `2026-09-17T18:32:56+00:00`.
