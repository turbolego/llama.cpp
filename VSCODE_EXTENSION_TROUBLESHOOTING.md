# VS Code llama.vscode Extension - Troubleshooting "No Response from AI"

## Root Cause

The extension shows "No response from AI" because:
1. **Extension is installed** ✅ (`ggml-org.llama-vscode`)
2. **Servers are running** ✅ (all 4 ports responding)
3. **Extension not configured to find servers** ❌ ← **THIS IS THE ISSUE**

---

## Solution: Configure Environment Selection

### Step 1: Open VS Code Command Palette
```
Cmd + Shift + P
```

### Step 2: Select Environment  
Type: `llama: select environment`

You should see a list of available environments. **If you see empty/no options**, proceed to Step 3.

### Step 3: Create Custom Environment (If Needed)

If no environment appears, the extension might need manual configuration. Create a `.vscode/settings.json` file in your workspace:

```json
{
  "llama.environments": [
    {
      "name": "Intel Mac CPU-Only (16GB RAM) - Full Stack",
      "completions": {
        "url": "http://127.0.0.1:8000",
        "model": "gpt2"
      },
      "chat": {
        "url": "http://127.0.0.1:8011",
        "model": "gpt2"
      },
      "embeddings": {
        "url": "http://127.0.0.1:8010",
        "model": "gpt2"
      },
      "tools": {
        "url": "http://127.0.0.1:8009",
        "model": "gpt2"
      }
    }
  ]
}
```

---

## Verification Steps

### 1. Check Extension Status
Look at the **bottom status bar** in VS Code:
- Should show something like: `llama $(zap)` or a llama icon
- Click it to see current environment/status

### 2. Verify Servers Are Connected
```bash
# Test each endpoint
curl http://127.0.0.1:8000/health
curl http://127.0.0.1:8011/health
curl http://127.0.0.1:8010/health
curl http://127.0.0.1:8009/health

# All should return: {"status":"ok"}
```

### 3. Test Extension Chat
1. **Open Chat Panel:** `Cmd + L` (or click chat icon in sidebar)
2. **Type:** "Hello"
3. **Wait 2-5 seconds** for response
4. **Should see:** Chat response from model

### 4. Check Extension Logs
```
Cmd + Shift + P → Developer: Show Logs Directory
```

Look for `ggml-org.llama-vscode` folder:
- Check recent logs for connection errors
- Search for "127.0.0.1:8000" to see if it's trying to connect

---

## Common Issues & Fixes

### Issue 1: "No Response from AI" in Chat

**Possible Causes:**
1. Environment not selected → **Run Step 1-3 above**
2. Servers not responding → **Check `curl http://127.0.0.1:8011/health`**
3. Wrong ports in configuration → **Verify all 4 ports are 8000, 8011, 8010, 8009**

**Fix:**
```bash
# 1. Restart servers
pkill -f llama-server
sleep 2
bash /Users/ciberloaner/Documents/GitHub/llama.cpp/start-llama-vscode-services.sh

# 2. Restart VS Code
# Close and reopen VS Code

# 3. Try command palette again
Cmd + Shift + P → llama: select environment
```

### Issue 2: Extension Shows "Loading..." Forever

**Possible Cause:** One or more models still loading (especially Port 8000)

**Check Status:**
```bash
# See which servers are ready
tail -5 /tmp/llama-services/*.log

# Watch port 8000 (Completions - slowest)
tail -f /tmp/llama-services/8000.log | grep -i "listening\|ready\|main:"
```

**Expected output for ready server:**
```
main: server is listening on http://127.0.0.1:8000
main: starting the main loop...
```

### Issue 3: Connection Refused on Port 8000

**Cause:** Completions server crashed or didn't start

**Debug:**
```bash
# Check if process is running
ps aux | grep "port 8000"

# Check log file
cat /tmp/llama-services/8000.log | tail -50

# Restart just port 8000
pkill -f "port 8000" || true
cd /Users/ciberloaner/Documents/GitHub/llama.cpp
./build/bin/llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF \
  -c 4096 -ub 512 -b 512 --cache-reuse 256 --port 8000 &
```

