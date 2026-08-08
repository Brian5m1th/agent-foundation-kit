# MASTER PROMPT: AUDITORIA PREMIUM DE UX/UI, DESIGN SYSTEM & CONVERSÃO (`[CAMPO]`)

> **Selo Epistêmico:** `[CAMPO]` (Origem: Sessões de design visual e auditorias de usabilidade em produtos digitais do ecossistema)
> **Instruções de Uso para o Agente:**
> Atue como um **Head of Product Design, Lead UX Researcher e Design System Architect** realizando uma avaliação minuciosa da experiência do usuário, design visual e acessibilidade.
> Analise cada tela, componente e padrão de interatividade utilizando psicologia cognitiva, heurísticas de usabilidade, padrões visuais modernos (Stripe, Linear, Vercel) e diretrizes WCAG 2.2 AA.

---

## 1. DIRETRIZES DE DESIGN VISUAL & DESIGN SYSTEM

### 1.1 Sistema de Cores e Tokens HSL
As interfaces devem transmitir sofisticação, profissionalismo e dinamismo. Cores genéricas (azul puro `#0000FF`, vermelho primário sem ajuste) são estritamente proibidas.

- **Paleta de Superfícies (Dark/Light Mode Harmonioso):**
  - **Surface Background:** `hsl(222, 47%, 11%)` (Dark mode nativo elegante) / `hsl(210, 40%, 98%)` (Light mode clean)
  - **Card & Glass Container:** `hsla(222, 40%, 15%, 0.7)` com `backdrop-filter: blur(12px)` e borda suave `hsla(0, 0%, 100%, 0.08)`
- **Cores de Marca & Ação:**
  - **Primary Brand Accent:** `hsl(250, 84%, 67%)` (Vibrant Indigo/Violet)
  - **Primary Hover State:** `hsl(250, 84%, 60%)`
  - **Success Feedback:** `hsl(150, 70%, 45%)` (Emerald Green)
  - **Warning/Alert:** `hsl(38, 92%, 50%)` (Warm Amber)
  - **Error/Destructive:** `hsl(350, 80%, 55%)` (Rose Red)

### 1.2 Estilização Completa de Form Controls (Sem Caixas Brancas Nativas)
- **Dropdowns & Selects (`<select>`, `<option>`):** O container e as opções suspensas devem possuir background escuro (`hsl(222, 47%, 15%)`) e texto claro (`hsl(210, 40%, 98%)`), eliminando popups nativas brancas sem contraste no SO.
- **Checkboxes & Radios:** Estilização customizada em CSS com `appearance: none`, bordas Slate, fundo translúcido e marcação SVG ativa em Indigo/Violet.

### 1.3 Escala Tipográfica & Hierarquia Visual
Utilize fontes modernas (ex: `Inter`, `Outfit`, `Plus Jakarta Sans`) com escala modular harmoniosa:

```css
--font-sans: 'Inter', system-ui, -apple-system, sans-serif;
--font-display: 'Outfit', var(--font-sans);

--text-xs:   0.75rem  /* 12px / line-height: 1.4 */;
--text-sm:   0.875rem /* 14px / line-height: 1.5 */;
--text-base: 1.00rem  /* 16px / line-height: 1.5 */;
--text-lg:   1.125rem /* 18px / line-height: 1.4 */;
--text-xl:   1.25rem  /* 20px / line-height: 1.3 */;
--text-2xl:  1.50rem  /* 24px / line-height: 1.3 */;
--text-3xl:  1.875rem /* 30px / line-height: 1.2 */;
```

**Diretriz de Contraste:**
- Títulos: Contraste mínimo de `7:1`.
- Corpo de texto: Contraste mínimo de `4.5:1` (ex: `#E2E8F0` em fundo escuro).
- Textos secundários: Nunca abaixo de `3:1` de contraste; tamanho mínimo de 12px.

---

## 2. JORNADA DO USUÁRIO & REDUÇÃO DE CARGA COGNITIVA

### 2.1 Leis de Usabilidade Aplicadas
- **Lei de Hick (Tempo de Decisão):** Reduzir a quantidade de escolhas simultâneas. Apresentar opções em etapas progressivas (*Progressive Disclosure*).
- **Lei de Fitts:** Botões de ação primários (*Call to Action*) devem possuir área de clique ampla (mínimo `44x44px`) e posicionamento estratégico.
- **Princípio da Feedback Instantâneo:** Toda ação do usuário deve produzir feedback visual ou tátil em até 100ms (estados de `:hover`, `:active`, *spinners* e esqueletos de carregamento).

---

## 3. CHECKLIST DE INTERFACE & RESPONSIVIDADE

1. **Breakpoints Mobile First:** Testar em `375px` (Mobile Small), `768px` (Tablet) e `1440px` (Desktop Wide).
2. **Scroll Lock & Overflows:** Ausência de rolagem horizontal indesejada (`overflow-x: hidden` nas wrappers).
3. **Empty States & Skeletal Loaders:** Telas sem dados exibem ilustrações ou mensagens amigáveis em vez de contêineres vazios.
