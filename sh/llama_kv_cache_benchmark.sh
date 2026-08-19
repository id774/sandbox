#!/bin/sh
# Compare an F16 KV cache with a Q8_0 one through llama-bench, at the same
# prompt length, generation length, context depths, and repeat count.
# Run this from the directory holding llama-bench and model-Q4_K_M.gguf.

# Benchmark the F16 KV cache
./llama-bench \
  -m model-Q4_K_M.gguf \
  -ctk f16 \
  -ctv f16 \
  -p 512 \
  -n 128 \
  -d 0,4096,16384 \
  -r 5

# Benchmark the Q8_0 KV cache
./llama-bench \
  -m model-Q4_K_M.gguf \
  -ctk q8_0 \
  -ctv q8_0 \
  -p 512 \
  -n 128 \
  -d 0,4096,16384 \
  -r 5
