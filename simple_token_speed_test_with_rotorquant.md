/Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server -hf unsloth/Qwen3.5-2B-GGUF -c 8192 -ub 128 -b 128 -ngl 0 --no-warmup --port 8009

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
MacBookPro:llama.cpp ciberloaner$ /Users/ciberloaner/Documents/GitHub/llama.cpp/build/bin/llama-server -hf unsloth/Qwen3.5-2B-GGUF -c 8192 -ub 128 -b 128 -ngl 0 --no-warmup --port 8009
0.03.976.142 I log_info: verbosity = 3 (adjust with the `-lv N` CLI arg)
0.03.976.148 I device_info:
0.03.976.160 I   - MTL0    : Intel(R) Iris(TM) Plus Graphics 655 (1536 MiB, 1527 MiB free)
0.03.976.161 I   - BLAS    : Accelerate (0 MiB, 0 MiB free)
0.03.976.190 I   - CPU     : Intel(R) Core(TM) i5-8259U CPU @ 2.30GHz (16384 MiB, 16384 MiB free)
0.03.976.249 I system_info: n_threads = 4 (n_threads_batch = 4) / 8 | MTL : EMBED_LIBRARY = 1 | CPU : SSE3 = 1 | SSSE3 = 1 | AVX = 1 | AVX2 = 1 | F16C = 1 | FMA = 1 | BMI2 = 1 | LLAMAFILE = 1 | ACCELERATE = 1 | REPACK = 1 | 
0.03.976.260 I srv          main: n_parallel is set to auto, using n_parallel = 4 and kv_unified = true
0.03.976.322 I srv          init: running without SSL
0.03.976.368 I srv          init: using 8 threads for HTTP server
0.03.976.558 I srv         start: binding port with default address family
0.03.977.976 I srv          main: loading model
0.03.977.992 I srv    load_model: loading model '/Users/ciberloaner/.cache/huggingface/hub/models--unsloth--Qwen3.5-2B-GGUF/snapshots/f6d5376be1edb4d416d56da11e5397a961aca8ae/Qwen3.5-2B-Q4_K_M.gguf'
0.03.978.049 I common_init_result: fitting params to device memory ...
0.03.978.053 I common_init_result: (for bugs during this step try to reproduce them with -fit off, or provide --verbose logs if the bug only occurs with -fit on)
0.08.033.792 W llama_context: n_ctx_seq (8192) < n_ctx_train (262144) -- the full capacity of the model will not be utilized
0.08.215.214 W sched_reserve: layer 0 is assigned to device CPU but the fused Gated Delta Net tensor is assigned to device MTL0 (usually due to missing support)
0.08.215.222 W sched_reserve: fused Gated Delta Net (chunked) not supported, set to disabled
0.08.231.771 W load_hparams: Qwen-VL models require at minimum 1024 image tokens to function correctly on grounding tasks
0.08.231.781 W load_hparams: if you encounter problems with accuracy, try adding --image-min-tokens 1024
0.08.231.782 W load_hparams: more info: https://github.com/ggml-org/llama.cpp/issues/16842

