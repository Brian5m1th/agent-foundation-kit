# Casos documentados — Labs e ferramentas

Síntese de relatos locais [CAMPO], consolidada em 2026-10-03. Os resultados são históricos e não revalidam ferramentas, instalações ou ambientes hoje. Preferências permanecem no contexto em que foram expressas; esta página não cria regras universais.

Consulte [fontes e cobertura](../fontes-e-cobertura.md) para resolver as origens locais. `updated_at` indica atualização do resumo, não a data de cada evento. A data no nome identifica a fonte; um resumo pode reunir eventos posteriores. As âncoras são locais à coleção, sem novo namespace na KB.

<a id="triagem-local"></a>

## Scanner local de task/SPEC [CAMPO]

**Contexto/problema.** O usuário rejeitou integração Sonar e pediu triagem universal, local e limitada à task, sem servidor, token, upload ou instalação automática.

**Decisão/aprendizado.** Usar manifesto explícito de arquivos e faixas de linhas, scanner somente de leitura e relatórios com seleção, hashes, estado e limitações. Rejeitar entradas inseguras/inválidas e separar candidatos heurísticos de defeitos confirmados e de problemas anteriores.

**Resultado histórico e limites.** A skill/script foi ajustada e teve testes isolados e validação estrutural registrados. Saída zero significava geração de relatório, não aprovação. Arquivos ignorados podiam tornar o resultado parcial. Regex/AST não mediam aceitação funcional, segurança completa, SOLID, idempotência ou Quality Gate; falsos positivos precisavam de revisão.

**Origem no registro:** `MEMORY.md:L343-L372`. Resumos associados:

- `rollout_summaries/2026-09-24T20-05-13-OgPi-ajuste_skill_sanitizacao_script_local.md` — UUID `01a0d505-a8e0-7d70-b3c4-9396cd0b9f9c`; data no nome: `2026-09-24`; `updated_at`: `2026-09-24T20:47:51+00:00`.

<a id="prompt-qualidade"></a>

## Prompt de revisão pós-implementação [CAMPO]

**Contexto/problema.** O pedido buscava revisão de Clean Code, SOLID, SRP, idempotência e tamanho de métodos no escopo de uma SPEC concluída.

**Decisão/aprendizado.** Ler intenção e diff antes de refatorar. Usar tamanho de método como alerta de investigação, não objetivo isolado; extrair responsabilidades coesas e conservar efeitos, ordem, exceções e transações. Uma lacuna de idempotência que altera comportamento deve ser explicitada como mudança própria.

**Resultado histórico e limites.** Foi entregue um prompt reutilizável. Não houve refatoração aplicada nem validação do produto nessa sessão. Uma aplicação futura precisaria de testes antes/depois, build, revisão de diff e provas de retry/concorrência apropriadas, sem converter o prompt em certificado de qualidade.

**Origem no registro:** `MEMORY.md:L492-L518`. Resumos associados:

- `rollout_summaries/2026-09-23T15-31-29-1Ypa-prompt_revisao_spec_clean_code_solid_srp_idempotencia.md` — UUID `01a0cee4-b173-7a00-9c0b-605942155ab0`; data no nome: `2026-09-23`; `updated_at`: `2026-09-23T15:36:06+00:00`.

<a id="skills-fontes"></a>

## Origem, download e instalação seletiva de skills [CAMPO]

**Contexto/problema.** O pedido reuniu identificação de fontes, organização de coleções e instalação de capacidades escolhidas. O nome de um toolkit ou coleção não garantia que houvesse uma skill instalável.

**Decisão/aprendizado.** Confirmar origem e revisão, procurar SKILL.md e instalar seletivamente sem sobrescrever destinos existentes. Distinguir documentação/templates, skill individual, coleção e plugin com hooks. Comparar bytes/objetos de origem e destino para provar integridade da cópia.

**Resultado histórico e limites.** O registro relata download do Vibe Coding Toolkit e instalação selecionada de Superpowers, Find Skills e microsoft-docs com proveniência e integridade verificadas. Isso não demonstrava ativação no mesmo turno nem comportamento de todas as skills. Dependências para consulta Microsoft Learn não estavam configuradas/testadas; instalação não provava consulta externa funcional.

