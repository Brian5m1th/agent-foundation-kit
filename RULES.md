# RULES.md — regras de código para agentes

Regras que qualquer agente de IA precisa cumprir ao **escrever, editar ou revisar código** neste
workspace. É o par operacional do [AGENTS.md](AGENTS.md): lá está o *processo* (como o trabalho anda),
aqui está o *produto* (como o código sai).

Arquivo único e portátil, upstream em `labs`, consumido pelos projetos em `C:\workspace\`.
Editar sempre aqui, nunca na cópia instalada (AP-15).

## Como usar

- **Toda regra é citável pelo identificador.** Ao justificar uma edição, cite `RG-01`, não a paráfrase.
- **Namespace `R*` é exclusivo deste arquivo** e não colide com o da KB (`P`, `AP`, `I`, `H`, `CTX`,
  `INT`, `PLN`, `EXE`, `VER`, `LRN`, `AR`, `PL`, `AD`, `ME`, `AL`, `ADR`) — AP-14.
- **Numeração imutável.** Regra errada é corrigida no lugar ou marcada obsoleta, nunca renumerada.
- 🔴 **violação é defeito, sempre.** 🟡 **forte; exceção existe e precisa ser registrada no código ou
  no PR.** Sem marcador, é default sensato que o contexto do projeto pode substituir.

**Precedência quando houver conflito:**

```
constitution do projeto  >  RULES.md  >  AGENTS.md/CLAUDE.md do projeto  >  default da stack
```

A constitution vence sempre (I-14). Conflito com ela é reportado ao humano, nunca resolvido em silêncio.

---

# 1 · Universais (`RG`)

Valem em toda linguagem, todo framework, todo projeto.

**RG-01 · Comentário não substitui nome** 🔴
Proibido comentário narrativo dentro do código — `//`, `#`, `/* */`, docstring explicativa. Se um
trecho precisa de comentário para ser entendido, o defeito é o código: extraia um método com nome que
diga a intenção, renomeie a variável, reduza o aninhamento. Ao tocar um arquivo que já contém
comentário narrativo, **apague-o na mesma edição** — comentário envelhece sem ser revisado e passa a
mentir. Não conta como comentário narrativo, e permanece:

- **diretiva de ferramenta**, que é instrução para máquina e não texto: `# noqa`, `# type: ignore`,
  `// eslint-disable-next-line`, `@ts-expect-error`, `@SuppressWarnings`, pragma, shebang;
- **cabeçalho de licença/SPDX** exigido por política;
- **arquivo declarativo** — YAML, `.properties`, `.env.example`, `Dockerfile`, workflow de CI,
  migration SQL: ali o comentário é a única documentação possível (ver `RCFG`);
- **Javadoc/docstring de API pública** consumida fora do módulo (biblioteca, SDK, endpoint público),
  descrevendo o **contrato** — parâmetros, retorno, exceções —, nunca a implementação.
  *Para endurecer a regra e proibir também esta última, apague este item.*

**RG-02 · Código comentado é código morto** 🔴 — apague. O histórico do git é o arquivo morto.

**RG-03 · Sem `TODO`, `FIXME`, `HACK`, `XXX` em código entregue** 🔴 — o pendente vira task ou issue
com dono, não um marcador que ninguém varre.

**RG-04 · Sem emoji em código** 🔴 — identificador, string de log, mensagem de erro e mensagem de
commit são texto de máquina. Documentação em markdown é livre.

**RG-05 · Nome autoexplicativo** — proibido `obj`, `data1`, `temp`, `aux`, `helper`, `manager`,
`util2`, `handle`, `process`. O nome diz o que a coisa **é** ou o que a função **faz**.

**RG-06 · Sem número ou string mágica** — `"ADMIN"`, `"ACTIVE"`, `30`, `0.15` viram constante nomeada
ou enum de domínio. Repetir o literal em dois lugares já é o bug.

**RG-07 · Sem código de fachada** 🔴 (I-15) — nada de `return true`, `return []` ou `return "success"`
sem o trabalho correspondente. O que não foi implementado lança `UnsupportedOperationException` /
`NotImplementedError` explícito, e isso aparece no relatório da task.

**RG-08 · Erro nunca desaparece** 🔴 — proibido `catch {}` vazio, `except: pass`,
`catchError(() => EMPTY)`, `.catch(() => null)`. Trate, converta ou relance; engolir é decisão que
precisa estar escrita no código e justificada no PR.

