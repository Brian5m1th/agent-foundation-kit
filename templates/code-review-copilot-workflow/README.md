# 📦 Pacote Template: Code Review & GitHub Copilot Pro Workflow

> **Selo Epistêmico:** `[CONSOLIDADO]`  
> **Propósito:** Oferecer um workflow padronizado e automatizável de criação de PRs, revisão de código e integração com **GitHub Copilot Pro Code Review** para repositórios do ecossistema.

---

## 📂 Estrutura do Pacote

```text
templates/code-review-copilot-workflow/
├── README.md                                    # Guia e documentação deste pacote
├── copilot-code-review-instructions.template.md # Diretrizes para .github/copilot-code-review-instructions.md
├── master-prompts/
│   └── code-review-copilot-prompt.md            # System Prompt / Custom Instruction para o Agente
└── skills/
    └── code-review/
        └── SKILL.md                             # Skill de Code Review & Bug Hunter (.github/skills/code-review/SKILL.md)
```

---

## 1. 🤖 Prompt do Agente (System Prompt / Custom Instruction)

Local de origem: [`templates/master-prompts/code-review-copilot-prompt.md`](../master-prompts/code-review-copilot-prompt.md)

```markdown
# Diretrizes Globais de Code Review e Criação de PRs (GitHub Copilot Pro)
Sempre que você finalizar uma funcionalidade, correção de bug ou refatoração:
1. **Isolamento em Branch**:
   - Trabalhe em uma branch dedicada criada a partir da `main` (ex: `feat/minha-feature` ou `fix/meu-bug`).
2. **Push & Abertura de PR**:
   - Faça push da branch e abra o PR usando o GitHub CLI:
     `gh pr create --title "tipo(escopo): descrição" --body "..."`
3. **Trigger de Revisão por IA**:
   - Inclua a menção `@github-copilot review` na descrição ou poste como comentário no PR.
4. **Respeito às Instruções do Repositório**:
   - Verifique se `.github/copilot-code-review-instructions.md` e `.github/skills/code-review/SKILL.md` existem no repositório antes de solicitar a revisão.
```

---

## 2. ⚡ Skill de Code Review (`.github/skills/code-review/SKILL.md`)

Local de origem: [`templates/skills/code-review/SKILL.md`](../skills/code-review/SKILL.md)

```markdown
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
```

---

## 3. 🎯 Instruções do Copilot (`.github/copilot-code-review-instructions.md`)

Local de origem: [`copilot-code-review-instructions.template.md`](copilot-code-review-instructions.template.md)

