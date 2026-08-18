#!/usr/bin/env python3

# Compare plain and watermarked text generation with Hugging Face Transformers.
# Source: https://qiita.com/ynakayama/items/1bbe6e443152f6236311

from transformers import (
    AutoModelForCausalLM,
    AutoTokenizer,
    WatermarkingConfig,
)

model_id = "openai-community/gpt2"

tokenizer = AutoTokenizer.from_pretrained(model_id)
model = AutoModelForCausalLM.from_pretrained(model_id)
model.eval()

prompt = (
    "Artificial intelligence systems are increasingly used "
    "to generate text for software documentation and technical writing."
)
inputs = tokenizer(prompt, return_tensors="pt")

watermarking_config = WatermarkingConfig(
    greenlist_ratio=0.25,
    bias=2.5,
    seeding_scheme="selfhash",
)

generation_options = {
    "max_new_tokens": 160,
    "do_sample": False,
    "pad_token_id": tokenizer.eos_token_id,
}

plain_ids = model.generate(
    **inputs,
    **generation_options,
)

watermarked_ids = model.generate(
    **inputs,
    watermarking_config=watermarking_config,
    **generation_options,
)

plain_text = tokenizer.decode(
    plain_ids[0],
    skip_special_tokens=True,
)

watermarked_text = tokenizer.decode(
    watermarked_ids[0],
    skip_special_tokens=True,
)

print("=== plain ===")
print(plain_text)

print()
print("=== watermarked ===")
print(watermarked_text)
