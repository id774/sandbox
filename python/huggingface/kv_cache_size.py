#!/usr/bin/env python3

# Estimate the KV cache size from a Hugging Face config.json.

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
