# GitHub Copilot Code Review Instructions — [NOME_DO_PROJETO]

> Nota de Substituição: Este é um template genérico reutilizável. Substitua os placeholders `[NOME_DO_PROJETO]`, `[CORE_PATH]`, `[PORTS_PATH]`, etc., pelos caminhos reais do seu repositório antes de salvar em `.github/copilot-instructions.md`.

Este documento estabelece as diretrizes obrigatórias de arquitetura, engenharia e código para o **GitHub Copilot Code Review** ao analisar Pull Requests no repositório **[NOME_DO_PROJETO]**.

---

## 1. Arquitetura: Ports & Adapters / Clean Architecture (NÃO NEGOCIÁVEL)

- **Núcleo Isolado (`[CORE_PATH]` ex: `src/domain/` ou `src/core/`)**:
  - O núcleo de regras de negócio **SÓ DEVE DEPENDER** das abstrações de porta em `[PORTS_PATH]`.
  - **PROIBIDO**: Importar bibliotecas de I/O, UI, banco de dados ou APIs externas dentro do pacote do núcleo (`core/` / `domain/`).
- **Adaptadores (`[ADAPTERS_PATH]` ex: `src/adapters/`, `src/infrastructure/`)**:
  - Implementam as portas concretas (Protocols / ABCs / Interfaces).
- **Composition Root (`[APP_PATH]` ex: `src/app/`, `src/main.py`)**:
  - Responsável por instanciar e injetar os adaptadores no núcleo.
- **Comunicação Núcleo ↔ UI / External**:
  - Exclusivamente reativa por eventos/comandos ou abstrações de porta.

---

## 2. Princípios de Domínio ([NOME_DO_PROJETO] Constitution)

1. **Falhar Fechado e Segura**:
   - Estados incertos ou inconsistentes devem suspender ações automáticas e sinalizar intervenção ao operador ou logar erro explícito.
2. **Respeito aos Limites do Escopo**:
   - Alterações não devem introduzir dependências ou integrações fora da especificação aprovada.
3. **Gerenciamento de Recursos Local**:
   - Garantir liberação determinística de arquivos, conexões e recursos de sistema.

---

## 3. Padrões de Engenharia & Qualidade de Código

- **Tipagem Estática (Type Hints)**:
  - Todo novo código ou alteração em assinaturas de funções deve conter type annotations completas compatíveis com o verificador estático do projeto.
  - Contratos de portas devem utilizar abstrações puras (ex: `typing.Protocol`, `abc.ABC` ou Interfaces).
- **Tratamento de Exceções**:
  - Evitar capturas genéricas de exceções sem log explícito e justificativa. Supressões intencionais devem ter comentários explicativos.
- **Configuração Operacional**:
  - Parâmetros operacionais devem ser lidos de arquivos de configuração (`[CONFIG_FILE]` ex: `.env`, `config.toml`).
  - **PROIBIDO**: Hardcodear segredos ou credenciais no código-fonte.
- **Estruturas de Dados e Imutabilidade**:
  - Utilizar estruturas imutáveis para eventos e estados de domínio sempre que possível.

---

## 4. Estratégia de Testes

- **Testes Unitários (`[TESTS_UNIT_PATH]` ex: `tests/unit/`)**:
  - Devem ser **100% sem I/O** (rápidos, isolados e determinísticos).
- **Testes de Integração (`[TESTS_INTEGRATION_PATH]` ex: `tests/integration/`)**:
  - Podem interagir com recursos reais ou mocks de integração.
  - Pular graciosamente quando pré-requisitos externos não estiverem presentes no ambiente.

---

## 5. Diretrizes de Formatação dos Comentários do Reviewer

Ao revisar os PRs, por favor:
- Destaque imediatamente qualquer **vazamento de abstração** (ex: importação de I/O dentro de `core/`).
- Verifique se a legibilidade do código atende aos linters e formatadores configurados no repositório.
- Forneça sugestões construtivas com trechos de código explicativos quando identificar oportunidades de refatoração ou melhoria de resiliência.
