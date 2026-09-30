#!/bin/sh
# llama_kv_cache_benchmark.sh: Compare F16 and Q8_0 KV caches with llama-bench
#
# Description:
# Compare an F16 KV cache with a Q8_0 one through llama-bench, at the same
# prompt length, generation length, context depths, and repeat count. It runs
# llama-bench twice, once with -ctk f16 -ctv f16 and once with -ctk q8_0
# -ctv q8_0, each with -p 512 -n 128 -d 0,4096,16384 -r 5.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh /path/to/llama_kv_cache_benchmark.sh
#
#     Run this from the directory holding llama-bench and model-Q4_K_M.gguf.
#     It takes no arguments; the binary and the model are found as
#     ./llama-bench and model-Q4_K_M.gguf in the current directory.
#
# Requirements:
# - A POSIX.1-2008 sh
# - An executable ./llama-bench from a llama.cpp build that supports the
#   -ctk, -ctv, -p, -n, -d, and -r options used here
# - The model file model-Q4_K_M.gguf in the current directory
# - Enough local compute and memory to run the benchmark
#
# Notes:
# - The script itself uses no network access, model download, or API
#   credential; the binary and the model must already be present locally.

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
