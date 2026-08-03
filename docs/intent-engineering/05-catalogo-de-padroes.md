# 05 — Catálogo de padrões e anti-padrões

Formato adaptado da tradição de padrões em Software Architecture (Alexander; GoF; POSA)
`[CONSOLIDADO]`: contexto → problema → solução → forças → **quando não usar**. A última seção é a que
distingue catálogo de propaganda.

Todo padrão declara `origem` (de onde vem) e `selo` (natureza da evidência).

---

# Parte I — Padrões

## PA-01 · Constituição Executável

**Selo:** `[INDÚSTRIA]` · **Origem:** Constitutional AI (Anthropic, 2022); hierarquia de metas em KAOS;
hierarquia normativa em Direito. **Princípio:** P8.

**Contexto.** Múltiplos artefatos de intenção em níveis diferentes, produzidos por pessoas e agentes
distintos ao longo do tempo.
**Problema.** Sem regra de precedência, cada conflito é renegociado do zero e resolvido por quem
estiver mais perto do teclado.
**Solução.** Um documento curto de N6–N5 com autoridade declarada sobre todos os demais. Executores
são obrigados a **parar e reportar** ao detectar conflito, nunca a resolver.
**Forças.** Estabilidade × capacidade de evoluir; brevidade × cobertura.
**Quando não usar.** Projeto de curta duração, uma pessoa, escopo fechado — o custo de manter excede o
benefício.
**Teste de saúde.** Se nenhum artigo já barrou uma decisão que alguém queria tomar, é decoração.
Constituição saudável **incomoda**.

## PA-02 · Escada Explícita

**Selo:** `[CONSOLIDADO]` · **Origem:** refinamento de metas em KAOS; modelo em V. **Princípio:** P4.

**Contexto.** Pedido de alto nível que precisa virar execução.
**Problema.** O salto direto de propósito a instrução esconde as decisões intermediárias, que passam a
ser tomadas implicitamente pelo executor.
**Solução.** Descer um nível por vez, com o artefato de cada nível apontando explicitamente o superior
que o justifica.
**Forças.** Rigor × velocidade. É o padrão mais caro do catálogo.
**Quando não usar.** Tarefa reversível, pequena e local. Aplicar a escada completa a uma correção de
typo é caricatura — e é assim que processos morrem por descrédito.

## PA-03 · Marcador de Ambiguidade Bloqueante

**Selo:** `[HIPÓTESE]` · **Origem:** impasse do SOAR; iniciativa mista (Horvitz, MSR, 1999).
**Princípio:** P9.

**Contexto.** Especificação incompleta entregue a executor que consegue preencher lacunas.
**Problema.** O executor preenche e não sinaliza; a divergência só aparece na entrega.
**Solução.** Notação explícita (`[PRECISA ESCLARECER: pergunta]`) que **impede** a fase seguinte de
iniciar. A pergunta é dirigida ao Titular.
**Forças.** Precisão × atrito. Excesso produz executor que pergunta demais e é desligado.
**Quando não usar.** Quando reverter é mais barato que perguntar. Calibre pelo **custo de reversão**,
nunca pelo tamanho da tarefa.
**Já implementado** no seu fluxo SDD — é o mecanismo mais valioso que ele tem.

## PA-04 · Análise de Obstáculos

**Selo:** `[CONSOLIDADO]` · **Origem:** van Lamsweerde & Letier, *Handling Obstacles in Goal-Oriented
RE*, IEEE TSE, 2000.

**Contexto.** Metas definidas, requisitos sendo derivados.
**Problema.** Requisitos derivados apenas do caminho feliz produzem sistemas frágeis; casos de borda
aparecem em produção.
**Solução.** Para cada meta, gerar sistematicamente as condições que a impediriam de ser satisfeita, e
derivar requisitos que as tratem. A geração é sistemática — negação da meta, decomposição da negação —
não brainstorming.
**Forças.** Robustez × explosão combinatória.
**Quando não usar.** Domínios onde a falha é barata e observável.
**Nota:** é a técnica de RE com melhor razão valor/esforço deste catálogo, e é sistematicamente ignorada
pela prática atual com agentes. Sua seção "Regras de negócio e casos de borda" no template de spec é
uma versão informal disto.

## PA-05 · Contrato Antes de Código

**Selo:** `[CONSOLIDADO]` · **Origem:** Design by Contract (Meyer, 1992); design de API primeiro.
**Princípio:** P2, P4.

