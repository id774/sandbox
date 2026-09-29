#!/usr/bin/env python3

# text_generation.py: Short text continuation with a text-generation pipeline
#
# Description:
# Generates a short continuation of a prompt with a GPT-2 text-generation
# pipeline, passing the generation parameters as a GenerationConfig.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./text_generation.py
#
# Requirements:
# - Python 3.10 or later
# - transformers 4.29 or later
# - PyTorch 1.11 or later
#
# Notes:
# - The first run downloads the public model from the Hugging Face Hub, so
#   it needs network access, and stores it in the local Hugging Face cache.
#   Later runs read the cache.
# - No Hugging Face token is needed, and a CPU is enough.

from transformers import GenerationConfig, pipeline

MODEL = "openai-community/gpt2"

generator = pipeline(task="text-generation", model=MODEL)

# Pass generation parameters as a config object, as current Transformers
# deprecates mixing a config with loose keyword arguments.
config = GenerationConfig(max_new_tokens=32, do_sample=True, top_k=50, temperature=0.8)

prompt = "A sandbox repository is useful because"
outputs = generator(prompt, generation_config=config)

print(f"model: {MODEL}")
print(f"prompt: {prompt}")
print(f"max_new_tokens: {config.max_new_tokens}")
print(f"generated: {outputs[0]['generated_text']}")
