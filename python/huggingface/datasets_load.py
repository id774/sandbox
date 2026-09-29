#!/usr/bin/env python3

# datasets_load.py: Regular and streaming dataset loading with Datasets
#
# Description:
# Loads a small public dataset and prints its size, columns, features, and
# first rows, then reads a larger public dataset in streaming mode so that
# it is not downloaded up front.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./datasets_load.py
#
# Requirements:
# - Python 3.10 or later
# - datasets 2.0 or later
#
# Notes:
# - The sample reads public datasets from the Hugging Face Hub, so it needs
#   network access. The small dataset is stored in the local Hugging Face
#   cache; the larger one is streamed.
# - No Hugging Face token is needed.

from datasets import load_dataset

SMALL = "cornell-movie-review-data/rotten_tomatoes"
STREAMED = "stanfordnlp/imdb"

dataset = load_dataset(SMALL, split="test")

print(f"dataset: {SMALL}")
print(f"rows: {len(dataset)}")
print(f"columns: {dataset.column_names}")
print(f"features: {dataset.features}")

for row in dataset.select(range(3)):
    label = dataset.features["label"].int2str(row["label"])
    print(f"{label}: {row['text'][:60]}")

# Stream a larger dataset so that nothing is downloaded up front.
stream = load_dataset(STREAMED, split="train", streaming=True)

print(f"streamed dataset: {STREAMED}")
print(f"features: {stream.features}")

for row in stream.take(3):
    print(f"{row['label']}: {row['text'][:60]}")
