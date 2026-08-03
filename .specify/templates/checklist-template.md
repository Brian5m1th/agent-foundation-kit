# Checklist: <DIMENSÃO> — <NOME DA FEATURE>

- **Spec:** ./spec.md · **Gerada em:** AAAA-MM-DD
- **Dimensão:** requisitos | segurança | UX | operação | dados | acessibilidade

<!--
Derivado do /speckit.checklist do GitHub Spec Kit.

NATUREZA DESTE ARTEFATO: é um checklist de QUALIDADE DA ESPECIFICAÇÃO, não de teste do código.
Ele pergunta "este requisito está bem escrito e completo?", não "o código passa?".
Teste de código é responsabilidade de tasks.md e /sdd-converge.

Cada item é uma pergunta FECHADA que pode ser respondida lendo a spec e o plan.
Item que exige rodar o sistema está no documento errado.
-->

## Completude

- [ ] CHK001 — Todo requisito funcional aponta pelo menos uma história de usuário? `[FR-*]`
- [ ] CHK002 — Toda história tem cenário de aceite para o caminho de erro, não só o feliz? `[US-*]`
- [ ] CHK003 — Todo critério de sucesso tem número e unidade? `[SC-*]`
- [ ] CHK004 — A seção "Fora de escopo" lista as ideias adjacentes que foram deixadas de fora?

## Clareza

- [ ] CHK005 — A spec está livre de tecnologia (framework, banco, endpoint, caminho de arquivo)?
- [ ] CHK006 — Cada requisito é testável por alguém que não leu o código?
- [ ] CHK007 — Não há adjetivo não quantificado ("rápido", "simples", "intuitivo") sem métrica ou
  declaração explícita de que é softgoal julgado por humano?

## Consistência

- [ ] CHK008 — Nenhum requisito contradiz outro?
- [ ] CHK009 — Nenhum requisito contradiz a constitution?
- [ ] CHK010 — A prioridade das histórias é coerente com o problema declarado?

## Cobertura de obstáculos

- [ ] CHK011 — Entrada vazia, ausente ou malformada está tratada?
- [ ] CHK012 — Duplicidade e concorrência estão tratadas?
- [ ] CHK013 — Falha de dependência externa está tratada?
- [ ] CHK014 — Autorização e ausência de permissão estão tratadas?
- [ ] CHK015 — Limites de volume e tamanho estão declarados?

## Ambiguidade

- [ ] CHK016 — Todo `[PRECISA ESCLARECER]` bloqueante foi resolvido?
- [ ] CHK017 — Toda suposição assumida em marcador não-bloqueante está escrita nas Premissas?

## <dimensão específica>

- [ ] CHK0NN — ...

---

**Resultado:** <n>/<total> · **Itens reprovados:** <lista> · **Ação:** <o que muda na spec>
