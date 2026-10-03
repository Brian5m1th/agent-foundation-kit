# Sistema de Memória MemPalace `[CAMPO]`

Destilação técnica do sistema de memória local-first MemPalace ([mempalace/mempalace](https://github.com/mempalace/mempalace)).

**Qualificação da fonte em 2026-10-03:** `[CAMPO]` refere-se à inspeção do acervo de terceiro,
não a um teste em produção do usuário. A cópia local inspecionada declara 3.7.0, revisão
`0ff93caf9738fcd0d42a81e72986a6658f123b71`. As capacidades e métricas abaixo são descrições e
relatos do projeto de origem; não foram reproduzidas nesta consolidação. Metas de latência,
consumo de tokens e recall não são garantias locais. Consulte a
[avaliação de uso e piloto proposto](../docs/memorias-ias/mempalace-uso.md).

## 1. Visão Geral e Filosofia

O MemPalace é uma arquitetura de memória persistente orientada a preservar texto original e
recuperá-lo por busca. Preservação do texto não implica recuperação perfeita de todos os fatos.

### Princípios Inegociáveis
- **Verbatim Always**: Armazenamento textual bruto e exato. Nunca resumi ou parafraseia as falas e conteúdos originais no nível do armazenamento base (*drawers*). Se o usuário disse algo, armazena-se exatamente o que ele disse.
- **Ingestão incremental**: preservar fontes e evitar reconstruções destrutivas é o princípio descrito; isso não significa impossibilidade de exclusão. A [API documentada](https://mempalaceofficial.com/reference/mcp-tools.html) também expõe operações de remoção.
- **Local-First & Zero External API por Padrão**: Todo o fluxo de ingestão, chunking, embedding e busca roda localmente na máquina do usuário (ChromaDB, Ollama, SQLite).
- **Performance Budget**: metas descritas de wake-up em <100ms e hooks assíncronos em <500ms, sem medição local nesta coleta.
- **Local por padrão**: a documentação permite opções de rede e backends externos. O envio de contexto recuperado a um modelo depende do cliente; não há garantia universal de que toda utilização permaneça na máquina.
- **Background Everything**: Salvamento, indexação e extração de entidades ocorrem via hooks em background sem gastar tokens na janela de chat do agente.

---

## 2. Estrutura de Dados: Palácio da Memória & Zettelkasten

O armazenamento é organizado usando a metáfora espacial do *Method of Loci* combinada com o método *Zettelkasten*:

```
Palácio da Memória
 ├── WING (Ala): Entidade / Projeto / Pessoa / Organização
 │    └── ROOM (Quarto): Agrupamento temporal ou temático (Dia, Sessão)
 │         ├── DRAWER (Gaveta): Conteúdo textual verbatim original (chunk bruto)
 │         └── CLOSET (Armário): Índice denso no dialeto simbólico AAAK
 └── Knowledge Graph (SQLite): Triplestore temporal (Subject -> Predicate -> Object)
```

### Dialeto Simbólico AAAK (Lossy Index Layer)
O formato **AAAK** (*Structured Symbolic Summary Format*, via `mempalace/dialect.py`) é um formato simbólico compacto que extrai entidades, tópicos, citações-chave, emoções e flags de contexto. Serve como camada de índice (*closets*) apontando para os conteúdos brutos (*drawers*):

```
FILE_NUM|PRIMARY_ENTITY|DATE|TITLE
ZID:ENTITIES|topic_keywords|"key_quote"|WEIGHT|EMOTIONS|FLAGS
T:ZID<->ZID|label
```

Flags universais de contexto: `DECISION`, `PIVOT`, `TECHNICAL`, `ORIGIN`, `SENSITIVE`, `CORE`, `GENESIS`.

---

## 3. Pilha de Acionamento L0–L3 (Memory Wake-up Stack)

Para evitar estourar a janela de contexto no boot da conversa ([AP-04](05-antipadroes.md#ap-04--sessão-entulhada-)), o MemPalace organiza a recuperação em 4 camadas:

| Camada | Escopo | Token Cost | Frequência de Carga |
|---|---|---|---|
| **L0 — Identity** | Regras vitais e atributos do usuário/agente | ~100 tokens | Sempre carregado no boot |
| **L1 — Essential Story** | Top momentos e síntese auto-gerada dos mais recentes | ~500–800 tokens | Sempre carregado no boot |
| **L2 — On-Demand** | Contexto específico de Ala/Quarto ao citar uma entidade | ~200–500 tokens | Sob demanda quando mencionado |
| **L3 — Deep Search** | Busca semântica e híbrida (BM25 + Vetorial) completa | Ilimitado | Sob demanda via busca explícita |

**Custo total de boot (L0 + L1):** ~600–900 tokens (preserva >95% da janela de contexto).

---

## 4. Grafo de Conhecimento Temporal (SQLite)

Implementado em `mempalace/knowledge_graph.py`, armazena triplas de entidades com janelas temporais de validade:
- `valid_from`: Data/hora a partir da qual o fato se tornou verdadeiro.
- `valid_to`: Data/hora em que o fato deixou de ser verdadeiro.

Permite consultas pontuais no tempo (`as_of="2026-01-15"`), competindo com sistemas corporativos em nuvem sem custo de infraestrutura ou assinaturas.

---

## 5. Mitigação de Contaminação por System Prompt (`query_sanitizer.py`)

Descoberta crítica (Issue #333): Agentes de IA frequentemente concatenam trechos de seus system prompts de instrução antes da query de busca real. O modelo de embedding gera um único vetor onde o prompt (2000+ chars) sufoca a pergunta real (10–50 chars), causando **colapso da recall de 89.8% para 1.0%**.

O `query_sanitizer.py` aplica mitigação em 4 etapas:
1. **Passthrough** (≤200 chars): Transmite diretamente.
2. **Question Extraction**: Isola a frase terminada em `?` ou `？`.
3. **Tail Sentence Extraction**: Isola a última frase significativa.
4. **Tail Truncation**: Fallback pegando os últimos 250 caracteres.

---

## 6. Benchmarks reportados pelo projeto de origem (LongMemEval & LoCoMo)

Valores preservados da destilação anterior para rastreabilidade, sem reprodução local. Consulte o
[protocolo do fornecedor](https://github.com/MemPalace/mempalace/blob/develop/benchmarks/BENCHMARKS.md)
antes de comparar configurações ou usar esses números para decidir adoção.

| Benchmark | Modo / Configuração | Métrica | Resultado |
|---|---|---|---|
| **LongMemEval** | Raw (semântico puro, sem LLM, local) | R@5 | **96.6%** |
| **LongMemEval** | Hybrid v4 (BM25 + vetorial + temporal) | R@5 | **98.4%** |
| **LongMemEval** | Hybrid v4 + LLM rerank | R@5 | **≥99.0%** |
| **LoCoMo** | Hybrid v5 (top-10, sem rerank) | R@10 | **88.9%** |
| **ConvoMem** | Todas as categorias (250 itens) | Avg Recall | **92.9%** |
