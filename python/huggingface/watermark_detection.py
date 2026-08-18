#!/usr/bin/env python3

# Detect a Hugging Face text watermark in generated token sequences.
# Source: https://qiita.com/ynakayama/items/1bbe6e443152f6236311

from transformers import (
    AutoModelForCausalLM,
    AutoTokenizer,
    WatermarkDetector,
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
input_length = inputs["input_ids"].shape[-1]

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

plain_completion_ids = plain_ids[:, input_length:]
watermarked_completion_ids = watermarked_ids[:, input_length:]

detector = WatermarkDetector(
    model_config=model.config,
    device="cpu",
    watermarking_config=watermarking_config,
)

plain_result = detector(
    plain_completion_ids,
    return_dict=True,
)

watermarked_result = detector(
    watermarked_completion_ids,
    return_dict=True,
)

print("plain:", plain_result.prediction)
print("watermarked:", watermarked_result.prediction)
