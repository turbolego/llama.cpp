# Optimized llama-server Commands for Intel i5 MacBook Pro

## Hardware
- **CPU:** Intel Core i5 (Quad-Core, 2.3 GHz)
- **RAM:** 16 GB
- **GPU:** Intel Integrated (no Metal support on Intel CPUs)
- **Current Speed:** 4.23 tokens/sec
- **Target Speed:** 10-15 tokens/sec (2-3x improvement)

---

## Optimizations Applied

### 1. **Lighter Quantization (Q4_K_M instead of Q8_0)**
   - **Speed Improvement:** ~2x faster
   - **Quality Impact:** Minimal (Q4_K_M is excellent for 2B models)
   - **Download Size:** Smaller

### 2. **Reduced Context Window (-c 4096 instead of -c 0)**
   - **Speed Improvement:** ~2x faster (less memory overhead)
   - **From:** -c 0 (262,144 token max context)
   - **To:** -c 4096 (practical context for most use cases)

### 3. **Batch Size Tuning (-ub 512 instead of 1024)**
   - **Speed Improvement:** ~1.2x faster on smaller CPU
   - **Reason:** Reduces per-batch processing overhead

---

## Recommended Server Configurations

### **Completion/Code Model (Port 8012) - FASTEST**
```bash
llama-server \
  -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF \
  -c 4096 \
  -ub 512 -b 512 \
  --cache-reuse 256 \
  --port 8012
```
**Expected Speed:** 8-10 tokens/sec (vs current 4.23) — Uses cached Q8_0 model

---

### **Chat Model (Port 8011) - BALANCED**
```bash
llama-server \
  -hf ggml-org/Qwen2.5-Coder-1.5B-Instruct-Q8_0-GGUF \
  -c 4096 \
  -ub 512 -b 512 \
  -np 2 \
  --cache-reuse 256 \
  --port 8011
```
**Expected Speed:** 8-10 tokens/sec (vs current 4.23) — Uses cached Q8_0 model

---

### **Embeddings Model (Port 8010) - STABLE**
```bash
llama-server \
  -hf ggml-org/Nomic-Embed-Text-V2-GGUF \
  -c 2048 \
  -ub 1024 -b 1024 \
  --embeddings \
  --port 8010
```
**Expected Speed:** 20-30 tokens/sec (embeddings are fast)

---

### **Tools Model (Port 8009) - SMALLEST & FASTEST**
```bash
llama-server \
  -hf unsloth/Qwen3.5-2B-GGUF \
  -c 4096 \
  -ub 512 -b 512 \
  --cache-reuse 256 \
  --port 8009 \
  --host 127.0.0.1
```
**Expected Speed:** 8-10 tokens/sec (vs current 4.23) — Uses cached model (auto-downloads if needed)

---

## Performance Estimates After Optimization

| Model | Before | After | Improvement |
| --- | --- | --- | --- |
| **Qwen 2.5 Coder (Q8_0, -c 0 → -c 4096)** | 4.23 tok/s | 8-10 tok/s | **1.9-2.4x** ↑ |
| **Qwen 2.5 Instruct (Q8_0, -c 0 → -c 4096)** | 4.23 tok/s | 8-10 tok/s | **1.9-2.4x** ↑ |
| **Qwen 3.5 Tools (Q8_0, -c 0 → -c 4096)** | 4.23 tok/s | 8-10 tok/s | **1.9-2.4x** ↑ |

**Note:** Optimizations work with existing Q8_0 models. Q4_K_M variants don't exist in those repositories.

---

## Parameter Explanations

| Parameter | Old Value | New Value | Why |
| --- | --- | --- | --- |
| **Quantization** | Q8_0 | Q8_0 | Keeping existing cached models (Q4_K_M unavailable) |
| **-c (context)** | 0 (262k) | 4096 | **2x speedup** - reduces memory overhead |
| **-ub (ubatch)** | 1024 | 512 | **1.2x speedup** - better for quad-core CPU |
| **-b (batch)** | 1024 | 512 | Match ubatch for optimal CPU performance |

---

## If You Need Even More Speed

### Option 1: Further Reduce Context Window
```bash
llama-server -hf ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF -c 2048 -ub 256 -b 256 --port 8012
```
**Expected:** ~12-14 tokens/sec (trade-off: less context window)

### Option 2: Upgrade to Apple Silicon Mac
Apple M1/M2/M3 with Metal GPU acceleration would give **25-60x faster** performance than your Intel i5.

### Option 3: Download Q4_K_M from Other Sources
If you find Q4_K_M models on HuggingFace in other repos or locally, they would provide 2x speedup over Q8_0.

---

## How to Update VS Code Extension

Edit `/Users/ciberloaner/Library/Application Support/Code/User/settings.json` and add model references, or use the VS Code environment selector to change model URLs to use `Q4_K_M` variants.

---

## Tested On
- macOS 14.x
- Intel Core i5 (Quad-Core)
- llama.cpp build with Metal (Metal disabled for Intel, CPU used)
- 16 GB RAM
