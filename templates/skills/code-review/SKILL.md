---
name: code-review
description: Skill abrangente de Code Review para detectar bugs de lógica, casos de borda, concorrência, falhas de segurança e violações arquiteturais em diffs e PRs.
---

# Code Review & Bug Hunter Skill

> Propósito: Realizar uma revisão rigorosa e em múltiplos eixos em alterações não commitadas, Pull Requests ou arquivos alvo para detectar bugs latentes, casos de borda e falhas antes do merge.

## Protocolo de Revisão

### 1. Eixo Duplo de Análise

#### Eixo A: Conformidade de Lógica e Especificação
- **Arquitetura Ports & Adapters**: Verificar se o núcleo de domínio (`[CORE_PATH]`) permanece 100% isolado de I/O, UI, bibliotecas de terceiros e adaptadores concretos.
- **Respeito às Regras de Domínio**: Garantir que decisões sob incerteza falhem com segurança e não disparem ações colaterais indesejadas.
- **Tratamento de Borda**: Verificar nulos/`None`/`undefined`, coleções/strings vazias, timeouts e valores limiares.
- **Erros e Exceções**: Garantir que caminhos de exceção sejam tratados e logados sem supressões silenciosas (evitar `except:` nus ou blocos de erro vazios).

#### Eixo B: Padrões de Código e Confiabilidade
- **Concorrência e Assincronismo**: Verificar se tasks, threads e filas estão adequadamente sincronizadas e terminam sem deadlocks no encerramento do processo.
- **Gerenciamento de Recursos**: Garantir fechamento de conexões de rede, sockets, DB handles e manipuladores de arquivos.
- **Tipagem Estática**: Validar type hints completos sem uso indiscriminado de tipos genéricos ou `any`.
- **Segurança & Credenciais**: Garantir ausência de chaves, tokens, segredos hardcoded e vulnerabilidades comuns (OWASP Top 10).

### 2. Passos de Execução
1. Inspecionar as alterações em `git diff` e arquivos modificados.
2. Executar linters e verificadores estáticos do projeto para validar a conformidade.
3. Analisar caminhos de código procurando erros de limite, mutação indevida de estado de domínio ou falta de tratamento de erros.
4. Emitir apontamentos categorizados por gravidade (**CRÍTICO**, **MAJOR**, **MINOR**) com referências de arquivos navegáveis (formato relativo `caminho/do/arquivo#L123` para web UI do PR ou `file:///caminho/do/arquivo#L123` para IDEs locais) e sugestões concretas de refatoração.
