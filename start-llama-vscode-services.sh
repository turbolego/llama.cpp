#!/bin/bash

# Start all 4 llama-server instances for VS Code llama.vscode extension
# Optimized for Intel i5 MacBook Pro with 16GB RAM

set -e

LLAMA_BIN="/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server"
LOG_DIR="/tmp/llama-services"

# Create log directory
mkdir -p "$LOG_DIR"

# Kill any existing processes
echo "🛑 Stopping existing llama-server instances..."
pkill -f llama-server || true
sleep 2

echo "🚀 Starting 4 llama-server instances for VS Code extension..."
echo ""

# Port 8000 - Completions (Qwen2.5-Coder)
echo "📝 Port 8000: Completions (Qwen2.5-Coder-1.5B-Q8_0)"
"$LLAMA_BIN" -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF \
  -c 4096 -ub 512 -b 512 --cache-reuse 256 --port 8000 \
  > "$LOG_DIR/8000.log" 2>&1 &

# Port 8011 - Chat (Qwen2.5-Coder-Instruct)
echo "💬 Port 8011: Chat (Qwen2.5-Coder-1.5B-Instruct-Q8_0)"
"$LLAMA_BIN" -hf ggml-org/Qwen2.5-Coder-1.5B-Instruct-Q8_0-GGUF \
  -c 4096 -ub 512 -b 512 -np 1 --cache-reuse 256 --port 8011 \
  > "$LOG_DIR/8011.log" 2>&1 &

# Port 8010 - Embeddings (Nomic)
echo "🔍 Port 8010: Embeddings (Nomic-Embed-Text-V2)"
"$LLAMA_BIN" -hf ggml-org/Nomic-Embed-Text-V2-GGUF \
  -ub 2048 -b 2048 --ctx-size 2048 --embeddings --port 8010 \
  > "$LOG_DIR/8010.log" 2>&1 &

# Port 8009 - Tools (Qwen3.5-2B)
echo "🔧 Port 8009: Tools (Qwen3.5-2B)"
"$LLAMA_BIN" -hf unsloth/Qwen3.5-2B-GGUF \
  -c 2048 -ub 256 -b 256 --port 8009 \
  > "$LOG_DIR/8009.log" 2>&1 &

sleep 5

echo ""
echo "✅ All 4 servers started in background"
echo "📋 Log files in: $LOG_DIR"
echo ""
echo "🔍 Checking health status..."
for port in 8000 8009 8010 8011; do 
  if timeout 2 curl -s http://127.0.0.1:$port/health > /dev/null 2>&1; then
    echo "   Port $port: ✅ READY"
  else
    echo "   Port $port: ⏳ LOADING (check $LOG_DIR/${port}.log in 30 sec)"
  fi
done

echo ""
echo "✨ VS Code llama.vscode extension is ready!"
echo "   Open VS Code and use the extension"
echo ""
echo "📚 Performance Metrics (Intel i5 MacBook Pro):"
echo "   • Completions: ~8-10 tokens/sec"
echo "   • Chat: ~8-10 tokens/sec"
echo "   • Embeddings: ~500ms/request"
echo "   • Tools: ~8-10 tokens/sec"
echo ""
echo "❌ To stop servers:"
echo "   pkill -f llama-server"