**RG-09 · Nenhum segredo no código** 🔴 (I-12) — nem em teste, nem em fixture, nem como default de
`@Value` ou `os.getenv("X", "senha")`. Ver `RSEC`.

**RG-10 · Sem saída de depuração** 🔴 — `System.out.println`, `printStackTrace`, `print()`,
`console.log`, `debugger`, `dd()`. Existe logger; use o logger.

**RG-11 · Menor diff correto** — não reformate arquivo que você só passou perto, não reordene imports
fora do escopo, não renomeie de passagem. Ruído de diff esconde a mudança real na revisão.

**RG-12 · Teste não se apaga para o build passar** 🔴 (I-10) — nem `@Disabled`, nem `skip`, nem
`xit`, nem comentar o assert. Teste vermelho é informação; suprimi-la é destruir a informação.

**RG-13 · Idioma** — resposta ao humano e documentação em **pt-BR**. Mensagem de log e de erro em
pt-BR **sem acento** (encoding de terminal e agregador de log não é garantido). Identificadores
seguem a convenção já vigente no projeto; não introduza um segundo idioma no mesmo pacote.

**RG-14 · Uma responsabilidade por unidade** — método de 20–30 linhas, classe com um motivo para
mudar. Passou disso, extraia antes de continuar.

**RG-15 · Regra dos três** — a terceira ocorrência do mesmo trecho é o gatilho da extração. A segunda
ainda pode ser coincidência; abstrair cedo custa mais que duplicar.

**RG-16 · Dependência nova exige aprovação humana** 🟡 — biblioteca nova é custo permanente de
manutenção, licença e superfície de ataque. Proponha; não instale.

**RG-17 · Nunca invente API** 🔴 (I-04) — método, campo, flag ou endpoint que você não verificou no
código, no OpenAPI ou na documentação **não existe**. Marque `UNKNOWN` e pergunte.

**RG-18 · Interfaces na declaração** — declare pelo tipo mais abstrato que serve (`List`, `Map`,
`Sequence`, `ReadonlyArray`), não pela implementação concreta.

**RG-19 · Nada de I/O ou aleatoriedade escondida em função de domínio** — relógio, rede, disco e
gerador aleatório entram por parâmetro ou por porta. Sem isso não há teste determinístico.

**RG-20 · Arquivo termina com newline, sem trailing whitespace, UTF-8, LF** — configure via
`.editorconfig`; não é assunto de revisão humana.

---

# 2 · Git e commits (`RGIT`)

**RGIT-01 · Agente nunca se atribui autoria** 🔴 **— regra global, sem exceção.**
Nenhum agente de IA adiciona a si mesmo como autor ou co-autor. Proibido em mensagem de commit, corpo
de PR, descrição de issue, changelog e release notes: `Co-Authored-By: Claude …`, `Co-Authored-By:
Copilot …`, `🤖 Generated with Claude Code`, `Made with …`, ou qualquer assinatura equivalente. O
autor do trabalho é o humano que o pediu e o revisou.
**Enforcement (preferir ao texto):** `~/.claude/settings.json` → `"attribution": {"commit": "", "pr": ""}`.
O antigo `includeCoAuthoredBy: false` está descontinuado e não deve coexistir com `attribution`.

