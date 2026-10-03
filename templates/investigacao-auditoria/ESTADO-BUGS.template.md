# Fila de Investigação de Achados da Auditoria

Tabela viva de reivindicação de investigações. **Não edite código de produção durante a fase de investigação** (modo somente-leitura `EXE-08`).

## Protocolo de Reivindicação
1. Localize a linha de menor `Prior.` com `Status` = `pendente`.
2. Altere `Status` para `em_investigacao` e coloque seu ID (`sess-XXXX`) e timestamp na coluna `Agente`.
3. Salve e **releia o arquivo**. Se seu ID foi preservado, prossiga. Se foi sobrescrito, pegue a próxima linha.

## Fila de Investigação

| ID | Prior. | Título / Descrição Resumida | Status | Agente | Veredito | Relatório |
|---|---|---|---|---|---|---|
| B1 | F0.1 | Exemplo: Truncamento de payload na borda | pendente | — | — | `B1.md` |
| B2 | F0.2 | Exemplo: Leitura inconsistente de estado inicial | pendente | — | — | `B2.md` |
| G1 | F1.1 | Exemplo: Conexão síncrona travando loop async | pendente | — | — | `G1.md` |

---
*Legenda de Status*: `pendente` · `em_investigacao` · `bloqueado_usuario` · `concluido_ajuste_simples` · `concluido_merece_spec` · `concluido_sem_evidencia_refutado` · `concluido_sem_evidencia_precisa_producao` · `adiado`
