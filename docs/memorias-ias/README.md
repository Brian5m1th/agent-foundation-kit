# Memórias das IAs e aprendizados de trabalho

Acervo consolidado em **3 de outubro de 2026**, por solicitação do responsável pelo `labs`.
Reúne conhecimento recuperável de memórias locais, casos de trabalho e procedimentos existentes.
Serve para humanos e agentes retomarem decisões sem carregar o histórico inteiro em cada sessão.

O conteúdo é uma destilação com procedência. Não é exportação integral de conversas nem representa
todo o conhecimento de qualquer modelo. Resultados históricos dos projetos não foram reexecutados
nesta consolidação; a data de leitura de uma memória não renova a validade de seus resultados.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## Por onde começar

| Necessidade | Documento |
|---|---|
| Entender fontes, cobertura e lacunas por IA | [Fontes e cobertura](fontes-e-cobertura.md) |
| Trabalhar conforme as preferências e o fluxo acordados | [Colaboração, fluxos e gestão](colaboracao-fluxos-gestao.md) |
| Preparar evidências e evitar falhas conhecidas | [Operação, evidências e aprendizado](operacao-e-evidencias.md) |
| Localizar uma skill e sua origem | [Inventário de skills](inventario-skills.md) |
| Recuperar casos clínicos, documentos e homologação | [PetJus](casos/petjus.md) |
| Recuperar decisões de domínio, jornadas e avaliação de missões | [WakandaAI](casos/wakanda-ai.md) |
| Recuperar casos de pagamentos, webhooks e PRs | [Marketplace](casos/marketplace.md) |
| Recuperar experiências com o kit e ferramentas | [Labs e ferramentas](casos/labs-e-ferramentas.md) |
| Entender como o MemPalace poderia ajudar | [Uso do MemPalace](mempalace-uso.md) |
| Escolher a próxima melhoria de autonomia | [Oportunidades priorizadas](autonomia-e-automacao.md) |
| Conferir entrega, alterações e verificações | [Registro da consolidação](registro-consolidacao.md) |

## Como interpretar os registros

- **`[CAMPO]` histórico:** decisão ou observação documentada em trabalho anterior, com fonte e data.
- **`[CAMPO]` observado nesta coleta:** arquivo, caminho ou conteúdo conferido em 2026-10-03.
- **`[HIPÓTESE]` proposta:** possível melhoria a avaliar; não é capacidade já implantada.
- **`[EXPERIMENTAL]`:** ensaio com escopo explícito. Uma meta do experimento não é resultado.
- **`[OFICIAL]`:** afirmação de documentação primária do fornecedor quando consultada e citada;
  não comprova funcionamento no ambiente do usuário.

Preservar os demais selos da [KB](../../kb/README.md). Uma preferência registrada no passado não
substitui a instrução atual do usuário. Casos de um projeto não se tornam regras globais por cópia.

## Consulta e manutenção

1. Localize a página pelo índice e leia apenas o recorte necessário.
2. Verifique fonte, data e limite do aprendizado antes de aplicá-lo.
3. Para decisões dependentes do estado atual, confira código, configuração ou evidência do projeto.
4. Melhore procedimentos no upstream apropriado: [skills](../../skills/README.md),
   [regras](../../RULES.md), templates ou KB; aqui mantenha o caso e a referência.
5. Registre correções com procedência, preservando decisões históricas e indicando o que foi
   superado. Consulte SDD Learn (`skills/sdd-learn/SKILL.md`, snapshot local) antes de promover uma lição a regra.

Os metadados de origem do Codex estão em [fontes-codex.json](fontes-codex.json). As memórias locais
continuam fora do Git deste repositório. Não guardar neste acervo tokens, credenciais, certificados
privados, bases clínicas, conteúdo pessoal ou transcrições brutas desnecessárias.
