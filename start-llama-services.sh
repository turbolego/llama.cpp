#!/bin/bash

# Start all 4 llama-server instances for VS Code integration
# Usage: ./start-llama-services.sh

set -e

LLAMA_BIN="/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server"
LOG_DIR="/tmp/llama-services"

# Create log directory
mkdir -p "$LOG_DIR"

# Kill any existing processes
echo "Stopping existing llama-server instances..."
pkill -f llama-server || true
sleep 1

echo "Starting 4 llama-server instances..."
echo ""

# Port 8000 - Completions (Gemma-4-26B)
echo "🚀 Starting Port 8000: Gemma-4-26B (Completions)..."
"$LLAMA_BIN" -hf unsloth/gemma-4-26B-A4B-it-GGUF:gemma-4-26B-A4B-it-UD-IQ2_M \
  -t 4 -c 2048 -ngl 0 --port 8000 > "$LOG_DIR/8000.log" 2>&1 &

# Port 8011 - Chat (Qwen2.5-Coder) - OPTIMIZED FOR CPU
echo "🚀 Starting Port 8011: Qwen2.5-Coder (Chat)..."
"$LLAMA_BIN" -hf ggml-org/Qwen2.5-Coder-1.5B-Instruct-Q8_0-GGUF \
  -ub 512 -b 512 -dt 0.1 -np 1 --port 8011 > "$LOG_DIR/8011.log" 2>&1 &

# Port 8010 - Embeddings (Nomic)
echo "🚀 Starting Port 8010: Nomic (Embeddings)..."
"$LLAMA_BIN" -hf ggml-org/Nomic-Embed-Text-V2-GGUF \
  -ub 2048 -b 2048 --ctx-size 2048 --embeddings --port 8010 > "$LOG_DIR/8010.log" 2>&1 &

# Port 8009 - Tools (TinyLlama)
echo "🚀 Starting Port 8009: TinyLlama (Tools)..."
"$LLAMA_BIN" -hf TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF \
  -c 2048 -ub 512 -b 512 -np 1 --port 8009 > "$LOG_DIR/8009.log" 2>&1 &

sleep 3

echo ""
echo "✅ All 4 servers started in background"
echo "📋 Log files in: $LOG_DIR"
echo ""
echo "Checking health..."
for port in 8009 8010 8011; do 
  echo -n "Port $port: "
  timeout 3 curl -s http://127.0.0.1:$port/health 2>&1 | grep -q ok && echo "✅" || echo "⏳ Loading..."
done

# Port 8000 may take longer
echo -n "Port 8000: "
timeout 3 curl -s http://127.0.0.1:8000/health 2>&1 | grep -q ok && echo "✅" || echo "⏳ Loading (may take 1-2 minutes)..."

echo ""
echo "📝 To stop servers: pkill -f llama-server"
echo "📊 To view logs: tail -f $LOG_DIR/{8000,8009,8010,8011}.log"

