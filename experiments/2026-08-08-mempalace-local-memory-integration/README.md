# Experimento: Integração de Memória Local MemPalace no Antigravity / Claude Code

**Hipótese:** Integrar o servidor MCP e os retention hooks do MemPalace (`C:\workspace\Extras\mempalace`) como camada de memória local persistente reduz em >90% a perda de contexto entre sessões de agentes mantendo o tempo de boot de sessão em <200ms.

## Escopo do Experimento
1. **Configuração MCP**: Conectar o MCP server stdio do MemPalace (`mempalace/mcp_server.py`) aos harnesses de agente.
2. **Setup de Hooks de Persistência**: Instalar e validar `mempal_save_hook_antigravity.sh` ou equivalente local em PowerShell/Shell para minerar transcrições no evento de encerramento ou `/compact`.
3. **Validação de Acionamento L0–L3**: Medir o consumo de tokens na inicialização com a carga de `Layer0` (Identidade) + `Layer1` (História Essencial).

## Como Executar
```bash
# 1. Instalar o mempalace em modo editável ou via uv
cd C:\workspace\Extras\mempalace
uv sync --extra dev

# 2. Iniciar palácio no repositório de teste
uv run mempalace init ~/mempalace_test

# 3. Testar mineracao de sessões
uv run mempalace mine ~/.claude/projects/ --mode convos

# 4. Validar busca semântica híbrida
uv run mempalace search "quais foram as decisões de arquitetura"
```

## Resultados Esperados & Métricas
- **Custo de Boot**: ~600–900 tokens (L0 + L1).
- **Tempo de Resposta**: <100ms para L0+L1 wake-up.
- **Recall de Recuperação**: R@5 > 95% em consultas de decisões passadas.
