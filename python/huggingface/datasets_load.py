#!/usr/bin/env python3

# Inspect a small public dataset, then read a large one in streaming mode.

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
