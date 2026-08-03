# Constitution

<!--
Princípios inegociáveis do projeto. Autoridade sobre spec, plan, tasks e código.
Conflito com a constitution é REPORTADO ao humano, nunca resolvido em silêncio.

Estrutura e papel derivados do /speckit.constitution do GitHub Spec Kit.
Fundamentação: docs/intent-engineering/03-arvore-de-principios.md (P8 · Autoridade hierárquica).

TESTE DE SAÚDE (aplique a cada artigo antes de aceitá-lo):
  "Que decisão plausível e TENTADORA este artigo proíbe?"
  Sem resposta concreta → o artigo é decorativo, apague. Ver anti-padrão AP-10.
-->

- **Versão:** 0.1.0
- **Ratificada em:** AAAA-MM-DD
- **Última emenda:** AAAA-MM-DD

## Artigo I — Simplicidade primeiro

Comece com a solução mais simples que satisfaz a spec. Abstração, camada de indireção ou padrão de
projeto entram apenas na **segunda** ocorrência real do problema, nunca na primeira antecipada. Toda
dependência nova exige justificativa registrada no `plan.md`.

> Proíbe: introduzir uma camada de repositório/factory "porque vamos precisar depois".

## Artigo II — Contratos antes de implementação

Interfaces públicas — assinaturas, schemas, formatos de request/response, tipos de erro, eventos — são
definidas no `plan.md` e revisadas antes de qualquer código. Executor que descobre o contrato inviável
**para e reporta**; não o corrige por conta própria.

> Proíbe: o agente "melhorar" a assinatura durante a implementação.

## Artigo III — Verificável por construção

Toda task declara como será verificada: um teste, um comando executável, ou uma checagem manual em uma
linha. Task sem critério de verificação não entra na lista. Critério que nenhum resultado plausível
reprovaria não é critério.

> Proíbe: "T-012 — melhorar a performance" sem número e sem comando.

## Artigo IV — Escopo é contrato

Entrega-se o que a spec define — nem mais, nem menos. Ideia boa fora de escopo vira linha em "Fora de
escopo" ou spec futura. Ampliar escopo durante a implementação é violação, mesmo quando a ampliação é
boa.

> Proíbe: refatorar o módulo vizinho "já que estava ali".

## Artigo V — Ambiguidade é explícita, e bloqueia conforme o custo

Nenhum artefato avança com suposição implícita. Dúvida vira `[PRECISA ESCLARECER: <pergunta>]`.

O marcador **bloqueia** a fase seguinte quando o custo de reverter a decisão errada é alto (schema,
contrato público, modelo de dados, decisão de segurança). Quando reverter é barato e observável, o
executor **assume, registra a suposição** e segue.

> Proíbe as duas falhas simétricas: decidir em silêncio, e travar o fluxo perguntando o que sairia mais
> barato tentar. Fundamentação: ADR-003.

## Artigo VI — Responsabilidade não se delega junto com a execução

Toda spec tem um humano nomeado como responsável. Delegar a execução a um agente não transfere a
responsabilidade pelo resultado. Decisões de nível de meta — resolver conflito entre requisitos,
mudar prioridade, aceitar desvio de constitution — são do humano, sempre.

> Proíbe: "o agente decidiu assim" como explicação final.
> Fundamentação: P12 · Conservação da responsabilidade.

## Artigo VII — <princípio específico deste projeto>

_Substitua. Exemplos que passam no teste de saúde:_
_"Nenhum endpoint público sem autenticação e rate limit."_
_"Zero dependência com licença copyleft."_
_"Português nos textos de usuário, inglês no código."_
_"Nenhuma migração de banco sem script de rollback testado."_

---

## Governança

- Esta constitution tem autoridade sobre todos os demais artefatos do projeto.
- Emenda exige: justificativa escrita, incremento de versão e registro da data.
- **Constitution não muda no meio de uma task.** Se um artigo atrapalha a entrega em curso, a entrega
  para — não o artigo.
- Versionamento semântico: MAJOR para remoção/redefinição de artigo, MINOR para novo artigo, PATCH
  para redação.
