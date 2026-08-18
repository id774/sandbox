#!/usr/bin/env python3

# Classify a few sentences with a Transformers pipeline.

from transformers import pipeline

MODEL = "distilbert/distilbert-base-uncased-finetuned-sst-2-english"

classifier = pipeline(task="sentiment-analysis", model=MODEL)

print(f"task: {classifier.task}")
print(f"model: {classifier.model.name_or_path}")
print(f"labels: {classifier.model.config.id2label}")

texts = [
    "This sandbox makes the library easy to try out.",
    "The download took forever and the result was useless.",
]

for text, result in zip(texts, classifier(texts)):
    print(f"{result['label']} {result['score']:.4f} <- {text}")
