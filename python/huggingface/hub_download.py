#!/usr/bin/env python3

# hub_download.py: Single-file download from the Hugging Face Hub
#
# Description:
# Downloads one small file, a model's config.json, from the Hub with
# hf_hub_download(), without Transformers or Datasets, and prints its
# cached path and a few of its values.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./hub_download.py
#
# Requirements:
# - Python 3.10 or later
# - huggingface_hub 0.11 or later
#
# Notes:
# - The sample downloads from a public Hub repository, so it needs network
#   access. The file is stored in the local Hugging Face cache.
# - No Hugging Face token is needed.

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
