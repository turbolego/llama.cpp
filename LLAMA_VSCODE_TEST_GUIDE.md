# llama.vscode Integration Test Guide

Complete verification guide for the multi-service llama.cpp + VS Code extension setup.

## 📋 Setup Status Checklist

### Prerequisites
- [ ] macOS (tested on 2018 MacBook Pro, Intel i5)
- [ ] llama.cpp built: `/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server`
- [ ] VS Code extension installed: ggml-org.llama-vscode v0.0.47+
- [ ] Models cached: `~/.cache/huggingface/`

### Configuration Files
- [ ] `start-llama-services.sh` executable: `chmod +x ~/Documents/GitHub/llama.cpp/start-llama-services.sh`
- [ ] VS Code settings.json configured with "Intel Mac CPU-Only (16GB RAM) - Full Stack" environment
- [ ] PATH updated: `which llama-server` returns `/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server`

---

## 🚀 Starting Services

### Step 1: Launch All Services
```bash
bash ~/Documents/GitHub/llama.cpp/start-llama-services.sh
```

Expected output:
```
✅ All 4 servers started in background
📋 Log files in: /tmp/llama-services

Checking health...
Port 8009: ⏳ Loading...
Port 8010: ⏳ Loading...
Port 8011: ⏳ Loading...
Port 8000: ⏳ Loading (may take 1-2 minutes)...
```

### Step 2: Wait for Model Loading

| Port | Service | Time to Load |
|------|---------|--------------|
| 8009 | TinyLlama (Tools) | ~5-10 sec |
| 8010 | Nomic (Embeddings) | ~5-10 sec |
| 8011 | Qwen2.5-Coder (Chat) | ~10-15 sec |
| 8000 | Gemma-4-26B (Completions) | ~2-3 min |

**Note**: Port 8000 may take longer due to 9.33GB model size.

---

## ✅ Service Verification

### Test 1: Health Check All Services
```bash
for port in 8000 8009 8010 8011; do
  echo -n "Port $port: "
  timeout 3 curl -s http://127.0.0.1:$port/health | jq -r '.status'
done
```

Expected output:
```
Port 8000: ok
Port 8009: ok
Port 8010: ok
Port 8011: ok
```

### Test 2: Chat Service (Port 8011)
```bash
curl -s -X POST http://127.0.0.1:8011/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model":"qwen",
    "messages":[{"role":"user","content":"What is 10+5?"}],
    "max_tokens":15,
    "temperature":0.7
  }' | jq '.choices[0].message.content'
```

Expected response:
```
"15"
```

**Performance metrics visible in response**:
- Typical latency: 1-3 seconds
- Token speed: 20-30 tokens/sec
- Memory: ~2GB used

### Test 3: Embeddings Service (Port 8010)
```bash
curl -s -X POST http://127.0.0.1:8010/v1/embeddings \
  -H "Content-Type: application/json" \
  -d '{"model":"embed","input":"Hello world"}' | jq '.data[0].embedding | length'
```

Expected output:
```
768
```

### Test 4: Tools Service (Port 8009)
```bash
curl -s -X POST http://127.0.0.1:8009/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"tiny","messages":[{"role":"user","content":"Hello"}],"max_tokens":10}' | jq '.choices[0].message.content'
```

Expected: Response is generated (content may vary).

---

## 🔧 VS Code Extension Configuration

### Step 1: Select Environment in Extension
1. Open VS Code Command Palette: `Cmd+Shift+P`
2. Run: `llama: select environment`
3. Choose: **"Intel Mac CPU-Only (16GB RAM) - Full Stack"**

You should see:
- ✅ Completion endpoint: http://127.0.0.1:8000
- ✅ Chat endpoint: http://127.0.0.1:8011
- ✅ Embeddings endpoint: http://127.0.0.1:8010
- ✅ Tools endpoint: http://127.0.0.1:8009

### Step 2: Check Extension Status
1. Look at VS Code status bar (bottom right)
2. Should show: "llama $(zap)" (connected)
3. Click to see: Env, models, server status

---

## 💬 Feature Testing