**Origem no registro:** `MEMORY.md:L792-L836`. Resumos associados:

- `rollout_summaries/2026-09-17T15-57-48-PjVj-clone_toolkit_install_superpowers_skills.md` — UUID `01a0b016-a1b3-7df3-9fd3-1b35b4664f55`; data no nome: `2026-09-17`; `updated_at`: `2026-09-17T16:01:48+00:00`.
- `rollout_summaries/2026-09-16T19-45-53-iBB9-instalar_skills_microsoft_find_skills.md` — UUID `01a0abc1-18e7-7032-8b6c-4a553a649e23`; data no nome: `2026-09-16`; `updated_at`: `2026-09-16T19:51:09+00:00`.

<a id="caveman-plugin"></a>

## Instalação do plugin Caveman no Codex [CAMPO]

**Contexto/problema.** O usuário escolheu Codex como host. Uma ausência no catálogo de busca não provava ausência do plugin em uma origem Git conhecida.

**Decisão/aprendizado.** Usar mecanismo nativo do host solicitado, registrar origem/revisão e verificar listagem de instalado/habilitado. Comparar arquivo instalado com a origem por hash para delimitar a prova obtida.

**Resultado histórico e limites.** O registro relata plugin instalado e habilitado, com correspondência de bytes à revisão escolhida. É comprovação de instalação/integridade daquele snapshot, não benchmark de economia, demonstração de todos os workflows ou inventário atual do ambiente. Nenhuma instalação foi refeita nesta consolidação.

**Origem no registro:** `MEMORY.md:L838-L864`. Resumos associados:

- `rollout_summaries/2026-09-17T17-46-14-phEh-install_caveman_codex_plugin.md` — UUID `01a0b079-ea2e-79d3-abfa-86873ee43fad`; data no nome: `2026-09-17`; `updated_at`: `2026-09-17T17:49:29+00:00`.

<a id="comandos-sdd"></a>

## Explicação das etapas SDD [CAMPO]

**Contexto/problema.** O usuário pediu uma sequência concisa das etapas de especificação e seus comandos.

**Decisão/aprendizado.** Apresentar constitution, specify, plan, tasks, implement e converge, distinguindo intenção de tecnologia e auditoria de artefatos de auditoria de implementação. Citar clarify, analyze, loop e checklist como etapas auxiliares conforme o fluxo descrito.

**Resultado histórico e limites.** A resposta informativa foi concluída. A sessão não verificou instalação ou execução dos comandos nem alterou o repositório. A sequência deve ser confrontada com skills e instruções atuais antes de execução; a explicação histórica não comprova disponibilidade operacional.

**Origem no registro:** `MEMORY.md:L866-L893`. Resumos associados:

- `rollout_summaries/2026-09-16T18-21-17-XM68-sdd_stages_and_commands.md` — UUID `01a0ab73-a4b5-7672-b04d-3daead794da4`; data no nome: `2026-09-16`; `updated_at`: `2026-09-16T18:21:43+00:00`.

<a id="skill-compliance"></a>

## Instalação da skill spec-to-code-compliance [CAMPO]

**Contexto/problema.** O pedido era localizar e instalar a skill Trail of Bits que confronta implementação com especificação.

**Decisão/aprendizado.** Confirmar origem oficial e subdiretório correto, usar o instalador e verificar SKILL.md no destino. Diferenciar sucesso da instalação de auditoria efetivamente executada.

**Resultado histórico e limites.** A instalação e a presença do artefato foram registradas como concluídas. O caso não constitui execução de compliance em PetJus nem prova de disponibilidade atual. Caminhos e revisão precisam ser verificados novamente antes de reinstalar; o destino existente deve ser preservado.

**Origem no registro:** `MEMORY.md:L1123-L1144`. Resumos associados:

- `rollout_summaries/2026-09-09T16-06-52-vDm6-install_trail_of_bits_spec_to_code_compliance.md` — UUID `01a086ec-0f79-7e21-9f08-3d3a73d37b2e`; data no nome: `2026-09-09`; `updated_at`: `2026-09-09T16:08:02+00:00`.

