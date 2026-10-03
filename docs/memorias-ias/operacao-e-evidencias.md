# Operação, evidências e aprendizado

Aprendizados `[CAMPO]` de trabalhos anteriores, consolidados em 2026-10-03. As referências locais
são resolvidas em [fontes e cobertura](fontes-e-cobertura.md); não houve revalidação dos produtos.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## O que cada evidência permite afirmar

| Evidência | Demonstra | Limite recorrente |
|---|---|---|
| Inspeção de código e diff | Estrutura e comportamento previsto naquele recorte | Não prova execução, persistência nem experiência do usuário. |
| Teste e build | Resultado do comando e dos cenários realmente executados | Uma falha antes de iniciar testes é limite do ambiente; aprovação focada não é aceite integral. |
| API e banco | Contrato observado e efeitos persistidos no cenário | Fixtures não comprovam fornecedor externo ou ambiente de produção. |
| Navegador | Jornada, rede e interface observadas | Viewport móvel não comprova Android/iOS nativo; tela final não prova todos os eventos anteriores. |
| PDF e download | Conteúdo inspecionado e bytes obtidos | Hash idêntico prova preservação, não confiança jurídica ou criptográfica. |
| Certificado e assinatura | Propriedades criptográficas que foram efetivamente verificadas | Validade temporal, chave privada, cadeia, revogação e confiança são verificações distintas. |
| SHA e manifesto | Identidade do recorte ou integridade dos arquivos | Resultado anterior não cobre automaticamente um HEAD posterior. |

Fontes: `MEMORY.md:L160-L251`, `L297-L341`, `L520-L595` e `L1249-L1276`;
casos [PetJus](casos/petjus.md) e [ferramentas](casos/labs-e-ferramentas.md).

## Falhas que renderam procedimentos melhores

| Contexto histórico | Falha observada | Aprendizado e limite |
|---|---|---|
| SPEC-012, anexos | Interceptação com `route.fetch()` perdeu conteúdo multipart. | Preservar o POST nativo e testar perda da resposta após persistência separadamente de falha antes do servidor. `MEMORY.md:L447-L490`. |
| SPEC-012, abertura de formulário | Contexto do paciente ainda não carregado gerou identificador inválido. | Testar corrida entre carregamento e ação do usuário; bloquear envio sem contexto válido. Mesmo registro. |
| SPEC-015, validação visual | Bundle em cache podia exibir interface antiga. | Conferir build servido e invalidar cache antes de produzir evidência de alteração. `MEMORY.md:L160-L204`. |
| WAI-396, jornadas | Regra da próxima missão chegou a desfazer uma conclusão válida. | Separar conclusão atual de elegibilidade da próxima; proteger criação concorrente na persistência. `MEMORY.md:L69-L100`. |
| WAI-256, dados históricos | Ausência de fonte para datas antigas. | Manter desconhecido o que não tem procedência; não estimar a partir de timestamps relacionados. `MEMORY.md:L1-L42`. |
| Instalação de skills | Integridade de arquivo foi confundida com capacidade operacional. | Conferir origem/revisão, depois dependências e uso real; registrar cada nível separadamente. `MEMORY.md:L792-L836`. |
| Escopo autorizado | Houve implementação/publicação além da autorização em registros anteriores. | Verificar a ação autorizada no contexto atual; não tratar histórico de aprovação como permissão permanente. `MEMORY.md:L84-L99` e `L485-L490`. |

## Operação sem perda de trabalho

- **Git e worktrees:** conferir o repositório real, status, diff e arquivos não rastreados antes de
  sincronizar ou publicar. PetJus possui repositórios separados; a raiz contêiner não substitui o
  estado de cada um. Fontes: `MEMORY.md:L1146-L1171` e `L676-L741`.
- **Docker:** inventariar containers, projetos e volumes; a lista de preservação de um incidente
  não é autorização para uma limpeza futura. Fonte: `MEMORY.md:L44-L67`.
- **Integrações financeiras:** separar sandbox do provedor, fixtures da aplicação e prova externa;
  conferir idempotência e efeito persistido. Fonte: `MEMORY.md:L987-L1028` e `L1173-L1206`.
- **Túneis:** um arquivo de roteamento correto não comprova acesso externo; verificar o caminho
  autorizado e o fallback. Fonte: `MEMORY.md:L1057-L1078`.
- **Áudio:** preservar a distinção entre processamento local e envio a fornecedor autorizado;
  não levar áudios pessoais para o acervo de práticas. Fonte: `MEMORY.md:L1080-L1121`.

## Da lembrança à proteção verificável

Aplicar o processo canônico AL-05 em SDD Learn (`skills/sdd-learn/references/promotion.md`, snapshot local):
incidente e origem → recorrência → menor mecanismo eficaz → escopo → prova de eficácia → revisão.
Não promover automaticamente todos os itens desta página a invariantes da KB.

As [oportunidades de automação](autonomia-e-automacao.md) propõem mecanismos a partir dessas
recorrências. São propostas, sem hooks, jobs ou novas skills ativados nesta entrega.
