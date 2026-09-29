#!/usr/bin/env python3

# watermark_detection.py: Text watermark detection with Transformers
#
# Description:
# Detects a Hugging Face text watermark in generated token sequences by
# running WatermarkDetector against plain and watermarked GPT-2
# completions, and prints the prediction for each.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Source: https://qiita.com/ynakayama/items/1bbe6e443152f6236311
#
# Usage:
#     ./watermark_detection.py
#
# Requirements:
# - Python 3.10 or later
# - transformers 4.41 or later
# - PyTorch 1.11 or later
#
# Notes:
# - The first run downloads the public model from the Hugging Face Hub, so
#   it needs network access, and stores it in the local Hugging Face cache.
#   Later runs read the cache.
# - No Hugging Face token is needed, and a CPU is enough.

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
