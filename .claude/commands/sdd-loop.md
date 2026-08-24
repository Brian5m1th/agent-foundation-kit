---
description: Especifica um loop verificável e limitado para executar tasks SDD aprovadas
argument-hint: [objetivo iterativo ou vazio = derivar da spec ativa]
---

Fase opcional 3.75 do fluxo SDD, depois de `tasks`/`analyze` e antes de `implement`. Produz `loop.md`;
não executa o loop.

**Objetivo opcional:** $ARGUMENTS

## Triagem obrigatória

Leia constitution, `spec.md`, `plan.md` e `tasks.md`. Pergunte: **a evidência de uma volta muda a
próxima ação?**

- Se não, não crie `loop.md`. Devolva um prompt de execução única ou agendada e explique o descarte.
- Se sim, continue.
- Marcador bloqueante, contrato ausente ou task sem verificação → pare; o loop não corrige artefato
  anterior quebrado.

## Especificação

Use `.specify/templates/loop-template.md` e escreva `loop.md` na pasta da spec ativa. Derive tudo que
já está nos artefatos e só pergunte por uma escolha que altere materialmente o desenho.

O documento precisa declarar:

- gatilho, meta, linha de base e recorte de tasks;
- nível real da verificação (1 determinístico, 2 regra, 3 campo, 4 juiz-LLM, 5 humano);
- check principal, regressões protegidas e condição objetiva de aceite;
- uma mudança focada por volta, escolhida pela evidência;
- estados `success`, `no-op`, `blocked`, `stalled`, `exhausted` e `error` aplicáveis;
- estado durável em `loop-state.md`, teto de voltas/custo e envelope de autonomia;
- skills/sub-loops chamados, com teto multiplicativo e sem ciclos;
- forma de acionamento e custo por mudança aceita.

Juiz-LLM exige maker/checker em contextos separados e rubrica congelada. Ações destrutivas, externas,
financeiras, de produção ou segurança permanecem atrás da aprovação prevista no envelope. Erro,
verificação indisponível ou orçamento esgotado nunca equivalem a sucesso.

## Entrega

Informe: caminho de `loop.md` · por que o caso merece loop · nível real do verificador · estados de
parada · teto · pontos de aprovação · prompt de acionamento. Sugira revisão humana do loop antes de
executar `/sdd-implement` dentro dele.
