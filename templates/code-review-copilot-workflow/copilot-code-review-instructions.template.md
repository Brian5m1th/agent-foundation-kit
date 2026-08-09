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
