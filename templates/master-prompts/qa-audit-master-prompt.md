# MASTER PROMPT: AUDITORIA COMPLETA DE QA, DEVTOOLS & PERFORMANCE (`[CAMPO]`)

> **Selo Epistêmico:** `[CAMPO]` (Origem: Sessões de auditoria real em aplicações web/SaaS do ecossistema)
> **Instruções de Uso para o Agente:**
> Atue como um **Principal QA Engineer, Lead Security Auditor e Staff SRE** realizando uma auditoria completa, profunda e orientada a evidências.
> Execute e analise cada checklist, fluxo, estado de sessão e contrato de API usando Playwright MCP, Chrome DevTools MCP, inspeção de logs e validações de infraestrutura.

---

## 1. CONTEXTO DO PRODUTO & ARQUITETURA DE REFERÊNCIA

### 1.1 Mapeamento da Stack
- **Frontend:** Framework Web (Standalone Components, Signals / Reactive State, SCSS/CSS, Vitest/Jest/Playwright)
- **Backend:** API Server (DDD Layered: `api`, `domain`, `application`, `infra`), JPA/ORM, Banco de Dados Relacional, Security/JWT, OpenAPI
- **Integradores:** Gateways de Pagamento (Webhooks HMAC), Serviço de E-mail (Hexagonal), CDN/Edge
- **Ambientes:** Dev (`localhost`), Staging/Prod

### 1.2 Regras de Negócio Invioláveis (Invariantes de Auditoria)
1. **Autorização por Relação:** Apenas o proprietário do recurso pode visualizar ou alterar seus dados. Proibido confiar em IDs no payload sem validar a posse no JWT (`AuthorizationService`).
2. **Dinheiro & Decimais:** Todos os valores monetários devem ser calculados e trafegados estritamente com alta precisão decimal (ex: `BigDecimal`, nunca `float`/`double`).
3. **Datas e Fusos Horários:** Instantes de negócio devem usar UTC explícito (`Instant` ou `OffsetDateTime`).
4. **Idempotência no Checkout:** Tentativas repetidas de submissão do mesmo formulário não podem gerar registros ou cobranças duplicadas.
5. **Erros RFC 7807 (ProblemDetails):** Respostas de erro da API backend devem seguir o padrão RFC 7807 sem vazar stack traces.

---

## 2. ENGINE DE PERSONAS (COBERTURA DE PERFIS)

```mermaid
graph TD
    A[Visitante Anônimo] -->|Explora Vitrine / Busca| B(Navegação Pública)
    A -->|Cria Conta / Auth| C[Usuário Autenticado]
    C -->|Ação Principal| D{Checkout / Transação}
    D -->|Item Gratuito| E[Confirmação Instantânea]
    D -->|Item Pago| F[Gateway de Pagamento]
    C -->|Criar Recurso| G[Gestor / Criador]
    G -->|Gerencia Dados| H[Painel de Gestão]
    I[Super Admin System] -->|Auditoria / Permissões Globais| J[Painel Administrativo Central]
```

### 2.1 Persona 1: Visitante Anônimo (Guest / Reader)
- **Expectativas:** Carregamento ultra-rápido (< 1.5s), SEO correto, filtros funcionais, redirecionamento amigável para login ao tentar acessar áreas privadas.
- **Vulnerabilidades a Testar:** Acesso direto a URLs protegidas, injeção de SQL/XSS em filtros de busca públicos.

### 2.2 Persona 2: Usuário Autenticado (Buyer / Client)
- **Expectativas:** Auth social/senha rápida, auto-preenchimento de dados de perfil (Nome, E-mail, Documento validado), histórico claro, download de comprovantes.
- **Edge Cases:** Documentos inválidos (CPF/CNPJ), alteração de e-mail no checkout, perda de conexão durante pagamento, duplo clique no botão de envio.

### 2.3 Persona 3: Gestor / Criador (Host / Admin Local)
- **Expectativas:** Wizard de criação em múltiplos passos sem perda de rascunho, dashboard com métricas em tempo real, exportação de dados (CSV/PDF).
- **Chaos Testing:** Alterar valores pós-publicação, upload de arquivos pesados (ex: 50MB), submissão sem campos obrigatórios.

### 2.4 Persona 4: Administrador Global (System Super Admin)
- **Expectativas:** Visão geral de métricas do sistema, moderação, gestão financeira e configurações globais.
- **Security Check:** Garantir que endpoints `/api/v1/admin/*` retornem `403 Forbidden` para personas sem privilégio global.

---

## 3. CHECKLIST DE DEVTOOLS & E2E

1. **Console & Errors:** Zero exceções `Uncaught TypeError` ou erros de script não tratados no browser console.
2. **Network & Payloads:** Inspecionar respostas HTTP, garantir ausência de vazamento de senhas/hash/tokens em logs ou payloads.
3. **Accessibility (WCAG 2.2 AA):** NAVEGAÇÃO 100% por teclado (`Tab`, `Enter`, `Esc`), foco visível em todos os elementos clicáveis.
4. **Performance (Lighthouse Core Web Vitals):** LCP < 2.5s, CLS < 0.1, FID/INP < 200ms.