### Test 1: Code Completions (FIM)
1. Open any `.py` or `.js` file
2. Type a function stub:
   ```python
   def calculate_sum(a, b):
       """Add two numbers"""
       # Cursor here
   ```
3. Press `Ctrl+Shift+\` or wait for auto-complete
4. Should suggest: `return a + b`

**Expected response time**: 2-5 seconds (first request may be slower as model loads)

### Test 2: Chat
1. Click the chat icon in side panel (or `Cmd+L`)
2. Type: "What is Python?"
3. Verify response appears in chat panel

Expected: Full response from Qwen2.5-Coder model

### Test 3: Code Actions
1. Highlight code in editor
2. Right-click → "llama: explain" or similar code action
3. Should show explanation in chat

### Test 4: Embeddings (Vector Search)
1. Create workspace embeddings index
2. Run: `llama: build embeddings index` (if available)
3. Should process files without errors

---

## 📊 Resource Monitoring

### Monitor All Services
```bash
ps aux | grep llama-server | grep -v grep
```

Should show 4 processes running:
```
llama-server -hf unsloth/gemma-4-26B... --port 8000
llama-server -hf ggml-org/Qwen2.5-Coder... --port 8011
llama-server -hf ggml-org/Nomic-Embed... --port 8010
llama-server -hf TheBloke/TinyLlama... --port 8009
```

### Monitor Memory Usage
```bash
ps aux | grep llama-server | awk '{sum+=$6} END {print "Total: " sum " MB"}'
```

Expected: 8-12 GB total usage (reasonable for 4 concurrent models)

### View Logs
```bash
# Chat service (most important for VS Code)
tail -f /tmp/llama-services/8011.log