**Contexto.** Executor com liberdade de implementação.
**Problema.** Interfaces inventadas durante a execução divergem entre módulos e entre iterações.
**Solução.** Assinaturas, schemas e formatos de erro fixados no nível N2 antes de qualquer execução. O
executor que descobre o contrato inviável **para e reporta** — não o corrige por conta própria.
**Forças.** Estabilidade × descoberta tardia de inadequação.
**Quando não usar.** Exploração genuína, onde o contrato só é conhecível depois de tentar.

## PA-06 · Refinamento por Amostra

**Selo:** `[EXPERIMENTAL]` · **Origem:** criteria drift (Shankar et al., UIST 2024); EvalGen.
**Princípio:** P11.

**Contexto.** Critérios de qualidade que os interessados não conseguem enunciar a priori.
**Problema.** Exigir critérios completos antes de ver resultados é impossível — o estudo mostra que
alguns critérios *dependem* da observação das saídas.
**Solução.** Produzir um lote pequeno de resultados deliberadamente diversos, julgar caso a caso e
**promover os julgamentos a critérios escritos**. A spec é atualizada a partir dos julgamentos, não o
contrário.
**Forças.** Realismo × risco de racionalizar o que foi produzido.
**Quando não usar.** Quando executar é caro ou irreversível.
**Salvaguarda obrigatória.** Quem julga a amostra tem de ser o Titular, não o Executor — caso
contrário o critério é ajustado para caber no resultado (modo de falha "especificador que também
executa", [04](04-arvore-de-responsabilidades.md) §5). **Este padrão é seguro apenas com a separação
de papéis intacta.**

## PA-07 · Envelope de Autonomia

**Selo:** `[HIPÓTESE]` · **Origem:** níveis de automação (Parasuraman, Sheridan & Wickens, 2000);
direitos residuais de controle (Hart & Moore). **Princípio:** P10.

**Contexto.** Delegação de tarefas a agentes com capacidade variável.
**Problema.** A autonomia é tratada como configuração global do sistema, quando o nível adequado varia
por tarefa e por custo do erro.
**Solução.** Cada tarefa declara três campos: **decide sozinho** / **consulta antes** / **proibido**.
O default vem da classe da tarefa; declaração explícita só no desvio.
**Forças.** Segurança × burocracia.
**Quando não usar.** Tarefas homogêneas e de baixo risco, onde um default global basta.

## PA-08 · Registro de Interpretação

**Selo:** `[HIPÓTESE]` · **Origem:** direcionabilidade e common ground (Klein et al., 2004); golfo de
avaliação (Norman). **Responsabilidade:** R3.4.

**Contexto.** Executor interpretativo preenchendo lacunas inevitáveis da especificação.
**Problema.** Interpretações desaparecem dentro do resultado; a divergência é indetectável até a
consequência.
**Solução.** O executor registra, junto à entrega, cada lacuna que precisou preencher e a escolha que
fez. Lista curta, em linguagem natural, não estruturada.
**Forças.** Visibilidade × ruído. Registrar toda micro-decisão é inútil; o filtro é *"outro executor
competente poderia ter escolhido diferente?"*.
**Quando não usar.** Tarefas totalmente especificadas, onde não há lacuna real.

## PA-09 · Verificador Adversarial Independente

**Selo:** `[CONSOLIDADO]` · **Origem:** V&V independente (Systems Engineering); red-teaming; Popper.
**Princípio:** P7.

**Contexto.** Resultado entregue por um executor.
**Problema.** Auto-verificação converge para confirmação; o executor herda as próprias premissas.
**Solução.** Verificação em **contexto separado**, com a postura de refutar, exigindo evidência citável
e buscando também implementação sem requisito.
**Forças.** Rigor × custo.
**Quando não usar.** Quando o critério é trivialmente automatizável — aí o teste é o verificador, e
duplicar é desperdício.

## PA-10 · Rastreabilidade Bidirecional

**Selo:** `[CONSOLIDADO]` · **Origem:** ISO/IEC/IEEE 29148; Systems Engineering. **Princípio:** P1, P6.

**Contexto.** Cadeia de artefatos em vários níveis.
**Problema.** Sem ligação explícita, não se detecta requisito sem implementação nem implementação sem
requisito.
**Solução.** Matriz explícita: cada critério aponta as tarefas que o cobrem; cada tarefa aponta o
critério que a justifica.
**Forças.** Auditabilidade × custo de manutenção.
**Quando não usar.** Escopo pequeno o suficiente para caber na cabeça de uma pessoa.
**Alerta.** É o padrão que mais frequentemente degenera em *rastreabilidade fantasma* (AP-08).

## PA-11 · Intenção Compilada

**Selo:** `[RECENTE]` · **Origem:** DSPy (Khattab et al., Stanford, ICLR 2024); RFC 9315; separação
política/mecanismo. **Princípio:** P5.

**Contexto.** Intenção que precisa ser executada por modelos que mudam.
**Problema.** Prompt otimizado à mão vira ativo frágil: expira com a versão do modelo e não é
reaproveitável.
**Solução.** Declarar a intenção como assinatura/objetivo estável e **gerar** a formulação para o
executor concreto, tratando-a como artefato descartável.
**Forças.** Durabilidade × necessidade de métrica automatizável.
**Quando não usar.** Sem métrica ou conjunto de avaliação, não há o que compilar contra — e o padrão
vira indireção sem ganho.

## PA-12 · Ponto de Recompromisso

**Selo:** `[HIPÓTESE]` · **Origem:** Bratman (1987) — intenção resiste à reconsideração, mas
reconsiderar às vezes é racional; teoria de *commitment strategies* em BDI.

**Contexto.** Execução longa sob intenção fixada.
**Problema.** Dois extremos ruins: reconsiderar a cada passo (não há intenção, há oscilação) e nunca
reconsiderar (persistência em meta obsoleta).
**Solução.** Definir **de antemão** os gatilhos que autorizam reabrir a intenção: fim de fase, falha de
critério, mudança de premissa registrada. Fora deles, a intenção é estável por construção.
**Forças.** Estabilidade × adaptação — é a formulação de engenharia do dilema clássico de BDI.
**Quando não usar.** Horizontes curtos, onde replanejar é barato.

---

# Parte II — Anti-padrões

## AP-01 · Teatro de Conformidade

**Sintoma.** Existem constituição, spec e ADRs, e nenhuma decisão real foi alterada por eles.
**Mecanismo.** O artefato é produzido para satisfazer o processo, não para restringir a decisão.
**Origem do diagnóstico:** problema de Grudin (CSCW, 1988) — quem paga o custo não colhe o benefício.
`[CONSOLIDADO]`
**Detecção.** Peça um caso em que o documento barrou algo. Se não houver, é teatro.
**Correção.** Reduzir drasticamente o artefato até sobrar apenas o que morde.

## AP-02 · Salto de Nível

**Sintoma.** Propósito (N5) vira instrução (N1) sem passar por metas, requisitos e restrições.
**Mecanismo.** As decisões intermediárias continuam sendo tomadas — só que pelo executor, sem
autoridade e sem registro.
**Consequência típica.** Resultado plausível, defensável linha a linha, e errado no conjunto.
**Detecção.** Pergunte de qual requisito uma escolha de implementação decorre. Silêncio = salto.

## AP-03 · Spec como Despejo de Contexto

**Sintoma.** A "especificação" é um acúmulo de tudo que se sabe: histórico, preferências, trechos de
conversa, exemplos de código.
**Mecanismo.** Confusão entre *transmitir* (context engineering) e *representar* (intenção). Mais
contexto ≠ mais intenção.
**Evidência de dano.** Degradação de atenção em contextos longos (*context rot*) `[INDÚSTRIA]`.
**Correção.** A spec responde ao quê e ao porquê. Material de apoio vai para outro lugar, referenciado.

## AP-04 · Verificação Confirmatória

**Sintoma.** O relatório de verificação lista o que funciona e conclui "tudo certo".
**Mecanismo.** Viés de confirmação `[CONSOLIDADO]`, agravado quando executor e verificador partilham
contexto.
**Detecção.** Relatório sem nenhuma evidência negativa, ou sem saída real de comando.
**Correção.** PA-09; exigir a busca por implementação sem requisito.

## AP-05 · Proxy Capturada

**Sintoma.** A métrica melhora, o resultado piora.
**Mecanismo.** Lei de Goodhart; specification gaming. `[CONSOLIDADO]`
**Origem estrutural.** Um softgoal (N4) foi convertido em critério binário (N3) sem que a substituição
fosse registrada como aproximação.
**Correção.** Declarar explicitamente toda proxy como proxy, com a meta que ela aproxima e a hipótese
de correspondência — que passa a ser falseável junto com o resto.

## AP-06 · Ambiguidade Silenciosa

**Sintoma.** O executor entrega algo coerente; ninguém sabe quantas decisões ele tomou pelo caminho.
**Mecanismo.** Implicatura de Grice sem common ground `[CONSOLIDADO]`: o executor infere e a inferência
é invisível.
**Correção.** PA-03 e PA-08.
**Nota.** Este é o anti-padrão **definidor** da disciplina. Se só um item deste catálogo for combatido,
é este.

## AP-07 · Intenção Órfã

**Sintoma.** Requisito, tarefa ou trecho de código que não sobe para nenhuma meta.
**Mecanismo.** Escopo ampliado, requisito herdado de contexto morto, ou boa ideia inserida a meio
caminho.
**Detecção.** Rastreabilidade ascendente. É a checagem mais barata do catálogo e quase nunca é feita.
**Correção.** Ou sobe, ou sai.

## AP-08 · Rastreabilidade Fantasma

**Sintoma.** A matriz existe, está completa, e não corresponde ao código.
**Mecanismo.** A matriz é atualizada por obrigação, não por uso.
**Origem do diagnóstico:** o mesmo Grudin de AP-01. `[CONSOLIDADO]`
**Correção.** Rastreabilidade **verificada** (PA-09 confere a matriz contra o código) ou nenhuma.
Matriz não verificada é pior que ausência, porque produz confiança falsa.

## AP-09 · Delegação sem Envelope

**Sintoma.** "Faça o que for necessário."
**Mecanismo.** Ausência de direitos residuais de controle declarados; o executor decide nas lacunas
sem que ninguém tenha decidido que ele decidiria. `[CONSOLIDADO]` (contratos incompletos)
**Consequência.** Responsabilidade evaporada (P12).
**Correção.** PA-07.

## AP-10 · Constituição Genérica

**Sintoma.** Artigos como "buscar a qualidade" e "priorizar o usuário".
**Mecanismo.** Enunciado que nenhuma decisão real violaria não restringe nada.
**Teste.** Para cada artigo: *que decisão plausível e tentadora isto proíbe?* Sem resposta, apague o
artigo.
**Correção.** Trocar por restrições que doem: "nenhuma dependência com licença copyleft", "nenhum
endpoint público sem rate limit".

## AP-11 · Executor que Verifica a Si Mesmo

**Sintoma.** A mesma sessão implementa e depois audita.
**Mecanismo.** Compartilhamento de contexto e de premissas; a verificação herda o erro.
**Estrutural, não moral** — não é questão de honestidade do agente.
**Correção.** Contexto separado, obrigatoriamente.

## AP-12 · Especificação Fossilizada

**Sintoma.** A spec está completa, aprovada e desatualizada há meses; a equipe trabalha pelo código.
**Mecanismo.** Deriva de intenção sem laço de reconciliação; ausência do ciclo
`Detecção de deriva → Metas` do mapa de dependências.
**Detecção.** Taxa de revisão da spec igual a zero durante execução ativa é sinal de alarme, não de
maturidade (P11).
**Correção.** PA-12 — gatilhos de recompromisso definidos de antemão.

---

## Índice cruzado padrão × princípio × anti-padrão que combate

| Padrão | Princípio | Combate |
|---|---|---|
| PA-01 Constituição Executável | P8 | AP-10, AP-01 |
| PA-02 Escada Explícita | P4 | AP-02, AP-07 |
| PA-03 Marcador Bloqueante | P9 | AP-06 |
| PA-04 Análise de Obstáculos | P2 | — (previne defeito, não anti-padrão) |
| PA-05 Contrato Antes de Código | P2, P4 | AP-02 |
| PA-06 Refinamento por Amostra | P11 | AP-12 |
| PA-07 Envelope de Autonomia | P10 | AP-09 |
| PA-08 Registro de Interpretação | R3.4 | AP-06 |
| PA-09 Verificador Adversarial | P7 | AP-04, AP-08, AP-11 |
| PA-10 Rastreabilidade Bidirecional | P1, P6 | AP-07 |
| PA-11 Intenção Compilada | P5 | AP-03 |
| PA-12 Ponto de Recompromisso | — (Bratman) | AP-12 |

---

**Anterior:** [04 — Árvore de responsabilidades](04-arvore-de-responsabilidades.md) · **Próximo:** [06 — Decisões arquiteturais](06-decisoes-arquiteturais.md)
