#!/usr/bin/env python3

# tokenizer_model.py: Tokenizer and base model used directly, without a pipeline
#
# Description:
# Runs AutoTokenizer and AutoModel by hand, without a pipeline, on a
# public DistilBERT model, and prints the tokens, input tensor shapes, and
# output hidden-state shape.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./tokenizer_model.py
#
# Requirements:
# - Python 3.10 or later
# - transformers 4.27 or later
# - PyTorch 1.11 or later
#
# Notes:
# - The first run downloads the public model from the Hugging Face Hub, so
#   it needs network access, and stores it in the local Hugging Face cache.
#   Later runs read the cache.
# - No Hugging Face token is needed, and a CPU is enough.

from transformers import AutoModel, AutoTokenizer

MODEL = "distilbert/distilbert-base-uncased"

tokenizer = AutoTokenizer.from_pretrained(MODEL)
model = AutoModel.from_pretrained(MODEL)

text = "Tokenizers turn text into tensors."
inputs = tokenizer(text, return_tensors="pt")

print(f"tokens: {tokenizer.tokenize(text)}")
print(f"input_ids: {inputs['input_ids'].tolist()}")
for name, tensor in inputs.items():
    print(f"input {name}: {tuple(tensor.shape)}")

outputs = model(**inputs)

print(f"last_hidden_state: {tuple(outputs.last_hidden_state.shape)}")
print(f"hidden size: {model.config.hidden_size}")
print(f"first token vector head: {outputs.last_hidden_state[0, 0, :5].tolist()}")