# All services
tail -f /tmp/llama-services/*.log

# Stop monitoring
Ctrl+C
```

---

## 🐛 Troubleshooting

### Issue: "No response from AI" in VS Code

**Check 1**: Are all services running?
```bash
ps aux | grep llama-server | grep -v grep | wc -l  # Should be: 4
```

**Check 2**: Test chat endpoint directly
```bash
timeout 5 curl -s -X POST http://127.0.0.1:8011/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"q","messages":[{"role":"user","content":"hi"}],"max_tokens":5}'
```

**Check 3**: Look at logs
```bash
tail -20 /tmp/llama-services/8011.log | grep error
```

### Issue: Chat timeouts

**Solution 1**: Restart just port 8011
```bash
pkill -f "port 8011"
sleep 2
bash ~/Documents/GitHub/llama.cpp/start-llama-services.sh
```

**Solution 2**: Check memory availability
```bash
vm_stat | grep "Pages free" # Should be > 1,000,000 pages
```

If memory is low, stop port 8000 (largest model):
```bash
pkill -f "port 8000"
```

### Issue: Command not found: llama-server

**Solution**: Verify PATH
```bash
which llama-server  # Should be: /Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server
grep "llama.cpp" ~/.zshrc ~/.bashrc  # Should show PATH entry
```

If not found, add to `~/.zshrc`:
```bash
export PATH="/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin:$PATH"
```

Then reload: `source ~/.zshrc`

### Issue: Port already in use

**Find and kill process**:
```bash
lsof -i :8011  # Find what's using port 8011
kill -9 <PID>  # Force kill
pkill -f llama-server  # Kill all llama servers
sleep 1
bash ~/Documents/GitHub/llama.cpp/start-llama-services.sh  # Restart
```

---

## 📈 Performance Optimization

### For CPU-Only on Limited RAM

**Current Configuration** (tested on 2018 i5 MacBook Pro, 16GB):
- Batch size: 512 (good balance)
- Parallel slots: 1 per service
- Thread count: 4 (matches CPU cores)
- Context: 2048 tokens

**If experiencing slowness**:

1. **Reduce context size**:
   ```bash
   # Edit start-llama-services.sh, change -c 2048 to -c 1024
   ```

2. **Run fewer models simultaneously**:
   ```bash
   # Comment out port 8000 in start-llama-services.sh (largest model)
   # and restart
   ```

3. **Increase batch size** (if you have 24GB+ RAM):
   ```bash
   # Change -ub 512 to -ub 1024 in start-llama-services.sh
   ```

### Expected Performance Metrics

| Metric | Value |
|--------|-------|
| Qwen2.5-Coder inference | 20-30 tokens/sec |
| TinyLlama inference | 30-50 tokens/sec |
| Chat response time | 1-3 seconds |
| Completion response time | 2-5 seconds |
| First request latency | 5-10 sec (model loading) |
| Memory per model | 500MB - 2GB |

---

## ✨ Final Validation

### Complete End-to-End Test
```bash
#!/bin/bash
set -e

echo "🔍 Validating llama.vscode setup..."
echo ""

# Check 1: Services running
echo "✓ Checking services..."
running=$(ps aux | grep llama-server | grep -v grep | wc -l)
if [ "$running" -ne 4 ]; then
  echo "❌ Expected 4 services, found $running"
  echo "   Run: bash ~/Documents/GitHub/llama.cpp/start-llama-services.sh"
  exit 1
fi
echo "  ✅ All 4 services running"

# Check 2: Chat endpoint
echo "✓ Testing chat endpoint..."
response=$(curl -s --max-time 5 -X POST http://127.0.0.1:8011/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"q","messages":[{"role":"user","content":"say ok"}],"max_tokens":3}' \
  | jq -r '.choices[0].message.content // "error"')
if [ "$response" = "error" ]; then
  echo "❌ Chat endpoint failed"
  exit 1
fi
echo "  ✅ Chat working: $response"

# Check 3: Embeddings
echo "✓ Testing embeddings..."
embed=$(curl -s --max-time 5 -X POST http://127.0.0.1:8010/v1/embeddings \
  -H "Content-Type: application/json" \
  -d '{"model":"e","input":"test"}' \
  | jq '.data[0].embedding | length')
if [ "$embed" != "768" ]; then
  echo "❌ Embeddings failed (expected 768-dim, got $embed)"
  exit 1
fi
echo "  ✅ Embeddings working: ${embed}-dimensional"

# Check 4: Tools
echo "✓ Testing tools..."
tools=$(curl -s --max-time 5 -X POST http://127.0.0.1:8009/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"t","messages":[{"role":"user","content":"hi"}],"max_tokens":5}' \
  | jq -r '.choices[0].message.content // "error"')
if [ "$tools" = "error" ]; then
  echo "❌ Tools endpoint failed"
  exit 1
fi
echo "  ✅ Tools working"

echo ""
echo "🎉 All systems operational!"
echo ""
echo "Next steps:"
echo "1. Open VS Code"
echo "2. Command Palette (Cmd+Shift+P) → 'llama: select environment'"
echo "3. Choose 'Intel Mac CPU-Only (16GB RAM) - Full Stack'"
echo "4. Try chat or code completions"
```

Save as `~/Documents/GitHub/llama.cpp/validate-setup.sh` and run:
```bash
chmod +x ~/Documents/GitHub/llama.cpp/validate-setup.sh
bash ~/Documents/GitHub/llama.cpp/validate-setup.sh
```

---

## 📚 Additional Resources

- **Logs**: `/tmp/llama-services/{8000,8009,8010,8011}.log`
- **Startup script**: `~/Documents/GitHub/llama.cpp/start-llama-services.sh`
- **Extension settings**: `~/Library/Application Support/Code/User/settings.json`
- **Stop all services**: `pkill -f llama-server`
- **View all processes**: `ps aux | grep llama-server`

---

## 🚀 Known Limitations (16GB CPU-Only)

- **Completions (8000)**: Gemma-4-26B responds slowly (~3-5 tok/sec), load time ~2-3 min
- **Chat (8011)**: Qwen2.5-Coder responds quickly (~20-30 tok/sec), most practical option
- **Batch operations**: Cannot run all 4 services + multiple simultaneous requests
- **First request**: Any service takes 5-10 sec first time (model loading)
- **Context limit**: 2048 tokens recommended (vs 8192 max) to save RAM

---

**Last Updated**: January 2025
**Status**: ✅ Tested & Working
