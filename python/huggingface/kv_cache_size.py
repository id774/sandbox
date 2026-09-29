#!/usr/bin/env python3

# kv_cache_size.py: KV cache size estimate from a Hugging Face config.json
#
# Description:
# Estimates the KV cache size of a model from a local Hugging Face
# config.json, a context length, and optionally the number of sequences
# and the bytes per element.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 kv_cache_size.py CONFIG --context TOKENS
#         [--sequences N] [--bytes-per-element BYTES]
#
#     Example with the sample config in fixtures/:
#     python3 kv_cache_size.py fixtures/kv_cache_config.json --context 32768
#
# Requirements:
# - Python 3.10 or later
# - Only the Python standard library is required
#
# Notes:
# - The input is a local config.json file. The sample needs no network
#   access, no Hugging Face library, and no token.

import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument("config")
parser.add_argument("--context", type=int, required=True)
parser.add_argument("--sequences", type=int, default=1)
parser.add_argument("--bytes-per-element", type=float, default=2.0)
args = parser.parse_args()

with open(args.config, encoding="utf-8") as f:
    config = json.load(f)

layers = config["num_hidden_layers"]
attention_heads = config["num_attention_heads"]
kv_heads = config.get("num_key_value_heads", attention_heads)

head_dim = config.get("head_dim")
if head_dim is None:
    head_dim = config["hidden_size"] // attention_heads

kv_bytes = (
    2
    * layers
    * args.context
    * kv_heads
    * head_dim
    * args.bytes_per_element
    * args.sequences
)

print(f"layers              : {layers}")
print(f"kv heads            : {kv_heads}")
print(f"head dim            : {head_dim}")
print(f"context             : {args.context}")
print(f"sequences           : {args.sequences}")
print(f"bytes per element   : {args.bytes_per_element}")
print(f"KV cache            : {kv_bytes / 1024**3:.2f} GiB")
