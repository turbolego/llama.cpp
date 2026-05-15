llama-server -hf unsloth/Qwen3.5-2B-GGUF:Q8_0 --jinja  -c 0 -ub 1024 -b 1024 --cache-reuse 256 --port 8009 --host 127.0.0.1

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
MacBookPro:llama.cpp ciberloaner$ llama-server -hf unsloth/Qwen3.5-2B-GGUF:Q8_0 --jinja  -c 0 -ub 1024 -b 1024 --cache-reuse 256 --port 8009 --host 127.0.0.1
load_backend: loaded BLAS backend from /usr/local/Cellar/ggml/0.11.1/libexec/libggml-blas.so
load_backend: loaded CPU backend from /usr/local/Cellar/ggml/0.11.1/libexec/libggml-cpu.so
common_download_file_single_online: HEAD failed, status: 404
no remote preset found, skipping
main: n_parallel is set to auto, using n_parallel = 4 and kv_unified = true
build_info: b9140-1e4579fbb
system_info: n_threads = 4 (n_threads_batch = 4) / 8 | CPU : SSE3 = 1 | SSSE3 = 1 | ACCELERATE = 1 | OPENMP = 1 | REPACK = 1 | 
Running without SSL
init: using 8 threads for HTTP server
start: binding port with default address family
main: loading model
srv    load_model: loading model '/Users/ciberloaner/.cache/huggingface/hub/models--unsloth--Qwen3.5-2B-GGUF/snapshots/f6d5376be1edb4d416d56da11e5397a961aca8ae/Qwen3.5-2B-Q8_0.gguf'
common_init_result: fitting params to device memory, for bugs during this step try to reproduce them with -fit off, or provide --verbose logs if the bug only occurs with -fit on
common_params_fit_impl: getting device memory data for initial parameters:
common_memory_breakdown_print: | memory breakdown [MiB] | total   free    self   model   context   compute    unaccounted |
common_memory_breakdown_print: |   - Host               |                 8225 =  1908 +    3149 +    3168                |
common_params_fit_impl: projected to use 8225 MiB of host memory vs. 16384 MiB of total host memory
common_params_fit_impl: will leave 8158 >= 1024 MiB of system memory, no changes needed
common_fit_params: successfully fit params to free device memory
common_fit_params: fitting params to free memory took 1.81 seconds
llama_model_loader: loaded meta data with 46 key-value pairs and 320 tensors from /Users/ciberloaner/.cache/huggingface/hub/models--unsloth--Qwen3.5-2B-GGUF/snapshots/f6d5376be1edb4d416d56da11e5397a961aca8ae/Qwen3.5-2B-Q8_0.gguf (version GGUF V3 (latest))
llama_model_loader: Dumping metadata keys/values. Note: KV overrides do not apply in this output.
llama_model_loader: - kv   0:                       general.architecture str              = qwen35
llama_model_loader: - kv   1:                               general.type str              = model
llama_model_loader: - kv   2:                               general.name str              = Qwen3.5-2B
llama_model_loader: - kv   3:                           general.basename str              = Qwen3.5-2B
llama_model_loader: - kv   4:                       general.quantized_by str              = Unsloth
llama_model_loader: - kv   5:                         general.size_label str              = 2B
llama_model_loader: - kv   6:                            general.license str              = apache-2.0
llama_model_loader: - kv   7:                       general.license.link str              = https://huggingface.co/Qwen/Qwen3.5-2...
llama_model_loader: - kv   8:                           general.repo_url str              = https://huggingface.co/unsloth
llama_model_loader: - kv   9:                   general.base_model.count u32              = 1
llama_model_loader: - kv  10:                  general.base_model.0.name str              = Qwen3.5 2B
llama_model_loader: - kv  11:          general.base_model.0.organization str              = Qwen
llama_model_loader: - kv  12:              general.base_model.0.repo_url str              = https://huggingface.co/Qwen/Qwen3.5-2B
llama_model_loader: - kv  13:                               general.tags arr[str,2]       = ["unsloth", "image-text-to-text"]
llama_model_loader: - kv  14:                         qwen35.block_count u32              = 24
llama_model_loader: - kv  15:                      qwen35.context_length u32              = 262144
llama_model_loader: - kv  16:                    qwen35.embedding_length u32              = 2048
llama_model_loader: - kv  17:                 qwen35.feed_forward_length u32              = 6144
llama_model_loader: - kv  18:                qwen35.attention.head_count u32              = 8
llama_model_loader: - kv  19:             qwen35.attention.head_count_kv u32              = 2
llama_model_loader: - kv  20:             qwen35.rope.dimension_sections arr[i32,4]       = [11, 11, 10, 0]
llama_model_loader: - kv  21:                      qwen35.rope.freq_base f32              = 10000000.000000
llama_model_loader: - kv  22:    qwen35.attention.layer_norm_rms_epsilon f32              = 0.000001
llama_model_loader: - kv  23:                qwen35.attention.key_length u32              = 256
llama_model_loader: - kv  24:              qwen35.attention.value_length u32              = 256
llama_model_loader: - kv  25:                     qwen35.ssm.conv_kernel u32              = 4
llama_model_loader: - kv  26:                      qwen35.ssm.state_size u32              = 128
llama_model_loader: - kv  27:                     qwen35.ssm.group_count u32              = 16
llama_model_loader: - kv  28:                  qwen35.ssm.time_step_rank u32              = 16
llama_model_loader: - kv  29:                      qwen35.ssm.inner_size u32              = 2048
llama_model_loader: - kv  30:             qwen35.full_attention_interval u32              = 4
llama_model_loader: - kv  31:                qwen35.rope.dimension_count u32              = 64
llama_model_loader: - kv  32:                       tokenizer.ggml.model str              = gpt2
llama_model_loader: - kv  33:                         tokenizer.ggml.pre str              = qwen35
llama_model_loader: - kv  34:                      tokenizer.ggml.tokens arr[str,248320]  = ["!", "\"", "#", "$", "%", "&", "'", ...
llama_model_loader: - kv  35:                  tokenizer.ggml.token_type arr[i32,248320]  = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
llama_model_loader: - kv  36:                      tokenizer.ggml.merges arr[str,247587]  = ["Ġ Ġ", "ĠĠ ĠĠ", "i n", "Ġ t",...
llama_model_loader: - kv  37:                tokenizer.ggml.eos_token_id u32              = 248046
llama_model_loader: - kv  38:            tokenizer.ggml.padding_token_id u32              = 248055
llama_model_loader: - kv  39:                    tokenizer.chat_template str              = {%- set image_count = namespace(value...
llama_model_loader: - kv  40:               general.quantization_version u32              = 2
llama_model_loader: - kv  41:                          general.file_type u32              = 7
llama_model_loader: - kv  42:                      quantize.imatrix.file str              = Qwen3.5-2B-GGUF/imatrix_unsloth.gguf
llama_model_loader: - kv  43:                   quantize.imatrix.dataset str              = unsloth_calibration_Qwen3.5-2B.txt
llama_model_loader: - kv  44:             quantize.imatrix.entries_count u32              = 186
llama_model_loader: - kv  45:              quantize.imatrix.chunks_count u32              = 80
llama_model_loader: - type  f32:  133 tensors
llama_model_loader: - type q8_0:  187 tensors
print_info: file format = GGUF V3 (latest)
print_info: file type   = Q8_0
print_info: file size   = 1.86 GiB (8.51 BPW) 
load: 0 unused tokens
load: printing all EOG tokens:
load:   - 248044 ('<|endoftext|>')
load:   - 248046 ('<|im_end|>')
load:   - 248063 ('<|fim_pad|>')
load:   - 248064 ('<|repo_name|>')
load:   - 248065 ('<|file_sep|>')
load: special tokens cache size = 33
load: token to piece cache size = 1.7581 MB
print_info: arch                  = qwen35
print_info: vocab_only            = 0
print_info: no_alloc              = 0
print_info: n_ctx_train           = 262144
print_info: n_embd                = 2048
print_info: n_embd_inp            = 2048
print_info: n_layer               = 24
print_info: n_head                = 8
print_info: n_head_kv             = 2
print_info: n_rot                 = 64
print_info: n_swa                 = 0
print_info: is_swa_any            = 0
print_info: n_embd_head_k         = 256
print_info: n_embd_head_v         = 256
print_info: n_gqa                 = 4
print_info: n_embd_k_gqa          = 512
print_info: n_embd_v_gqa          = 512
print_info: f_norm_eps            = 0.0e+00
print_info: f_norm_rms_eps        = 1.0e-06
print_info: f_clamp_kqv           = 0.0e+00
print_info: f_max_alibi_bias      = 0.0e+00
print_info: f_logit_scale         = 0.0e+00
print_info: f_attn_scale          = 0.0e+00
print_info: f_attn_value_scale    = 0.0000
print_info: n_ff                  = 6144
print_info: n_expert              = 0
print_info: n_expert_used         = 0
print_info: n_expert_groups       = 0
print_info: n_group_used          = 0
print_info: causal attn           = 1
print_info: pooling type          = -1
print_info: rope type             = 40
print_info: rope scaling          = linear
print_info: freq_base_train       = 10000000.0
print_info: freq_scale_train      = 1
print_info: n_ctx_orig_yarn       = 262144
print_info: rope_yarn_log_mul     = 0.0000
print_info: rope_finetuned        = unknown
print_info: mrope sections        = [11, 11, 10, 0]
print_info: ssm_d_conv            = 4
print_info: ssm_d_inner           = 2048
print_info: ssm_d_state           = 128
print_info: ssm_dt_rank           = 16
print_info: ssm_n_group           = 16
print_info: ssm_dt_b_c_rms        = 0
print_info: model type            = 2B
print_info: model params          = 1.88 B
print_info: general.name          = Qwen3.5-2B
print_info: vocab type            = BPE
print_info: n_vocab               = 248320
print_info: n_merges              = 247587
print_info: BOS token             = 11 ','
print_info: EOS token             = 248046 '<|im_end|>'
print_info: EOT token             = 248046 '<|im_end|>'
print_info: PAD token             = 248055 '<|vision_pad|>'
print_info: LF token              = 198 'Ċ'
print_info: FIM PRE token         = 248060 '<|fim_prefix|>'
print_info: FIM SUF token         = 248062 '<|fim_suffix|>'
print_info: FIM MID token         = 248061 '<|fim_middle|>'
print_info: FIM PAD token         = 248063 '<|fim_pad|>'
print_info: FIM REP token         = 248064 '<|repo_name|>'
print_info: FIM SEP token         = 248065 '<|file_sep|>'
print_info: EOG token             = 248044 '<|endoftext|>'
print_info: EOG token             = 248046 '<|im_end|>'
print_info: EOG token             = 248063 '<|fim_pad|>'
print_info: EOG token             = 248064 '<|repo_name|>'
print_info: EOG token             = 248065 '<|file_sep|>'
print_info: max token length      = 256
load_tensors: loading model tensors, this can take a while... (mmap = true, direct_io = false)
load_tensors:   CPU_Mapped model buffer size =  1908.35 MiB
..........................................................................
common_init_result: added <|endoftext|> logit bias = -inf
common_init_result: added <|im_end|> logit bias = -inf
common_init_result: added <|fim_pad|> logit bias = -inf
common_init_result: added <|repo_name|> logit bias = -inf
common_init_result: added <|file_sep|> logit bias = -inf
llama_context: constructing llama_context
llama_context: n_seq_max     = 4
llama_context: n_ctx         = 262144
llama_context: n_ctx_seq     = 262144
llama_context: n_batch       = 1024
llama_context: n_ubatch      = 1024
llama_context: causal_attn   = 1
llama_context: flash_attn    = auto
llama_context: kv_unified    = true
llama_context: freq_base     = 10000000.0
llama_context: freq_scale    = 1
llama_context:        CPU  output buffer size =     3.79 MiB
llama_kv_cache:        CPU KV buffer size =  3072.00 MiB
llama_kv_cache: size = 3072.00 MiB (262144 cells,   6 layers,  4/1 seqs), K (f16): 1536.00 MiB, V (f16): 1536.00 MiB
llama_kv_cache: attn_rot_k = 0, n_embd_head_k_all = 256
llama_kv_cache: attn_rot_v = 0, n_embd_head_k_all = 256
llama_memory_recurrent:        CPU RS buffer size =    77.06 MiB
llama_memory_recurrent: size =   77.06 MiB (     4 cells,  24 layers,  4 seqs), R (f32):    5.06 MiB, S (f32):   72.00 MiB
sched_reserve: reserving ...
sched_reserve: Flash Attention was auto, set to enabled
sched_reserve: resolving fused Gated Delta Net support:
sched_reserve: fused Gated Delta Net (autoregressive) enabled
sched_reserve: fused Gated Delta Net (chunked) enabled
sched_reserve:        CPU compute buffer size =  1584.04 MiB
sched_reserve: graph nodes  = 1377
sched_reserve: graph splits = 242 (with bs=1024), 1 (with bs=1)
sched_reserve: reserve took 75.22 ms, sched copies = 1
common_init_from_params: warming up the model with an empty run - please wait ... (--no-warmup to disable)
clip_model_loader: model name:   Qwen3.5-2B
clip_model_loader: description:  
clip_model_loader: GGUF version: 3
clip_model_loader: alignment:    32
clip_model_loader: n_tensors:    298
clip_model_loader: n_kv:         32

clip_model_loader: has vision encoder
clip_ctx: CLIP using CPU backend
load_hparams: Qwen-VL models require at minimum 1024 image tokens to function correctly on grounding tasks
load_hparams: if you encounter problems with accuracy, try adding --image-min-tokens 1024
load_hparams: more info: https://github.com/ggml-org/llama.cpp/issues/16842

load_hparams: projector:          qwen3vl_merger
load_hparams: n_embd:             1024
load_hparams: n_head:             16
load_hparams: n_ff:               4096
load_hparams: n_layer:            24
load_hparams: ffn_op:             gelu
load_hparams: projection_dim:     2048

--- vision hparams ---
load_hparams: image_size:         768
load_hparams: patch_size:         16
load_hparams: has_llava_proj:     0
load_hparams: minicpmv_version:   0
load_hparams: n_merge:            2
load_hparams: n_wa_pattern: 0
load_hparams: image_min_pixels:   8192
load_hparams: image_max_pixels:   4194304

load_hparams: model size:         640.25 MiB
load_hparams: metadata size:      0.10 MiB
warmup: warmup with image size = 1472 x 1472
alloc_compute_meta:        CPU compute buffer size =   223.30 MiB
alloc_compute_meta: graph splits = 1, nodes = 736
warmup: flash attention is enabled
srv    load_model: loaded multimodal model, '/Users/ciberloaner/.cache/huggingface/hub/models--unsloth--Qwen3.5-2B-GGUF/snapshots/f6d5376be1edb4d416d56da11e5397a961aca8ae/mmproj-BF16.gguf'
srv    load_model: cache_reuse is not supported by multimodal, it will be disabled
srv    load_model: initializing slots, n_slots = 4
common_context_can_seq_rm: the context does not support partial sequence removal
srv    load_model: speculative decoding will use checkpoints
no implementations specified for speculative decoding
slot   load_model: id  0 | task -1 | new slot, n_ctx = 262144
slot   load_model: id  1 | task -1 | new slot, n_ctx = 262144
slot   load_model: id  2 | task -1 | new slot, n_ctx = 262144
slot   load_model: id  3 | task -1 | new slot, n_ctx = 262144
srv    load_model: prompt cache is enabled, size limit: 8192 MiB
srv    load_model: use `--cache-ram 0` to disable the prompt cache
srv    load_model: for more info see https://github.com/ggml-org/llama.cpp/pull/16391
srv          init: init: idle slots will be saved to prompt cache and cleared upon starting a new task
init: chat template, example_format: '<|im_start|>system
You are a helpful assistant<|im_end|>
<|im_start|>user
Hello<|im_end|>
<|im_start|>assistant
Hi there<|im_end|>
<|im_start|>user
How are you?<|im_end|>
<|im_start|>assistant
<think>
'
srv          init: init: chat template, thinking = 1
main: model loaded
main: server is listening on http://127.0.0.1:8009
main: starting the main loop...
srv  update_slots: all slots are idle
srv  params_from_: Chat format: peg-native
slot get_availabl: id  3 | task -1 | selected slot by LRU, t_last = -1
srv  get_availabl: updating prompt cache
srv          load:  - looking for better prompt, base f_keep = -1.000, sim = 0.000
srv        update:  - cache state: 0 prompts, 0.000 MiB (limits: 8192.000 MiB, 262144 tokens, 8589934592 est)
srv  get_availabl: prompt cache update took 0.01 ms
reasoning-budget: activated, budget=2147483647 tokens
slot launch_slot_: id  3 | task -1 | sampler chain: logits -> ?penalties -> ?dry -> ?top-n-sigma -> top-k -> ?typical -> top-p -> min-p -> ?xtc -> temp-ext -> dist 
slot launch_slot_: id  3 | task 0 | processing task, is_child = 0
slot update_slots: id  3 | task 0 | new prompt, n_ctx_slot = 262144, n_keep = 0, task.n_tokens = 4927
slot update_slots: id  3 | task 0 | n_tokens = 0, memory_seq_rm [0, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens = 1024, batch.n_tokens = 1024, progress = 0.207834
slot update_slots: id  3 | task 0 | n_tokens = 1024, memory_seq_rm [1024, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens = 2048, batch.n_tokens = 1024, progress = 0.415669
slot update_slots: id  3 | task 0 | n_tokens = 2048, memory_seq_rm [2048, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens = 3072, batch.n_tokens = 1024, progress = 0.623503
slot update_slots: id  3 | task 0 | n_tokens = 3072, memory_seq_rm [3072, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens = 3903, batch.n_tokens = 831, progress = 0.792166
slot update_slots: id  3 | task 0 | n_tokens = 3903, memory_seq_rm [3903, end)
slot update_slots: id  3 | task 0 | prompt processing progress, n_tokens = 4923, batch.n_tokens = 1020, progress = 0.999188
slot create_check: id  3 | task 0 | created context checkpoint 1 of 32 (pos_min = 3902, pos_max = 3902, n_tokens = 3903, size = 19.266 MiB)
slot update_slots: id  3 | task 0 | n_tokens = 4923, memory_seq_rm [4923, end)
slot init_sampler: id  3 | task 0 | init sampler, took 1.93 ms, tokens: text = 4927, total = 4927
slot update_slots: id  3 | task 0 | prompt processing done, n_tokens = 4927, batch.n_tokens = 4
slot create_check: id  3 | task 0 | created context checkpoint 2 of 32 (pos_min = 4922, pos_max = 4922, n_tokens = 4923, size = 19.266 MiB)
srv  log_server_r: done request: POST /v1/chat/completions 127.0.0.1 200
reasoning-budget: deactivated (natural end)
slot print_timing: id  3 | task 0 | 
prompt eval time =   97167.76 ms /  4927 tokens (   19.72 ms per token,    50.71 tokens per second)
       eval time =   17410.13 ms /    79 tokens (  220.38 ms per token,     4.54 tokens per second)
      total time =  114577.89 ms /  5006 tokens
slot      release: id  3 | task 0 | stop processing: n_tokens = 5005, truncated = 0
srv  update_slots: all slots are idle