**RGIT-02 · Conventional Commits** — `tipo(escopo): descrição`, descrição em minúscula, sem ponto
final, assunto ≤ 100 caracteres. Tipos: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`,
`build`, `ci`.

**RGIT-03 · Um commit por task concluída** (H-14) — nunca um commit único no fim da sessão. Permite
revisão incremental e abandono parcial sem perder granularidade.

**RGIT-04 · Commit e push só quando pedido** 🔴 — o agente escreve o código; publicar é decisão do
humano. Vale também para `gh pr create`, `gh pr merge` e criação de branch remota.

**RGIT-05 · Nunca na branch default** 🔴 — trabalho novo nasce em branch convencional casando estritamente com os tipos do RGIT-02 (`feat/`, `fix/`, `refactor/`, `test/`, `docs/`, `chore/`, `perf/`, `build/`, `ci/`). Proibido usar os prefixos `spec/` ou `sdd/` no nome da branch (ex.: use `feat/001-autenticacao`, nunca `spec/001-autenticacao`).

**RGIT-06 · Operações destrutivas exigem confirmação explícita** 🔴 (I-11) — `push --force` (mesmo
`--force-with-lease`) em branch compartilhada, `reset --hard`, `checkout --` sobre trabalho não
salvo, `clean -fdx`, `branch -D`, `rebase` de história publicada. Vale **mesmo em modo autônomo**.

**RGIT-07 · Nunca `--no-verify`, nunca desabilitar hook ou assinatura** 🔴 — hook vermelho é o
problema a resolver, não o obstáculo a contornar.

**RGIT-08 · Nunca versionar `.env`, credencial, dump de banco, `node_modules/`, `target/`, `dist/`,
`.venv/`, artefato de build** 🔴 — o `.gitignore` é parte da entrega, não uma lembrança.

**RGIT-09 · Sem `amend` em commit já publicado** — reescrever história compartilhada quebra o clone
de todo mundo. Corrija com commit novo.

**RGIT-10 · Mensagem descreve o porquê** — o *o quê* já está no diff. `fix: corrige cálculo` não
informa nada; `fix: arredonda desconto com HALF_UP para bater com o extrato do gateway` informa.

**RGIT-11 · Worktree por frente de trabalho** (EXE-05) — o isolamento de checkout git é por frente de trabalho (funcionalidade ou refatoração relevante que dura horas/dias), nunca por tarefa individual. Múltiplas tarefas da mesma frente reusam o mesmo worktree. Leitura e investigações utilizam subagentes sem worktree.

**RGIT-12 · Rebase local e Squash na integração** — branches curtas devem realizar rebase local sobre a branch principal antes da integração. O merge da frente concluída deve ser consolidado via squash commit (ou rebase limpo), produzindo uma mensagem Conventional Commit unificada.

**RGIT-13 · Tamanho máximo de PR e lote de mudança** — PRs e integrações devem conter até 400 linhas alteradas. Mudanças maiores devem ser subdivididas em frentes menores ou entregues de forma incremental (ex.: via Stacked PRs ou Feature Flags).

**RGIT-14 · Ciclo de vida e limpeza de Worktree** (ME-04) — concluído o merge de uma frente, o worktree e a branch temporária correspondente devem ser limpos (`git worktree remove` + `git branch -d`). Worktrees abandonados/órfãos devem ser auditados e removidos periodicamente.

**RGIT-15 · Hooks locais e de sessão são invioláveis** 🔴 (AD-02) — é proibido desabilitar, burlar ou ignorar Git Hooks (`.git/hooks/`) ou Claude Code Hooks. Se a validação falhar, o código ou a mensagem de commit deve ser corrigido.

---

# 3 · Segurança (`RSEC`)

**RSEC-01 · Nunca logar senha, token, JWT, header de autorização, refresh token, CPF, e-mail ou
qualquer PII** 🔴 (I-13) — use sanitizador na fronteira do log, e um teste que falha se vazar.

**RSEC-02 · Zero default de segredo no código** 🔴 — configuração ausente **derruba o boot** em
produção. Falhar alto no start é infinitamente mais barato que falhar baixo no primeiro request.

**RSEC-03 · Autorização por posse do recurso, não só por papel** 🔴 — `hasRole('ORGANIZER')` não
prova que **este** organizador é dono **deste** evento. A identidade vem sempre do token, nunca do
corpo da requisição ou de um parâmetro de query.

**RSEC-04 · Rota é protegida por padrão** — o fallback é `authenticated()`; toda exceção pública é
listada explicitamente e justificada no PR.

**RSEC-05 · Validação em toda borda de entrada** — DTO com Bean Validation, schema Pydantic, guard de
tipo. Entrada não validada é entrada confiável, e nenhuma entrada externa é confiável.

**RSEC-06 · SQL sempre parametrizado** 🔴 — nunca concatenação nem interpolação de string em query,
nem em script de migração, nem em ferramenta interna.

**RSEC-07 · Caminho de arquivo vindo de fora é normalizado e confinado** 🔴 — resolva o caminho
canônico e verifique que está dentro do diretório permitido antes de abrir.

**RSEC-08 · Erro para o cliente não expõe interior** — sem stack trace, sem nome de classe, sem query,
sem versão de framework. Detalhe vai para o log correlacionado por id.

**RSEC-09 · CORS restrito em produção** — origem explícita por ambiente; `*` só em dev local, nunca
combinado com credenciais.

**RSEC-10 · Limite numérico reflete o pico de uso real** (H-10) — rate limit copiado de guia genérico
quebra tráfego legítimo. Todo limite é uma afirmação sobre o domínio; derive-o do uso, não do medo.

**RSEC-11 · Dependência com CVE conhecida não entra** — scanner no CI, e a atualização é a correção;
suprimir o alerta não é.

---

# 4 · Testes (`RTEST`)

**RTEST-01 · O teste prova a regra, não o mock** 🔴 — se todos os colaboradores são mock, o teste
afirma que o mock funciona. Teste invoca código de produção.

**RTEST-02 · Teste de segurança nunca espera 200 sem credencial** 🔴 — e um perfil de teste que
desliga a autorização torna sem valor qualquer teste de autorização que rode sob ele. Verifique sob
qual configuração o seu teste realmente roda.

**RTEST-03 · Arrange–Act–Assert**, um conceito verificado por teste, nome no formato
`deve<Comportamento>Quando<Condição>` / `test_<comportamento>_quando_<condição>`.

**RTEST-04 · Teste comportamento, não implementação** — assert sobre resultado observável e efeito
declarado. Assert sobre ordem de chamadas internas quebra a cada refatoração legítima.

**RTEST-05 · Regra universal vira propriedade** (H-08) — o requisito contém *sempre*, *nunca*,
*qualquer*, *todo*, *independente de*? Então é teste de propriedade (jqwik, Hypothesis, fast-check),
não três exemplos.

**RTEST-06 · Teste que passa a falhar numa correção de segurança é evidência a favor dela** (H-12) —
o teste afirmava o comportamento inseguro. A pergunta certa é *"o que ele afirmava era correto?"*,
nunca *"como faço passar de novo?"*.

**RTEST-07 · Serviço externo é mockado; o próprio sistema não** — rede, gateway de pagamento, SMTP e
LLM entram por porta e são substituídos no teste. Banco em teste de integração é real (H2,
Testcontainers), não mock.

**RTEST-08 · Task não fecha sem o harness verde** 🔴 (I-18) — compilação, lint, testes e build do que
foi tocado. Anexe a saída, não o veredito (H-04).

**RTEST-09 · Bug corrigido nasce com teste que falha antes da correção** — sem isso não há prova de
que a causa foi encontrada, só de que o sintoma sumiu.

**RTEST-10 · Teste é determinístico** — sem `sleep` fixo, sem dependência de ordem de execução, sem
relógio real, sem porta fixa disputada. Teste intermitente é teste quebrado (H-18).

---

# 5 · Java (`RJ`)

**RJ-01 · Java 17+ moderno** — `record` para DTO imutável, `switch` como expressão, pattern matching
em `instanceof`, `List.of`/`Map.of`, `Stream.toList()`, text block para SQL/JSON longo.

**RJ-02 · `Optional` só como tipo de retorno** — nunca como parâmetro, campo ou elemento de coleção.
E nunca `optional.get()` sem `isPresent()`; use `orElseThrow(...)` com exceção de domínio.

**RJ-03 · Proibido `var` em `api`, `application` e `domain`** 🟡 — tipo explícito é o contrato lido em
revisão. `var` é aceito em bloco local curto e em try-with-resources.

**RJ-04 · Lombok padronizado** — `@Getter`, `@Builder`, `@RequiredArgsConstructor`,
`@NoArgsConstructor`, `@AllArgsConstructor`. **`@Data` e `@Setter` são proibidos em entidade de
domínio** 🔴 — abrem mutação irrestrita e destroem o invariante do construtor.

**RJ-05 · SLF4J via `@Slf4j`/`@Log4j2`** — nunca `System.out`, nunca `e.printStackTrace()`.

**RJ-06 · Dinheiro é `BigDecimal` de ponta a ponta** 🔴 — entidade, DTO, cálculo e persistência.
`double` para dinheiro é defeito, não estilo. Escala e `RoundingMode` sempre explícitos.

**RJ-07 · Instante de negócio é `Instant` ou `OffsetDateTime`** 🔴 — `LocalDateTime` não tem fuso e o
`'Z'` literal em pattern é bug esperando o horário de verão.

**RJ-08 · Exceção específica** — `catch (Exception e)` genérico só na fronteira (handler global,
consumidor de fila). No meio do fluxo, capture o que você sabe tratar.

**RJ-09 · `Objects.requireNonNull` / `requireNonNullElse` na entrada** — a NPE explode onde o dado
chegou errado, não três camadas adiante.

**RJ-10 · Imports no topo, sem FQCN inline, sem `import *`** — e sem import não usado.

**RJ-11 · `equals`/`hashCode` coerentes** — entidade JPA compara por identidade de negócio, nunca por
todos os campos nem por coleção `LAZY`.

**RJ-12 · Coleção retornada é imutável ou cópia** — `List.copyOf(...)`; devolver a lista interna
entrega a mutação do agregado para fora.

---

# 6 · Spring Boot (`RSB`)

**RSB-01 · Pacote por bounded context, quatro camadas** —
`com.<org>.<app>.domains.<contexto>/{api,application,domain,infra}`. `api` tem controller e `dto`;
`application` tem os services; `domain/model` tem as entidades ricas; `infra` tem os repositórios.

**RSB-02 · DI por construtor** 🔴 — `@RequiredArgsConstructor` ou construtor explícito. `@Autowired`
em campo é proibido: esconde dependência e impede teste sem contexto Spring.

**RSB-03 · Entidade construída por construtor de domínio** 🔴 — `new Enrollment(request)`. Proibido
`new X()` seguido de cadeia de setters no service.

**RSB-04 · Domínio rico** — `evento.publicar()`, `pagamento.estornar()`, `inscricao.confirmar()`. O
service orquestra, a entidade decide. Service que só move dados entre setters é um script.

**RSB-05 · Bean Validation só em DTO de API** 🔴 — `@NotNull`/`@NotBlank`/`@Email` na entidade são
proibidos; a entidade valida no próprio construtor, por método privado (`validaNome(...)`), lançando
exceção de domínio. Todo endpoint de mutação usa `@Valid @RequestBody`.

**RSB-06 · Nunca retornar entidade JPA pela API** 🔴 — o fluxo é `RequestDTO → Service → Entity →
ResponseDTO`, com DTO como `record`. Expor a entidade acopla o contrato público ao schema.

**RSB-07 · Status HTTP por `@ResponseStatus` + DTO direto** 🟡 — `ResponseEntity` é ruído quando o
status é fixo. Use-o apenas quando o status ou os headers forem realmente dinâmicos; o handler global
é exceção legítima.

**RSB-08 · Erro por `DomainException` + `ErrorCode` + `@RestControllerAdvice`** 🔴 — resposta em
`ProblemDetail` (RFC 7807), status derivado do próprio `ErrorCode`. Proibido try-catch de erro de
negócio dentro do controller.

**RSB-09 · `@Transactional` na classe do service, `readOnly = true` em leitura** — e atenção à
self-invocation: chamada de método interno da mesma classe não passa pelo proxy.

**RSB-10 · Nenhum I/O externo dentro de `@Transactional`** 🔴 — HTTP, SMTP, fila e S3 fora da
transação. Conexão de banco presa esperando rede é o caminho curto para exaustão de pool.

**RSB-11 · `FetchType.LAZY` em toda associação** — `EAGER` é o N+1 que ninguém pediu. Carregue o que
precisa por `join fetch` ou projeção.

**RSB-12 · Campo de estado não tem setter público** 🔴 — transição só por método de domínio que valida
a origem (`confirmar()` recusa quem já está cancelado).

**RSB-13 · Migration versionada é a fonte de verdade do schema** 🔴 — Flyway/Liquibase em `dev` e
`prod`; `ddl-auto` no máximo `validate` fora do perfil de teste. Migration aplicada é imutável:
correção é migration nova.

**RSB-14 · Configuração só em YAML** — sem `.properties` novos. Perfis `dev`/`test`/`prod`
explícitos, valores por `@ConfigurationProperties` tipado, segredo por variável de ambiente ou `.env`
não versionado, com `.example` versionado ao lado.

**RSB-15 · Log `[start]`/`[finish]` em método público de service** —
`log.info("[start] XService - metodo")` e `log.debug("[finish] XService - metodo")`. Mantenha um
único formato por projeto e registre qual é.

**RSB-16 · Idempotência gravada antes do processamento** 🔴 — webhook e consumidor de fila persistem
a chave em transação própria e **depois** processam. Gravar no fim reprocessa tudo que falhar no meio.

**RSB-17 · Endpoint novo entra com regra de segurança explícita** — não confie no fallback do
`SecurityConfig`; a regra ausente é descoberta em produção.

**RSB-18 · Integração externa nasce com ACL** — DTO de terceiro nunca atravessa para a camada de
aplicação. Traduza na borda.

---

# 7 · Python (`RPY`)

**RPY-01 · `from __future__ import annotations` no topo de todo módulo.**

**RPY-02 · Type hint em toda função** 🔴 — parâmetros e retorno, inclusive `-> None`. Função sem
anotação não é verificável.

**RPY-03 · Sintaxe moderna de tipo** — `str | None` (nunca `Optional[str]`), `list[X]`, `dict[str, X]`,
`tuple[int, ...]`. Nada de importar `List`, `Dict`, `Optional` de `typing`.

**RPY-04 · Sem `import *`** 🔴 — e imports absolutos (`from app.config.settings import settings`),
ordenados stdlib → terceiros → local, com ruff cuidando da ordem.

**RPY-05 · Ruff é o árbitro** — `select = ["E", "F", "I", "N", "W"]`, `line-length = 100`, mais
`ruff format`. Divergência de estilo não vai para revisão humana.

**RPY-06 · Pydantic v2 na borda, dataclass no núcleo** — `BaseModel` + `field_validator` +
`model_config` para o que entra e sai do sistema; `@dataclass(frozen=True)` para modelo interno.

**RPY-07 · Sem argumento default mutável** 🔴 — `def f(x: list[int] | None = None)`, nunca `= []`.

**RPY-08 · `logging` ou loguru, nunca `print`** — com tags consistentes: `[start]`, `[finish]`,
`[error]`, `[fallback]`.

**RPY-09 · `raise ... from e` ao reempacotar exceção** — perder o encadeamento apaga a causa raiz.
E nunca `except Exception: pass` (RG-08).

**RPY-10 · Recurso sempre em context manager** — arquivo, conexão, lock, sessão. `with`, ou
`contextlib.closing`.

**RPY-11 · Rota FastAPI é `async`, e nada de bloqueio dentro de corrotina** 🔴 — chamada síncrona de
rede, disco ou CPU vai para `run_in_executor`/`asyncio.to_thread`. Um `requests.get` dentro de `async
def` trava o event loop inteiro.

**RPY-12 · `pathlib` em vez de `os.path`** — e nunca concatenação de string para caminho.

**RPY-13 · Função com menos de 50 linhas, sem variável não utilizada (F841).**

**RPY-14 · Dependências travadas e ambiente isolado** — `uv`/`venv`, versões fixadas em
`pyproject.toml`, lockfile versionado.

**RPY-15 · Ports & Adapters estrito** 🔴 — O núcleo (`core/`) nunca importa I/O, UI, HTTP ou frameworks externos. Portas são declaradas em `ports/` como `typing.Protocol`; modelos de domínio como `@dataclass(frozen=True)`; injeção de adaptadores concretos ocorre exclusivamente no composition root (`app/`).

---

# 8 · TypeScript (`RTS`)

**RTS-01 · `strict: true`** 🔴 — e `strictTemplates` quando houver Angular. Projeto sem strict não tem
tipos, tem sugestões.

**RTS-02 · Proibido `any`** 🔴 — use `unknown` mais type guard, ou generic. `any` desliga o compilador
exatamente onde ele seria útil.

**RTS-03 · `import type` para import só de tipo** — evita import circular e peso desnecessário no
bundle.

**RTS-04 · `@ts-ignore` proibido; `@ts-expect-error` só com justificativa** 🟡 — a justificativa vai
no PR e a linha tem prazo. Supressão silenciosa é dívida sem credor.

**RTS-05 · `const` por padrão** — `let` só quando há reatribuição real; `var` nunca.

**RTS-06 · Named export** — `export default` apenas para componente de página/rota. Default export
quebra rename automático e torna o import inconsistente entre arquivos.

**RTS-07 · `interface` para props e contrato, `type` para union e mapeamento.**

**RTS-08 · `??` e `?.` em vez de `||`** — `||` engole `0`, `''` e `false`, que costumam ser valores
legítimos.

**RTS-09 · Model só existe se houver DTO real no contrato do backend** 🔴 — gere ou confira contra o
OpenAPI. Interface inventada é RG-17 com aparência de tipagem.

**RTS-10 · Sem `console.log` em código entregue** 🔴 (RG-10) — use o serviço de log do projeto.

**RTS-11 · Arquivo de componente com menos de 200 linhas** — passou disso, extraia componente,
hook ou serviço.

---

# 9 · Angular (`RNG`)

**RNG-01 · Standalone, sem `NgModule`** 🔴 — e toda rota por `loadComponent`.

**RNG-02 · `ChangeDetectionStrategy.OnPush` em todo componente** 🔴.

**RNG-03 · Estado em Signals** — `signal()` para o que muda, `computed()` para o que deriva. Sem campo
mutável de estado de servidor dentro do componente.

**RNG-04 · Signal atualiza por nova referência** 🔴 — a igualdade é `Object.is`. Mutar o array em
`.set()` não dispara nada; use `[...lista, item]` / `{...obj, campo}`.

**RNG-05 · `inject()` em vez de parâmetro de construtor.**

**RNG-06 · `input.required<T>()` / `input<T>()` / `output<T>()`** — nunca os decoradores `@Input`/
`@Output` em código novo.

**RNG-07 · Componente nunca chama `HttpClient`** 🔴 — o fluxo é `Component → Service → HttpClient`.
Componente lê signal do State e chama método do Service.

**RNG-08 · Par State + Smart Service por domínio** — `<dominio>.state.ts` é `@Injectable` só com
signals e sem lógica; `<dominio>.service.ts` injeta `HttpClient`, o State e o token de URL base, e
cada método faz `carregando → HTTP → tap(muta state) → catchError(normaliza, grava, relança)`.

**RNG-09 · Regra de negócio no service, nunca no componente** — componente de apresentação recebe
tudo por `input()` e emite por `output()`.

**RNG-10 · `@if` / `@for` com `track`** 🔴 — sem `track` estável o Angular recria a lista inteira.

**RNG-11 · Sem `.subscribe()` aninhado** 🔴 — `switchMap`, `concatMap`, `forkJoin` ou signals.
Subscription manual tem `takeUntilDestroyed()`.

**RNG-12 · Erro normalizado num único formato** — converta qualquer falha (RFC 7807, erro HTTP cru,
erro de cliente) pelo utilitário do projeto. Nunca leia `err.error.message` na mão.

**RNG-13 · Interceptors centralizados** — JWT, refresh, retry e correlação de erro em um lugar, não
espalhados por service.

---

# 10 · React (`RRE`)

**RRE-01 · Function component com `interface Props` explícita** — nunca props tipadas inline.

**RRE-02 · Hook customizado prefixado com `use`, com named export** — default export só para página.

**RRE-03 · `useEffect` com cleanup** 🔴 — todo listener, timer, subscription e request cancelável é
desfeito no retorno. Effect sem cleanup vaza.

**RRE-04 · Estado derivado se calcula, não se sincroniza** 🔴 — `useEffect` que só copia prop para
state cria um render extra e uma fonte de verdade duplicada.

**RRE-05 · `key` estável e de domínio** — índice de array só quando a lista nunca reordena nem filtra.

**RRE-06 · Lógica em hook, não inline no JSX** — o corpo do componente descreve o que renderiza.

**RRE-07 · Camada não importa de camada superior** 🔴 — `app > pages > widgets > features > entities >
shared`, e `shared/` não importa nada do projeto. Violação de direção é o começo do ciclo.

**RRE-08 · Store (Zustand/Redux) exposto por selector** — componente assina a fatia que usa, não o
store inteiro.

---

# 11 · Banco e persistência (`RDB`)

**RDB-01 · Toda mudança de schema é migration versionada** 🔴 — nomeada `V<N>__descricao.sql`,
imutável depois de aplicada.

**RDB-02 · Coluna nova nasce nullable no DDL** 🟡 (H-11) — a obrigatoriedade vive no construtor de
domínio. `ddl-auto=update` não adiciona `NOT NULL` a tabela com linhas: loga WARN e sobe sem a coluna.
Com migration versionada, a restrição pode nascer no DDL.

**RDB-03 · Índice em toda FK e em toda coluna de filtro frequente** — e o `EXPLAIN` da query nova faz
parte da entrega quando a tabela for grande.

**RDB-04 · Dinheiro em `numeric`/`decimal`, instante em `timestamptz`** 🔴 — `float` para dinheiro e
`timestamp` sem fuso são defeitos de modelagem, não preferência.

**RDB-05 · `snake_case` para tabela e coluna, singular para tabela de entidade** — e o nome diz o
domínio, não a tecnologia.

**RDB-06 · Enum persistido que ganha valor novo exige alteração do `CHECK`/tipo** 🔴 — nenhum
`ddl-auto` reescreve constraint existente; o valor novo falha só no primeiro insert.

**RDB-07 · Toda tabela de negócio tem auditoria** — `criado_em`, `atualizado_em` e a identidade de
quem alterou, quando o domínio exigir rastreio.

**RDB-08 · Delete em produção é lógico até prova em contrário** 🟡 — apagar linha é irreversível; e a
regra do negócio quase sempre quer o histórico.

---

# 12 · Docker (`RDK`)

**RDK-01 · Multi-stage build** — estágio `builder` e estágio `runtime`. Imagem final não carrega
toolchain.

**RDK-02 · Nunca rodar como `root`** 🔴 — crie usuário não-privilegiado e use `USER`.

**RDK-03 · `HEALTHCHECK` obrigatório em serviço de produção** — e `depends_on` com `condition:
service_healthy` no compose.

**RDK-04 · Tag de imagem fixada** 🔴 — `postgres:16-alpine`, nunca `latest`. Build reprodutível é
requisito, não luxo.

**RDK-05 · Nenhum segredo no `Dockerfile` nem no `docker-compose.yml`** 🔴 — via `.env` não
versionado ou gerenciador de segredo. `ARG` de build fica na história da imagem.

**RDK-06 · Volume nomeado para dado persistente, porta mapeada explicitamente** — `"5432:5432"`,
nunca `"5432"` sozinho.

**RDK-07 · `.dockerignore` cobrindo `.git`, `node_modules`, `target`, `.venv`, `.env`.**

---

# 13 · CI/CD (`RCI`)

**RCI-01 · Todo PR roda lint, teste e build** 🔴 — e o CI é a mesma coisa que roda localmente, não uma
variante.

**RCI-02 · Segredo só por `${{ secrets.X }}`** 🔴 — nunca literal, nunca em `env` de workflow público,
e nunca ecoado em log de step.

**RCI-03 · Action fixada por SHA ou tag maior confiável** — `uses: actions/checkout@v4` no mínimo;
`@main` é execução de código de terceiro sem controle de versão.

**RCI-04 · Cache de dependência configurado** — `uv`, `npm`, `~/.m2`, Gradle.

**RCI-05 · Timeout explícito em todo job** — ~10 min para CI, ~30 min para release. Job pendurado
consome runner e esconde falha.

**RCI-06 · Permissão mínima no `GITHUB_TOKEN`** — `permissions: contents: read`, elevando só onde
precisa.

**RCI-07 · Workflow pesado não roda em todo push de branch de feature** — economize runner com
`paths` e `on.pull_request`.

---

# 14 · Configuração declarativa (`RCFG`)

Aqui a `RG-01` se inverte: nestes arquivos **o comentário é bem-vindo**, porque não existe nome de
função onde esconder a intenção.

**RCFG-01 · Comentário em YAML, `.properties`, `Dockerfile`, workflow e migration explica o *porquê*
do valor** — `# 30min: janela do gateway de pagamento`, não `# define o timeout`.

