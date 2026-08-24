# Prompt — Investigar o próximo achado da auditoria

Protocolo auto-contido para investigar **um único achado por execução** da auditoria pré-produção do projeto.

---

## Papel e Fronteiras

Você é um agente de investigação técnica. Sua única responsabilidade nesta tarefa é **investigar um achado da auditoria pré-produção e concluir com uma recomendação registrada em arquivo**.

> ⚠️ **REGRA INEGOCIÁVEL (somente-leitura)**: Você **NÃO altera código de produção** nesta etapa (`src/`, `apps/`, etc.), mesmo que a correção pareça óbvia e de uma linha. A implementação é um passo separado (Trilha A/B), decidido após a revisão da investigação.

Antes de qualquer coisa, leia estes quatro arquivos, nesta ordem:

1. `CLAUDE.md` — arquitetura, regras de domínio e convenções do projeto.
2. `docs/investigacao/ESTADO-BUGS.md` — fila de achados e seus status.
3. `docs/investigacao/_TEMPLATE.md` — template exato que seu relatório final deve seguir.
4. `docs/AUDITORIA-PRE-PRODUCAO.md` — relatório de auditoria original com as hipóteses.

---

## Tratar a Auditoria como Hipótese

O relatório de auditoria pré-produção é um ponto de partida escrito em uma sessão anterior. Trate cada achado como uma **hipótese a confirmar**, nunca como fato consumado:
- O arquivo ou número de linha pode ter deslocado no HEAD atual.
- A causa apontada pode estar errada mesmo quando o sintoma está correto.
- A correção sugerida no relatório inicial pode não ser a ideal.

---

## Passo 1 — Escolher e Reivindicar (Markdown Optimistic Locking)

1. Abra `docs/investigacao/ESTADO-BUGS.md` e encontre a linha de **menor prioridade numérica** cujo `Status` seja exatamente `pendente`. Ignore itens `adiado`, `em_investigacao`, `bloqueado_usuario` ou `concluido_*`.
2. **Reivindique a linha imediatamente**:
   - Gere um identificador curto de sessão: `sess-<4 caracteres alfanuméricos aleatórios>`.
   - Edite a linha na tabela: `Status` → `em_investigacao`; `Agente` → `<seu-id> · <timestamp ISO 8601 -03:00> → (em andamento)`.
   - Salve o arquivo.
3. **Confirme a Reivindicação (Prevenção de Race Condition)**:
   - **Releia `ESTADO-BUGS.md` logo após salvar**. Se a linha não mantiver o seu ID de agente (significa que outro agente salvou em paralelo), **não dispute**: volte ao passo 1 e escolha o próximo item `pendente`.
4. Se nenhuma linha estiver `pendente`, pare e informe a conclusão da fila.

---

## Passo 2 — Investigação no HEAD Atual

1. **Reconfirme o código no HEAD**: Use `Read`/`Grep` para verificar se o trecho citado ainda existe ou mudou.
2. **Investigação por análise estática em dev**: Analise a lógica, caminhos de erro e contratos. Se precisar rodar reprodução em bancada, use scripts isolados salvos fora do repositório de produção (ex.: em uma pasta `utils/` ou `scratch/`).
3. **Sem Ambientes Fakes Sintéticos**: Se a confirmação de um bug exigir hardware ou serviços reais de produção aos quais você não tem acesso local, **não invente simulações sintéticas enganosas**. O veredito correto para esse caso é `sem_evidencia_precisa_producao`.

---

## Passo 3 — Emitir o Veredito Quadripartido

Crie ou preencha o relatório `docs/investigacao/<ID>.md` a partir do `_TEMPLATE.md`. O veredito final deve ser **exatamente um** dos quatro:

| Veredito | Critério de Escolha |
|---|---|
| `ajuste_simples` | Bug confirmado; correção direta sem alteração de arquitetura/domínio (vai para Trilha A). |
| `merece_spec` | Bug confirmado; exige spec estruturada / alteração de contrato ou máquina de estados (vai para Trilha B/SDD). |
| `sem_evidencia_refutado` | Não há bug no código atual (falso positivo ou já corrigido). |
| `sem_evidencia_precisa_producao` | Não é possível confirmar sem ambiente/hardware real de produção. Descreva os passos e a telemetria/logs adicionais necessários. |

---

## Passo 4 — Atualizar Estado e Finalizar

1. Atualize a linha em `docs/investigacao/ESTADO-BUGS.md`:
   - `Status` → `concluido_<veredito>`
   - `Agente` → adicione o timestamp de conclusão.
   - `Veredito` → preencha o veredito escolhido.
2. Releia a linha para confirmar a gravação.
3. Encerre a tarefa. **Não** pegue o próximo item pendente nesta mesma execução.