0.10.751.513 I srv    load_model: loaded multimodal model, '/Users/ciberloaner/.cache/huggingface/hub/models--unsloth--Qwen3.5-2B-GGUF/snapshots/f6d5376be1edb4d416d56da11e5397a961aca8ae/mmproj-BF16.gguf'
0.10.751.525 I srv    load_model: initializing slots, n_slots = 4
0.13.468.502 W srv    load_model: speculative decoding will use checkpoints
0.13.468.595 W common_speculative_init: no implementations specified for speculative decoding
0.13.468.604 I slot   load_model: id  0 | task -1 | new slot, n_ctx = 8192
0.13.468.630 I slot   load_model: id  1 | task -1 | new slot, n_ctx = 8192
0.13.468.631 I slot   load_model: id  2 | task -1 | new slot, n_ctx = 8192
0.13.468.632 I slot   load_model: id  3 | task -1 | new slot, n_ctx = 8192
0.13.469.201 I srv    load_model: prompt cache is enabled, size limit: 8192 MiB
0.13.469.208 I srv    load_model: use `--cache-ram 0` to disable the prompt cache
0.13.469.209 I srv    load_model: for more info see https://github.com/ggml-org/llama.cpp/pull/16391
0.13.470.430 I srv          init: idle slots will be saved to prompt cache and cleared upon starting a new task
0.13.688.266 I init: chat template, example_format: '<|im_start|>system
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
0.13.800.411 I srv          init: init: chat template, thinking = 1
0.13.800.494 I srv          main: model loaded
0.13.800.840 I srv          main: server is listening on http://127.0.0.1:8009
0.13.800.879 I srv  update_slots: all slots are idle
0.29.829.272 I srv  params_from_: Chat format: peg-native
0.29.829.724 I slot get_availabl: id  3 | task -1 | selected slot by LRU, t_last = -1
0.29.829.727 I srv  get_availabl: updating prompt cache
0.29.829.738 I srv          load:  - looking for better prompt, base f_keep = -1.000, sim = 0.000
0.29.829.740 I srv        update:  - cache state: 0 prompts, 0.000 MiB (limits: 8192.000 MiB, 8192 tokens, 8589934592 est)
0.29.829.744 I srv  get_availabl: prompt cache update took 0.02 ms
0.29.829.836 I slot launch_slot_: id  3 | task 0 | processing task, is_child = 0
0.35.113.655 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    128, progress = 0.06, t =   5.28 s / 24.23 tokens per second
0.40.010.207 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    256, progress = 0.11, t =  10.18 s / 25.15 tokens per second
0.45.063.327 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    384, progress = 0.17, t =  15.23 s / 25.21 tokens per second
0.50.050.219 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    512, progress = 0.22, t =  20.22 s / 25.32 tokens per second
0.55.528.822 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    640, progress = 0.28, t =  25.70 s / 24.90 tokens per second
1.00.288.808 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    768, progress = 0.34, t =  30.46 s / 25.21 tokens per second
1.05.099.190 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =    896, progress = 0.39, t =  35.27 s / 25.40 tokens per second
1.09.877.477 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1024, progress = 0.45, t =  40.05 s / 25.57 tokens per second
1.14.816.626 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1152, progress = 0.50, t =  44.99 s / 25.61 tokens per second
1.19.793.062 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1280, progress = 0.56, t =  49.96 s / 25.62 tokens per second
1.24.545.218 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1408, progress = 0.62, t =  54.72 s / 25.73 tokens per second
1.29.529.602 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1536, progress = 0.67, t =  59.70 s / 25.73 tokens per second
1.34.515.876 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1664, progress = 0.73, t =  64.69 s / 25.72 tokens per second
1.39.520.596 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1792, progress = 0.78, t =  69.69 s / 25.71 tokens per second
1.46.929.722 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   1920, progress = 0.84, t =  77.10 s / 24.90 tokens per second
1.52.097.575 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   2048, progress = 0.90, t =  82.27 s / 24.89 tokens per second
1.56.879.957 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   2155, progress = 0.94, t =  87.05 s / 24.76 tokens per second
1.56.902.797 I slot create_check: id  3 | task 0 | created context checkpoint 1 of 32 (pos_min = 2154, pos_max = 2154, n_tokens = 2155, size = 19.266 MiB)
2.02.818.280 I slot print_timing: id  3 | task 0 | prompt processing, n_tokens =   2279, progress = 1.00, t =  92.99 s / 24.51 tokens per second
2.02.837.332 I slot create_check: id  3 | task 0 | created context checkpoint 2 of 32 (pos_min = 2278, pos_max = 2278, n_tokens = 2279, size = 19.266 MiB)
2.13.655.747 I slot print_timing: id  3 | task 0 | n_decoded =    100, tg =   9.73 t/s
2.16.677.905 I slot print_timing: id  3 | task 0 | n_decoded =    133, tg =  10.00 t/s
2.19.762.599 I slot print_timing: id  3 | task 0 | n_decoded =    168, tg =  10.26 t/s
2.22.789.068 I slot print_timing: id  3 | task 0 | n_decoded =    197, tg =  10.15 t/s
2.25.804.706 I slot print_timing: id  3 | task 0 | n_decoded =    225, tg =  10.04 t/s
2.28.854.148 I slot print_timing: id  3 | task 0 | n_decoded =    256, tg =  10.05 t/s
2.31.860.730 I slot print_timing: id  3 | task 0 | n_decoded =    279, tg =   9.80 t/s
2.34.893.498 I slot print_timing: id  3 | task 0 | n_decoded =    307, tg =   9.74 t/s
2.37.946.521 I slot print_timing: id  3 | task 0 | n_decoded =    337, tg =   9.75 t/s
2.41.012.522 I slot print_timing: id  3 | task 0 | n_decoded =    369, tg =   9.81 t/s
2.44.082.439 I slot print_timing: id  3 | task 0 | n_decoded =    397, tg =   9.75 t/s
2.47.110.598 I slot print_timing: id  3 | task 0 | n_decoded =    430, tg =   9.83 t/s
2.50.182.960 I slot print_timing: id  3 | task 0 | n_decoded =    466, tg =   9.96 t/s
2.53.226.923 I slot print_timing: id  3 | task 0 | n_decoded =    500, tg =  10.03 t/s
2.56.284.896 I slot print_timing: id  3 | task 0 | n_decoded =    531, tg =  10.04 t/s
2.59.327.975 I slot print_timing: id  3 | task 0 | n_decoded =    564, tg =  10.08 t/s
3.02.360.037 I slot print_timing: id  3 | task 0 | n_decoded =    599, tg =  10.16 t/s
3.05.363.755 I slot print_timing: id  3 | task 0 | n_decoded =    635, tg =  10.25 t/s
3.08.438.288 I slot print_timing: id  3 | task 0 | n_decoded =    670, tg =  10.30 t/s
3.11.449.835 I slot print_timing: id  3 | task 0 | n_decoded =    695, tg =  10.21 t/s
3.14.535.910 I slot print_timing: id  3 | task 0 | n_decoded =    721, tg =  10.13 t/s
3.17.537.666 I slot print_timing: id  3 | task 0 | n_decoded =    744, tg =  10.03 t/s
3.20.595.117 I slot print_timing: id  3 | task 0 | n_decoded =    771, tg =   9.99 t/s
3.23.752.324 I slot print_timing: id  3 | task 0 | n_decoded =    797, tg =   9.92 t/s
3.26.800.129 I slot print_timing: id  3 | task 0 | n_decoded =    825, tg =   9.89 t/s
3.29.891.349 I slot print_timing: id  3 | task 0 | n_decoded =    859, tg =   9.93 t/s
3.32.972.142 I slot print_timing: id  3 | task 0 | n_decoded =    890, tg =   9.93 t/s
3.35.992.724 I slot print_timing: id  3 | task 0 | n_decoded =    920, tg =   9.93 t/s
3.39.075.775 I slot print_timing: id  3 | task 0 | n_decoded =    952, tg =   9.95 t/s
3.42.169.413 I slot print_timing: id  3 | task 0 | n_decoded =    983, tg =   9.95 t/s
3.45.193.890 I slot print_timing: id  3 | task 0 | n_decoded =   1009, tg =   9.91 t/s
3.48.199.665 I slot print_timing: id  3 | task 0 | n_decoded =   1041, tg =   9.93 t/s
3.51.208.259 I slot print_timing: id  3 | task 0 | n_decoded =   1072, tg =   9.94 t/s
3.54.241.871 I slot print_timing: id  3 | task 0 | n_decoded =   1103, tg =   9.95 t/s
3.57.414.408 I slot print_timing: id  3 | task 0 | n_decoded =   1126, tg =   9.87 t/s
4.00.570.474 I slot print_timing: id  3 | task 0 | n_decoded =   1151, tg =   9.82 t/s
4.03.628.981 I slot print_timing: id  3 | task 0 | n_decoded =   1173, tg =   9.76 t/s
4.06.638.904 I slot print_timing: id  3 | task 0 | n_decoded =   1201, tg =   9.74 t/s
4.09.700.285 I slot print_timing: id  3 | task 0 | n_decoded =   1232, tg =   9.75 t/s
4.12.777.285 I slot print_timing: id  3 | task 0 | n_decoded =   1265, tg =   9.78 t/s
4.15.841.436 I slot print_timing: id  3 | task 0 | n_decoded =   1300, tg =   9.81 t/s
4.18.904.533 I slot print_timing: id  3 | task 0 | n_decoded =   1334, tg =   9.84 t/s
4.21.971.256 I slot print_timing: id  3 | task 0 | n_decoded =   1368, tg =   9.87 t/s
4.25.035.703 I slot print_timing: id  3 | task 0 | n_decoded =   1400, tg =   9.88 t/s
4.28.075.146 I slot print_timing: id  3 | task 0 | n_decoded =   1431, tg =   9.89 t/s
4.31.148.674 I slot print_timing: id  3 | task 0 | n_decoded =   1463, tg =   9.90 t/s
4.34.163.167 I slot print_timing: id  3 | task 0 | n_decoded =   1495, tg =   9.92 t/s
4.37.225.064 I slot print_timing: id  3 | task 0 | n_decoded =   1526, tg =   9.92 t/s
4.40.286.098 I slot print_timing: id  3 | task 0 | n_decoded =   1559, tg =   9.94 t/s
4.43.324.690 I slot print_timing: id  3 | task 0 | n_decoded =   1591, tg =   9.95 t/s
4.46.352.831 I slot print_timing: id  3 | task 0 | n_decoded =   1621, tg =   9.95 t/s
4.49.426.635 I slot print_timing: id  3 | task 0 | n_decoded =   1652, tg =   9.95 t/s
4.52.430.937 I slot print_timing: id  3 | task 0 | n_decoded =   1684, tg =   9.96 t/s
4.55.517.508 I slot print_timing: id  3 | task 0 | n_decoded =   1717, tg =   9.97 t/s
4.58.525.720 I slot print_timing: id  3 | task 0 | n_decoded =   1748, tg =   9.98 t/s
5.01.569.460 I slot print_timing: id  3 | task 0 | n_decoded =   1779, tg =   9.98 t/s
5.04.583.379 I slot print_timing: id  3 | task 0 | n_decoded =   1807, tg =   9.97 t/s
5.06.943.013 I slot print_timing: id  3 | task 0 | 
prompt eval time =   93553.63 ms /  2283 tokens (   40.98 ms per token,    24.40 tokens per second)
       eval time =  183559.50 ms /  1832 tokens (  100.20 ms per token,     9.98 tokens per second)
      total time =  277113.13 ms /  4115 tokens
5.06.961.650 I slot      release: id  3 | task 0 | stop processing: n_tokens = 4114, truncated = 0
5.06.961.694 I srv  update_slots: all slots are idle