### Issue 4: VS Code Extension Crashes After Selecting Environment

**Cause:** Extension incompatibility or memory issue

**Fix:**
1. Disable and re-enable extension:
   ```
   Cmd + Shift + P → Extensions: Disable (search for llama)
   Cmd + Shift + P → Extensions: Enable
   ```
2. Clear cache and restart
3. Check system memory: `vm_stat`

---

## Quick Diagnostics Script

Copy and run this to check everything:

```bash
#!/bin/bash
echo "=== llama.vscode Diagnostics ==="
echo ""
echo "✓ Checking servers..."
for port in 8000 8011 8010 8009; do
  if curl -s http://127.0.0.1:$port/health > /dev/null 2>&1; then
    echo "  Port $port: ✅ OK"
  else
    echo "  Port $port: ❌ DOWN"
  fi
done
echo ""
echo "✓ Checking VS Code extension..."
if code --list-extensions | grep -q "ggml-org.llama-vscode"; then
  echo "  Extension installed: ✅ YES"
else
  echo "  Extension installed: ❌ NO"
fi
echo ""
echo "✓ Checking configuration..."
if grep -q "llama" ~/Library/Application\ Support/Code/User/settings.json; then
  echo "  VS Code settings: ✅ FOUND"
else
  echo "  VS Code settings: ⚠️  NOT FOUND (may use workspace settings)"
fi
echo ""
echo "=== End Diagnostics ==="
```

---

## Step-by-Step Fix (Complete Walkthrough)

### If Still Not Working:

1. **Kill all servers:**
   ```bash
   pkill -f llama-server
   ```

2. **Start fresh:**
   ```bash
   bash /Users/ciberloaner/Documents/GitHub/llama.cpp/start-llama-vscode-services.sh
   ```

3. **Wait 2 minutes** (Port 8000 is slow)

4. **Close VS Code completely** (not just window - quit app)

5. **Reopen VS Code**

6. **Command palette:** `Cmd + Shift + P` → `llama: select environment`

7. **Choose environment** (or create one if none shown)

8. **Open Chat:** `Cmd + L`

9. **Type test message:** "Hi"

10. **Wait 3-5 seconds** for response

If still failing → Check logs:
```bash
tail -100 /tmp/llama-services/8011.log
```

---

## Expected Performance

| Feature | Time | Notes |
| --- | --- | --- |
| **First message** | 3-5 sec | Model loading + inference |
| **Subsequent messages** | 1-2 sec | Faster |
| **Completions** | 2-3 sec | Code suggestions |
| **Embeddings** | ~500ms | Fast |

---

## Files Reference

| File | Purpose |
| --- | --- |
| [start-llama-vscode-services.sh](start-llama-vscode-services.sh) | Correct startup script |
| [LLAMA_VSCODE_STATUS.md](LLAMA_VSCODE_STATUS.md) | Status overview |
| Ports | 8000 (Completions), 8011 (Chat), 8010 (Embeddings), 8009 (Tools) |

---

## If Everything Else Fails

**Complete Reset:**
```bash
# 1. Kill all servers
pkill -f llama-server

# 2. Clear extension cache
rm -rf ~/Library/Application\ Support/Code/extensions/ggml-org.llama-vscode-* 2>/dev/null
rm -rf ~/Library/Application\ Support/Code/User/globalStorage/ggml-org.llama-vscode 2>/dev/null

# 3. Restart VS Code from Terminal
code /Users/ciberloaner/Documents/GitHub/llama.cpp

# 4. Start servers in another terminal
bash /Users/ciberloaner/Documents/GitHub/llama.cpp/start-llama-vscode-services.sh

# 5. Try extension again
```

---

**Contact:** Check the llama.cpp GitHub for extension-specific issues:
- [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp)
- Search existing issues with "vscode"
