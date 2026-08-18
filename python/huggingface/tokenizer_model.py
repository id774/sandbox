#!/usr/bin/env python3

# Run a tokenizer and a base model by hand, without a pipeline.

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