**RCFG-02 · Nenhum valor sensível no arquivo versionado** 🔴 — apenas `${VAR:}` ou placeholder.

**RCFG-03 · Todo arquivo de segredo tem um `.example` versionado ao lado** — `.env.example`,
`application-dev.yml.example`, com todas as chaves e valores fictícios.

**RCFG-04 · Um formato por projeto** — se o projeto é YAML, não introduza `.properties`.

**RCFG-05 · Configuração é tipada no código** — `@ConfigurationProperties`, `BaseSettings`, schema de
env. Ler `System.getenv` espalhado pelo código é configuração sem contrato.

---

## Procedência

| Família | De onde vem |
|---|---|
| `RG`, `RGIT` | Pedido explícito do responsável (2026-08-04) + convenções observadas em `K.A.O.S/.opencode/rules/`, `inscreveai/.agents/AGENTS.md` e prática corrente de AGENTS.md na indústria |
| `RSEC`, `RTEST`, `RDB` | Auditoria de segurança do InscreveAI (`P_Novo4`–`P_Novo21`, evidência em `docs/audit/`) e heurísticas H-08, H-10, H-11, H-12, H-18 da KB |
| `RJ`, `RSB` | 24 regras globais da WWMA-Tech + padrões `P1`–`P6` de domínio rico + Wakanda (ports/adapters, ACL) + CTM (monólito modular, Flyway) |
| `RPY` | `K.A.O.S/.opencode/rules/python.md`, `ruff.toml` do kernel e do laboratório |
| `RTS`, `RNG`, `RRE` | `K.A.O.S/.opencode/rules/{typescript,react}.md` + convenções Angular 22 do InscreveAI |
| `RDK`, `RCI`, `RCFG` | `K.A.O.S/.opencode/rules/{docker,github-actions}.md` + `RSB-14` |

Invariantes e heurísticas citadas (`I-**`, `H-**`, `AP-**`, `P**`) vivem em
[kb/06](kb/06-heuristicas-e-invariantes.md) e [kb/05](kb/05-antipadroes.md) — este arquivo as aplica
ao código, não as substitui.

**Manutenção.** Teste de inclusão, linha a linha: *"remover esta regra faria o agente errar?"* Se não,
apague (AP-02). Regra que o agente já cumpre sem ser instruído deve sair (H-03). Regra que precisou de
exceção duas vezes não era 🔴 — rebaixe e registre o caso.
