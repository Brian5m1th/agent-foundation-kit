# Relatório de Investigação — <ID>

> **Achado**: `<ID> — Título resumido do achado`  
> **Status**: `pendente`  
> **Agente**: `—`  
> **Data**: `YYYY-MM-DD`  

---

## 1. Contexto & Hipótese da Auditoria

- **Texto original da auditoria**: Descreva aqui a citação curta do achado original em `AUDITORIA-PRE-PRODUCAO.md`.
- **Arquivos/linhas citadas originalmente**: `caminho/do/arquivo.py:42`

---

## 2. Investigação no HEAD Atual

- **Arquivos verificados**: [`arquivo.py`](file:///caminho/do/arquivo.py#L42)
- **Git log recente**: Mudanças observadas desde o relatório inicial.
- **Análise do código**: Explicação detalhada da lógica observada no HEAD atual.
- **Testes/bancada**: Detalhes do teste estático ou script descartável executado sem tocar no código de produção.

---

## 3. Confirmação do Diagnóstico

- [ ] Sintoma confirmado exatamente como relatado
- [ ] Causa raiz diferente da apontada na auditoria
- [ ] Falso positivo / código já alterado no HEAD
- [ ] Necessita de ambiente real de produção para validar

**Detalhes da causa raiz**: Explicar a causa física/lógica do problema.

---

## 4. Questões para o Usuário (se houver)

*(Preencha apenas se houver decisão de produto ou limitação de hardware que exija entrada humana)*

---

## 5. Veredito Final (Escolha exatamente UM)

- [ ] `ajuste_simples` — Correção direta de 1 a poucas linhas, sem mudança de contrato/arquitetura (Trilha A).
- [ ] `merece_spec` — Alteração estrutural de domínio/contrato; deve entrar no fluxo SDD em cluster (Trilha B).
- [ ] `sem_evidencia_refutado` — Não há bug no código atual.
- [ ] `sem_evidencia_precisa_producao` — Não é possível confirmar localmente. Exige hardware/produção real.

---

## 6. Recomendação de Correção e Mitigação

- **Abordagem proposta**: Descrição da correção sugerida.
- **Risco de regressão**: Baixo / Médio / Alto.
- **Testes necessários pós-fix**: Quais testes automatizados ou manuais devem validar a correção.