<a id="instrucoes-git"></a>

## Instruções de commit e PR por finalidade [CAMPO]

**Contexto/problema.** O usuário pediu blocos copiáveis para orientar commits e PRs e corrigiu a sugestão de um commit por task.

**Decisão/aprendizado.** Agrupar alterações coesas por funcionalidade/finalidade, separando mudanças independentes. Para PR, descrever problema resolvido e comportamento final a partir do diff completo e template vigente. Tratar commit, push, PR e merge como ações distintas; não inventar testes ou acrescentar atribuição de IA.

**Resultado histórico e limites.** Foram entregues instruções em português. A preferência por agrupamento funcional foi correção explícita daquela conversa, não nova regra canônica introduzida por esta página. Em uso futuro, ler regras atuais e autorização concreta; este relato não altera RULES.md nem resolve conflitos de governança em silêncio.

**Origem no registro:** `MEMORY.md:L1208-L1247`. Resumos associados:

- `rollout_summaries/2026-09-10T22-16-55-MQN0-codex_commit_and_pull_request_instructions.md` — UUID `01a08d65-3525-7c63-bde5-718f1411f88e`; data no nome: `2026-09-10`; `updated_at`: `2026-09-10T22:21:20+00:00`.

<a id="certificado-local"></a>

## Validação local de certificado A1 [CAMPO]

**Contexto/problema.** O usuário pediu inspeção de um PKCS#12 e extração de identificadores. O arquivo estava acessível por caminho explícito fora do workspace.

**Decisão/aprendizado.** Importar com armazenamento efêmero e separar presença da chave privada, teste de assinatura/verificação e intervalo de validade da confiança da cadeia e revogação. OIDs permitiram localizar identificadores, mas valores, senha e caminho pessoal não integram o aprendizado persistido.

**Resultado histórico e limites.** O registro demonstra uso criptográfico local do arquivo/chave, enquanto cadeia/revogação permaneceram inconclusivas com erros como PartialChain e OfflineRevocation. Isso não permitia concluir confiança ICP-Brasil completa, nem declarar o certificado inválido somente pela indisponibilidade da cadeia. Nenhum certificado foi reaberto ou revalidado nesta consolidação.

**Origem no registro:** `MEMORY.md:L1249-L1276`. Resumos associados:

- `rollout_summaries/2026-09-10T22-10-59-ivhD-validate_brazilian_a1_certificate.md` — UUID `01a08d5f-c6fb-7840-ad38-565956934151`; data no nome: `2026-09-10`; `updated_at`: `2026-09-10T22:13:23+00:00`.

<a id="toolkit-java-angular"></a>

## Análise do toolkit e adaptação Java/Angular [CAMPO]

**Contexto/problema.** O usuário pediu avaliação de um toolkit de prompts/templates e do que poderia ser adaptado para Java/Spring e Angular.

**Decisão/aprendizado.** Testar regras executáveis, incluindo contraexemplos, antes de transportar recomendações. Foram encontrados falsos positivos/negativos em console, isenção por nome index.ts e acesso a dados por importação dinâmica. Separar mecanismos reutilizáveis das adaptações por stack: compilação de templates Angular, fronteiras arquiteturais e baselines executáveis em Java.

**Resultado histórico e limites.** A análise e as recomendações foram concluídas sem alterar templates. Testes do toolkit não validavam compatibilidade em projeto Java/Angular real. Sugestões de angular-eslint, ArchUnit, PMD, Checkstyle, SpotBugs e Spring Modulith são resultado histórico da pesquisa, não recomendação atual revalidada. Arquivos distintos também não garantiam independência funcional: paralelismo full-stack exigia contrato comum.

**Origem no registro:** sem entrada correspondente em `MEMORY.md` no acervo consolidado; caso recuperado diretamente do resumo abaixo.

- `rollout_summaries/2026-09-17T16-08-15-MFHF-analyze_vibe_coding_toolkit_java_angular_adaptation.md` — UUID `01a0b020-3494-7a81-8f7f-701f8934b267`; data no nome: `2026-09-17`; `updated_at`: `2026-09-17T22:30:19+00:00`.
