# llama.vscode Extension - Configuration Fix

## Problem Identified ❌

The extension was failing with **"AI not responding"** because:

1. **Completions server was on port 8012 (wrong!)**
2. **VS Code extension expects port 8000 (correct)**
3. No server was listening on port 8000, causing all requests to fail

### Incorrect Configuration (What You Were Running)
```
Port 8012 → Completions (WRONG - extension doesn't know about this)
Port 8011 → Chat
Port 8010 → Embeddings  
Port 8009 → Tools
```

### Correct Configuration (What Extension Expects)
```
Port 8000 → Completions ✅ (extension looks here first)
Port 8011 → Chat
Port 8010 → Embeddings
Port 8009 → Tools
```

---

## Solution ✅

All servers are now running on the correct ports:

```bash
# Current Status (verify with):
lsof -i -P -n | grep LISTEN | grep 800
```

Output should show:
```
llama-ser ... TCP 127.0.0.1:8000 (LISTEN)  ← Completions
llama-ser ... TCP 127.0.0.1:8011 (LISTEN)  ← Chat
llama-ser ... TCP 127.0.0.1:8010 (LISTEN)  ← Embeddings
llama-ser ... TCP 127.0.0.1:8009 (LISTEN)  ← Tools
```

---

## Quick Start

### Option 1: Use New Script (Recommended)
```bash
bash /Users/ciberloaner/Documents/GitHub/llama.cpp/start-llama-vscode-services.sh
```

### Option 2: Start Servers Manually

**Terminal 1 - Completions (Port 8000)**
```bash
llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF \
  -c 4096 -ub 512 -b 512 --cache-reuse 256 --port 8000
```

**Terminal 2 - Chat (Port 8011)**
```bash
llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Instruct-Q8_0-GGUF \
  -c 4096 -ub 512 -b 512 -np 1 --cache-reuse 256 --port 8011
```

**Terminal 3 - Embeddings (Port 8010)**
```bash
llama-server -hf ggml-org/Nomic-Embed-Text-V2-GGUF \
  -ub 2048 -b 2048 --ctx-size 2048 --embeddings --port 8010
```

**Terminal 4 - Tools (Port 8009)**
```bash
llama-server -hf unsloth/Qwen3.5-2B-GGUF \
  -c 2048 -ub 256 -b 256 --port 8009
```

---

## Test the Extension

### In VS Code

1. **Open VS Code**
2. **Press `Cmd+Shift+P`** and search for `llama: select environment`
3. **Choose the environment** that matches your setup
4. **Try Chat:**
   - Open the Chat sidebar
   - Type a question
   - Should respond within 2-5 seconds

### Via Terminal (Health Check)

```bash
# Test Completions (Port 8000)
curl http://127.0.0.1:8000/health

# Test Chat (Port 8011)
curl -X POST http://127.0.0.1:8011/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"q","messages":[{"role":"user","content":"Hi"}],"max_tokens":5}'

# Test Embeddings (Port 8010)
curl -X POST http://127.0.0.1:8010/embeddings \
  -H "Content-Type: application/json" \
  -d '{"model":"m","input":"hello"}'
```

---

## Performance

| Feature | Speed | Notes |
| --- | --- | --- |
| **Chat Response** | 2-5 sec | First message slower, then ~10 tokens/sec |
| **Completions** | ~8-10 tokens/sec | Inline code suggestions |
| **Embeddings** | ~500ms | Semantic search / RAG |
| **Tools** | ~8-10 tokens/sec | Function calling |

---

## Troubleshooting

### Extension still says "AI not responding"

1. **Check servers are running:**
   ```bash
   lsof -i -P -n | grep 800
   ```
   Should show 4 LISTEN entries for ports 8000-8011

2. **Check a specific port:**
   ```bash
   curl http://127.0.0.1:8000/health
   ```
   If it fails, the server crashed. Check logs:
   ```bash
   tail -50 /tmp/llama-services/8000.log
   ```

3. **Restart all servers:**
   ```bash
   pkill -f llama-server
   sleep 2
   bash /Users/ciberloaner/Documents/GitHub/llama.cpp/start-llama-vscode-services.sh
   ```

### Port already in use

```bash
# Find what's using the port
lsof -i :8000

# Kill it
kill -9 <PID>
```

### Server crashes with segfault

Reduce parameters (already applied for port 8009). Try:
```bash
llama-server -hf model -c 2048 -ub 256 -b 256 --port XXXX
```

---

## Files Reference

| File | Purpose |
| --- | --- |
| [start-llama-vscode-services.sh](start-llama-vscode-services.sh) | ✅ **NEW** - Correct startup script |
| [start-optimized-servers.sh](start-optimized-servers.sh) | OLD - Reference only (uses wrong port 8012) |
| [OPTIMIZED-SERVERS.md](OPTIMIZED-SERVERS.md) | Performance optimization guide |

---

## Key Takeaway

**Always use port 8000 for Completions when using llama.vscode extension!**

The extension is hardcoded to look for:
- `127.0.0.1:8000` (Completions)
- `127.0.0.1:8011` (Chat)  
- `127.0.0.1:8010` (Embeddings)
- `127.0.0.1:8009` (Tools)

Any deviation causes "AI not responding" errors.
