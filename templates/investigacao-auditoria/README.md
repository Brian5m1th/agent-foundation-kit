# Kit de Investigação e Auditoria Pré-Produção Multi-Agente

Este diretório contém o kit reutilizável para auditorias de código end-to-end, caça de bugs, e fluxo de resolução em dupla trilha com proteção contra race conditions em execuções multi-agente.

> **Origem**: Destilado do projeto `auto-slide` e incorporado ao `labs` como standard de AI Engineering (`EXE-08`, `VER-08`, `PLN-07`, `AP-45`).

## Estrutura do Kit

| Arquivo | Função |
|---|---|
| [`PROMPT-AGENTE-INVESTIGACAO.md`](PROMPT-AGENTE-INVESTIGACAO.md) | Protocolo de investigação de bug **somente-leitura** com reivindicação atômica em Markdown |
| [`PROMPT-AGENTE-IMPLEMENTACAO.md`](PROMPT-AGENTE-IMPLEMENTACAO.md) | Protocolo de implementação em **Dupla Trilha** (Trilha A: Plan Mode vs. Trilha B: SDD/Spec Kit) |
| [`ESTADO-BUGS.template.md`](ESTADO-BUGS.template.md) | Fila de investigações com trava otimista em Markdown (`sess-XXXX`) |
| [`ESTADO-IMPLEMENTACAO.template.md`](ESTADO-IMPLEMENTACAO.template.md) | Fila de implementação com matriz de trilhas (A/B) e satélites |
| [`_TEMPLATE_RELATORIO.md`](_TEMPLATE_RELATORIO.md) | Template padronizado do relatório de investigação (`<ID>.md`) |
| [`investigacao-somente-leitura.mdc`](investigacao-somente-leitura.mdc) | Regra `.mdc` do Cursor/AI Agent para enforçar modo read-only durante o diagnóstico |

## Como instalar em um novo projeto

1. Copie o conteúdo desta pasta para `docs/investigacao/` no projeto destino:
   - `docs/investigacao/PROMPT-AGENTE-INVESTIGACAO.md`
   - `docs/investigacao/PROMPT-AGENTE-IMPLEMENTACAO.md`
   - `docs/investigacao/ESTADO-BUGS.md` (renomeado de `ESTADO-BUGS.template.md`)
   - `docs/investigacao/ESTADO-IMPLEMENTACAO.md` (renomeado de `ESTADO-IMPLEMENTACAO.template.md`)
   - `docs/investigacao/_TEMPLATE.md` (renomeado de `_TEMPLATE_RELATORIO.md`)
2. Copie `investigacao-somente-leitura.mdc` para `.cursor/rules/investigacao-somente-leitura.mdc`.
3. Preencha o relatório inicial de auditoria em `docs/AUDITORIA-PRE-PRODUCAO.md`.
4. Popule a tabela em `ESTADO-BUGS.md` com as hipóteses e despache os agentes investigadores.