```markdown
# GitHub Copilot Code Review Instructions — AutoSlide
Este documento estabelece as diretrizes obrigatórias de arquitetura, engenharia e código para o **GitHub Copilot Code Review** ao analisar Pull Requests no repositório **AutoSlide**.
---
## 1. Arquitetura: Ports & Adapters (NÃO NEGOCIÁVEL)
- **Núcleo Isolado (`src/autoslide/core/`)**:
  - O núcleo de processamento (ouvir, alinhar, decidir, estado da sessão) **SÓ DEVE DEPENDER** das abstrações de porta em `src/autoslide/ports/`.
  - **PROIBIDO**: Importar `requests`, `sounddevice`, `faster_whisper`, `PySide6`, `tkinter` ou qualquer biblioteca de I/O / UI dentro do pacote `core/`.
- **Adaptadores (`src/autoslide/adapters/*`, `src/autoslide/ui/`)**:
  - Implementam as portas concretas (Protocols / ABCs).
- **Composition Root (`src/autoslide/app/`)**:
  - Responsável por instanciar e injetar os adaptadores no núcleo.
- **Comunicação Núcleo ↔ UI**:
  - Exclusivamente reativa por eventos/comandos (barramento, observer, filas). O núcleo nunca faz chamadas HTTP diretas nem manipula componentes de UI.
---
## 2. Princípios de Domínio (AutoSlide Constitution)
1. **Na dúvida, não agir**:
   - Confiança de alinhamento abaixo do limiar configurável (`conf_min`) **NUNCA** pode disparar o avanço automático de slide.
   - Em caso de incerteza, o sistema deve suspender disparos automáticos e sinalizar intervenção ao operador.
2. **100% Offline e PT-BR**:
   - O idioma oficial é Português do Brasil (PT-BR).
   - Nenhuma chamada de rede externa a serviços em nuvem é permitida em tempo de execução. A única comunicação de rede permitida é local (HTTP para a API embutida do LouvorJá).
3. **Escopo LouvorJá-Only**:
   - O envio de comandos e leitura de slides é exclusivo para a API do LouvorJá (`GET /file/file.ja`, `GET /api/keyboard`).
   - Não adicionar OCR ou envio de teclas genéricas de sistema para PowerPoint ou outros projetores no MVP.
4. **ASR em GPU NVIDIA Local**:
   - Reconhecimento de fala via `faster-whisper` (`large-v3` em `float16`).
   - Todo o consumo de VRAM deve permanecer estritamente dentro do orçamento de 8 GB VRAM (RTX 3060 / 4060).
---
## 3. Padrões de Engenharia & Qualidade de Código
- **Tipagem Estática (Type Hints)**:
  - Todo novo código ou alteração em assinaturas de funções deve conter type annotations completas compatíveis com `mypy`.
  - Contratos de portas em `src/autoslide/ports/` devem utilizar `typing.Protocol` ou `abc.ABC`.
- **Tratamento de Exceções**:
  - Evitar blocos `except:` nus ou capturas genéricas de `Exception` sem log explícito e justificativa. Quando inevitável em fallbacks de resiliência, incluir a supressão explícita `# noqa: BLE001` acompanhada de justificativa no comentário.
- **Configuração Operacional**:
  - Parâmetros operacionais devem ser lidos de `config.toml` via `config_handlers.py`.
  - **PROIBIDO**: Hardcodear valores operacionais diretamente no código-fonte.
- **Estruturas de Dados e Imutabilidade**:
  - Usar `@dataclass` (preferencialmente imutáveis `frozen=True` quando representar eventos/estado de domínio).
---
## 4. Estratégia de Testes
- **Testes Unitários (`tests/unit/`)**:
  - Devem ser **100% sem I/O** (sem hardware de áudio real, sem GPU NVIDIA e sem servidor LouvorJá).
- **Testes de Integração (`tests/integration/`)**:
  - Podem interagir com hardware ou serviços externos reais.
  - Devem utilizar a anotação `@pytest.mark.skipif` para pular graciosamente a execução quando os pré-requisitos não estiverem presentes no ambiente.
---
## 5. Diretrizes de Formatação dos Comentários do Reviewer
Ao revisar os PRs, por favor:
- Destaque imediatamente qualquer **vazamento de abstração** (ex: importação de I/O dentro de `core/`).
- Verifique se a legibilidade do código atende às regras do `ruff`.
- Forneça sugestões construtivas com trechos de código explicativos quando identificar oportunidades de refatoração ou melhoria de resiliência.
```

---

## 🚀 Como instalar em um novo projeto

Para instalar o pacote completo de Code Review e GitHub Copilot Pro em um projeto alvo (ex: `C:\workspace\meu-projeto`):

```powershell
$target = "C:\workspace\meu-projeto"

# 1. Criar diretórios no projeto alvo
New-Item -ItemType Directory -Force -Path "$target\.github\skills\code-review"

# 2. Copiar as Instruções do Copilot Code Review
Copy-Item "C:\workspace\labs\templates\code-review-copilot-workflow\copilot-code-review-instructions.template.md" "$target\.github\copilot-code-review-instructions.md"

# 3. Copiar a Skill de Code Review
Copy-Item "C:\workspace\labs\templates\skills\code-review\SKILL.md" "$target\.github\skills\code-review\SKILL.md"

# 4. Adicionar o Prompt do Agente ao AGENTS.md / CLAUDE.md do projeto
Get-Content "C:\workspace\labs\templates\master-prompts\code-review-copilot-prompt.md" | Add-Content "$target\AGENTS.md"
```
