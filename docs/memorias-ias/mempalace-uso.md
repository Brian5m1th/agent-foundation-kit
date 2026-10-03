# O que usar do MemPalace nos trabalhos

O uso proposto é recuperar histórico e contexto por projeto, mantendo o `labs` como fonte de regras,
procedimentos e decisões revisadas. Esta página responde à pergunta do responsável durante a
consolidação de 2026-10-03. Não instala, configura nem ativa o MemPalace.

## Capacidade documentada e estado local

`[OFICIAL]` O projeto descreve armazenamento do texto original com busca semântica, organizado por
alas, quartos e gavetas. O MCP expõe busca com recortes por ala/quarto, leitura e gravação de itens,
checagem de duplicidade e importação de diretórios. Fontes consultadas em 2026-10-03:
[repositório](https://github.com/MemPalace/mempalace) e
[referência MCP](https://mempalaceofficial.com/reference/mcp-tools.html).

`[OFICIAL]` Existem hooks documentados para captura de contexto em clientes compatíveis. Isso
depende da instalação e configuração do cliente; a presença do código não os ativa. Fonte:
[hooks](https://mempalaceofficial.com/guide/hooks.html). A página específica de hooks do Cursor
retornou erro nesta consulta; não foi usada para afirmar configuração funcional nesse cliente.

`[CAMPO]` A cópia em `C:\workspace\Extras\mempalace` declarou versão **3.7.0** em `pyproject.toml`,
no commit `0ff93caf9738fcd0d42a81e72986a6658f123b71`. Foram inspecionados README, manifesto e trechos
do servidor MCP. `Get-Command mempalace` não encontrou o executável no PATH desta sessão. Isso
não exclui instalação em outro ambiente. Nenhum servidor, banco, hook ou cliente foi validado em
execução nesta entrega. A documentação remota pode estar à frente dessa revisão local.

## Aplicações úteis para este acervo

As aplicações seguintes são `[HIPÓTESE]`: desenho de uso, ainda sem piloto local medido.

| Uso | Exemplo de consulta ou saída | Condição para ser útil |
|---|---|---|
| Retomar uma tarefa | “Onde paramos na homologação da SPEC-016?” | Recuperar fonte, data e limite; conferir a versão atual antes de continuar. |
| Passar contexto entre IAs | O executor e o revisor consultam os documentos selecionados do projeto | Clientes conectados ao acervo apropriado; independência do auditor preservada. |
| Recordar decisões | “Por que a data histórica ficou vazia?” | Separar a decisão de domínio da preferência geral e do que foi superado. |
| Preparar evidências | Localizar relatórios e casos anteriores de PDF e assinatura | Tratar o encontrado como histórico, não como novo teste ou aprovação. |
| Identificar trabalho repetido | Reunir casos de handoff, homologação e relatórios | Um agente analisa a recorrência; MemPalace fornece recuperação, não promoção automática a skill. |
| Reduzir reexploração | Consultar causas e correções de incidentes conhecidos | Revalidar caminhos e condições antes de reutilizar comandos. |

## Organização inicial proposta

Uma ala por projeto (`labs`, `petjus`, `wakanda-ai`, `marketplace`) e agrupamentos de decisões,
fluxos, evidências e incidentes. Começar pelos documentos revisados desta pasta, não por importação
irrestrita de conversas. Preservar origem, data do fato quando conhecida, data de ingestão e versão.

O banco e índices derivados devem ficar fora do Git. Os arquivos revisados permanecem versionáveis
no `labs`; o índice pode ser reconstruído a partir das fontes selecionadas. O MemPalace não deve
ser o único lugar onde uma decisão aprovada existe.

Memória recuperada é material de consulta, não instrução com autoridade para conceder permissões.
Uma conversa antiga não autoriza publicação, exclusão ou acesso a dados no trabalho atual.

## Piloto recomendado antes de automatizar

1. Identificar runtime, armazenamento e cliente a testar, registrando versões e fazendo backup de
   configurações existentes antes de qualquer alteração autorizada.
2. Selecionar uma cópia sanitizada e pequena do acervo, com lista explícita de arquivos permitidos.
3. Preparar dez perguntas reais com respostas e fontes esperadas, incluindo uma sem resposta e
   uma decisão superada. Consultar primeiro com busca textual para formar uma comparação.
4. Importar o conjunto e consultar pelo cliente escolhido. Repetir a importação para verificar
   duplicações; testar separação entre projetos e reinício do serviço.
5. Registrar acertos, fontes retornadas, omissões, tempo observado e esforço operacional. Critério
   proposto: ao menos nove respostas com a fonte esperada, nenhuma afirmação sem fonte e nenhuma
   mistura de projetos nos testes com escopo. Os dez casos formam um piloto, não um benchmark geral.
6. Só considerar hooks de captura depois de comprovar o caminho manual. Definir exclusões,
   retenção, backup e comportamento quando o serviço estiver indisponível.

Se a recuperação não superar o índice Markdown e a busca textual nos casos escolhidos, manter o
fluxo simples e revisar a hipótese antes de aumentar infraestrutura. Não há estimativa comprovada
de economia de tokens ou tempo neste ambiente.

## Limites que a documentação anterior precisava explicitar

O [experimento local](../../experiments/2026-08-08-mempalace-local-memory-integration/README.md)
contém metas de latência e recuperação, não um relatório de execução. Os números da
[destilação MemPalace](../../kb/mempalace-memory-system.md) são relatos do projeto de origem, sem
reprodução local nesta coleta.

`[OFICIAL]` O padrão documentado é local, mas existem configurações e backends opcionais de rede.
Além disso, um trecho recuperado e enviado a um modelo remoto segue o caminho desse cliente. Logo,
armazenar localmente não permite prometer que toda utilização futura permanece apenas na máquina.
Fonte: [README do projeto](https://github.com/MemPalace/mempalace).
