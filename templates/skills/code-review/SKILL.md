---
name: code-review
description: Skill abrangente de Code Review para detectar bugs de lógica, casos de borda, concorrência, falhas de segurança e violações arquiteturais em diffs e PRs.
---

# Code Review & Bug Hunter Skill

> Propósito: Realizar uma revisão rigorosa e em múltiplos eixos em alterações não commitadas, Pull Requests ou arquivos alvo para detectar bugs latentes, casos de borda e falhas antes do merge.

## Protocolo de Revisão

### 1. Eixo Duplo de Análise

#### Eixo A: Conformidade de Lógica e Especificação
- **Arquitetura Ports & Adapters**: Verificar se `src/autoslide/core/` permanece 100% isolado de I/O, UI, bibliotecas de terceiros (`requests`, `sounddevice`, `faster_whisper`) e adaptadores concretos.
- **Princípio "Na dúvida, não agir"**: Garantir que a pontuação de confiança de alinhamento abaixo do limiar configurável (`conf_min`) nunca dispara o avanço automático de slide.
- **Tratamento de Borda**: Verificar nulos/`None`, coleções/strings vazias, timeouts e valores limiares.
- **Erros e Exceções**: Garantir que caminhos de exceção sejam tratados e logados sem supressões silenciosas (`except:` nu ou exceção genérica sem `# noqa: BLE001` e motivo explícito).

#### Eixo B: Padrões de Código e Confiabilidade
- **Concorrência e Assincronismo**: Verificar se tasks/threads no barramento e filas estão adequadamente sincronizadas e terminam sem deadlocks no encerramento da sessão.
- **Gerenciamento de Recursos**: Garantir fechamento de streams de áudio, sockets HTTP e manipuladores de arquivos de diagnóstico.
- **Tipagem Estática**: Validar type hints completos (`mypy`) sem uso indiscriminado de `Any`.
- **Operação 100% Offline & PT-BR**: Garantir ausência de chamadas a APIs de nuvem externas em tempo de execução.

### 2. Passos de Execução
1. Inspecionar as alterações em `git diff` e arquivos modificados.
2. Executar linters (`ruff`) e verificadores estáticos (`mypy`) para validar a conformidade.
3. Analisar caminhos de código procurando erros de limite, mutação indevida de estado de domínio ou falta de tratamento de erros.
4. Emitir apontamentos categorizados por gravidade (**CRÍTICO**, **MAJOR**, **MINOR**) com links de linha explícitos (`file:///caminho/do/arquivo#L123`) e sugestões concretas de refatoração.
