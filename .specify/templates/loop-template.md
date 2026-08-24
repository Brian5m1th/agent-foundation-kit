# Loop: <NOME>

- **Spec:** ./spec.md · **Plan:** ./plan.md · **Tasks:** ./tasks.md
- **Status:** draft | approved | running | terminal

> Use este artefato só quando o resultado de uma volta muda a próxima ação. Caso contrário, use uma
> execução única ou um prompt agendado.

## Gatilho e arquitetura

- Gatilho: manual | agendado | evento
- Arquitetura: solo | maker-checker | manager-helpers
- Nível real de verificação: 1 determinístico | 2 regra | 3 verdade de campo | 4 juiz-LLM | 5 humano

## Meta e linha de base

- Meta observável:
- Linha de base comparável:
- Recorte de tasks autorizado:

## Verificação

- Check principal: `<comando ou procedimento>`
- Pronto quando:
- Regressões protegidas: `<comandos/condições>`
- Prova do verificador (vermelho antes / verde depois), quando aplicável:

## Uma volta

1. Reler este arquivo, `loop-state.md`, constitution, spec, plan e task corrente.
2. Capturar evidência comparável do estado atual.
3. Escolher o maior obstáculo restante a partir da evidência.
4. Fazer uma mudança focada dentro do envelope da task.
5. Rodar check principal e regressões protegidas.
6. Manter a mudança só se o aceite passar sem regressão proibida.
7. Atualizar `loop-state.md` com evidência, decisão, custo e próximo candidato.

## Estados terminais

- **success:**
- **no-op:**
- **blocked:**
- **stalled:** <N voltas sem ganho ou oscilação>
- **exhausted:** <teto de voltas/custo>
- **error:** falha de execução ou verificação; nunca equivale a sucesso

## Guardrails

- Teto de voltas/custo:
- Arquivos/superfícies permitidos:
- Consulta antes de:
- Vedado:
- Sub-loops e teto multiplicativo, se houver:

## Memória

- Estado durável: `./loop-state.md`
- Registrar: tentativa, evidência, decisão, custo, mudança aceita/rejeitada, próximo candidato.
- Não registrar: transcrição bruta ou conclusão sem evidência.

## Acionamento

```text
Leia loop.md e loop-state.md. Execute exatamente uma volta. Faça no máximo uma mudança focada, rode
os checks declarados e mantenha a mudança apenas se o aceite passar sem regressão. Atualize o estado e
retorne exatamente um estado: success, no-op, continue, blocked, stalled, exhausted ou error. Erro ou
orçamento esgotado nunca significam sucesso. Não ultrapasse o envelope da task.
```

## Métrica de saúde

`custo por mudança aceita = custo total do loop / mudanças que sobreviveram à verificação`
