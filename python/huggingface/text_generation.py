#!/usr/bin/env python3

# Generate a short continuation with a small text-generation pipeline.

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
