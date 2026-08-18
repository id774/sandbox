#!/usr/bin/env python3

# Download one small file from the Hub without Transformers or Datasets.

import json

from huggingface_hub import hf_hub_download

REPO = "openai-community/gpt2"

path = hf_hub_download(repo_id=REPO, filename="config.json")

print(f"repo: {REPO}")
print(f"local path: {path}")

with open(path, encoding="utf-8") as config_file:
    config = json.load(config_file)

for key in ("model_type", "n_layer", "n_head", "n_embd", "vocab_size"):
    print(f"{key}: {config.get(key)}")
