#!/usr/bin/env python3

# pipeline_classification.py: Sentiment classification with a Transformers pipeline
#
# Description:
# Classifies a few sentences with a Transformers sentiment-analysis
# pipeline built on a public DistilBERT model, and prints the task, the
# model, its labels, and the predictions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./pipeline_classification.py
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
