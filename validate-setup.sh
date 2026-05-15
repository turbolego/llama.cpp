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
response=$(curl -s --max-time 10 -X POST http://127.0.0.1:8011/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"q","messages":[{"role":"user","content":"say OK"}],"max_tokens":3}' \
  | jq -r '.choices[0].message.content // "error"' 2>/dev/null)
if [ "$response" = "error" ]; then
  echo "❌ Chat endpoint failed"
  exit 1
fi
echo "  ✅ Chat working: Response received"

# Check 3: Embeddings
echo "✓ Testing embeddings..."
embed=$(curl -s --max-time 10 -X POST http://127.0.0.1:8010/v1/embeddings \
  -H "Content-Type: application/json" \
  -d '{"model":"e","input":"test"}' \
  | jq '.data[0].embedding | length' 2>/dev/null)
if [ "$embed" != "768" ]; then
  echo "❌ Embeddings failed (expected 768-dim, got $embed)"
  exit 1
fi
echo "  ✅ Embeddings working: ${embed}-dimensional"

# Check 4: Tools
echo "✓ Testing tools..."
tools=$(curl -s --max-time 10 -X POST http://127.0.0.1:8009/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"t","messages":[{"role":"user","content":"hi"}],"max_tokens":5}' \
  | jq -r '.choices[0].message.content // "error"' 2>/dev/null)
if [ "$tools" = "error" ]; then
  echo "❌ Tools endpoint failed"
  exit 1
fi
echo "  ✅ Tools working"

# Check 5: Verify settings
echo "✓ Checking VS Code settings..."
if grep -q '"Intel Mac CPU-Only (16GB RAM) - Full Stack"' ~/Library/Application\ Support/Code/User/settings.json; then
  echo "  ✅ Environment configured"
else
  echo "⚠️  Environment config not found (may need manual setup)"
fi

echo ""
echo "🎉 All systems operational!"
echo ""
echo "Next steps:"
echo "1. Open VS Code"
echo "2. Command Palette (Cmd+Shift+P) → 'llama: select environment'"
echo "3. Choose 'Intel Mac CPU-Only (16GB RAM) - Full Stack'"
echo "4. Try chat or code completions"
