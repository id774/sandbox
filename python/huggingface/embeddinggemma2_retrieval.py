#!/usr/bin/env python3

# embeddinggemma2_retrieval.py: Cross-modal retrieval with EmbeddingGemma 2
#
# Description:
# Embeds one text query and text, code, and synthetic image candidates with
# google/embeddinggemma-2, then ranks all candidates in the shared 768-
# dimensional embedding space.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ./embeddinggemma2_retrieval.py
#
# Requirements:
# - Python 3.10 or later
# - sentence-transformers 6.1.0 or later with the image extra
# - PyTorch 2.2 or later
# - transformers 5.0 or later
#
# Notes:
# - The first run downloads the public google/embeddinggemma-2 model from the
#   Hugging Face Hub and stores it in the local Hugging Face cache.
# - No Hugging Face token is needed.
# - The audio encoder is disabled because this sample uses only text, code, and
#   images.
#
# References:
# - https://developers.googleblog.com/embeddinggemma-2-the-developer-guide/
# - https://huggingface.co/google/embeddinggemma-2
# - Inspired by https://qiita.com/Takuya__/items/d15f26d5630631dfb8db

from PIL import Image, ImageDraw
from sentence_transformers import SentenceTransformer

MODEL = "google/embeddinggemma-2"
DIMENSION = 768
QUERY = "red square"


def make_image(shape, color):
    image = Image.new("RGB", (224, 224), "white")
    draw = ImageDraw.Draw(image)
    bounds = (48, 48, 176, 176)

    if shape == "square":
        draw.rectangle(bounds, fill=color)
    elif shape == "circle":
        draw.ellipse(bounds, fill=color)
    else:
        raise ValueError(f"unsupported shape: {shape}")

    return image


model = SentenceTransformer(
    MODEL,
    config_kwargs={"audio_config": None},
)

text_candidates = [
    {
        "name": "red-square-text",
        "modality": "text",
        "content": "A red square centered on a white background.",
    },
    {
        "name": "blue-circle-text",
        "modality": "text",
        "content": "A blue circle centered on a white background.",
    },
    {
        "name": "red-square-code",
        "modality": "code",
        "content": 'draw.rectangle((48, 48, 176, 176), fill="red")',
    },
    {
        "name": "blue-circle-code",
        "modality": "code",
        "content": 'draw.ellipse((48, 48, 176, 176), fill="blue")',
    },
]

image_candidates = [
    {
        "name": "red-square-image",
        "modality": "image",
        "content": make_image("square", "red"),
    },
    {
        "name": "blue-circle-image",
        "modality": "image",
        "content": make_image("circle", "blue"),
    },
]

query_embedding = model.encode(QUERY, prompt_name="SearchQuery")
text_embeddings = model.encode(
    [candidate["content"] for candidate in text_candidates],
    prompt_name="Document",
)
image_embeddings = model.encode(
    [{"image": candidate["content"]} for candidate in image_candidates]
)

assert query_embedding.shape[-1] == DIMENSION
for embedding in [*text_embeddings, *image_embeddings]:
    assert embedding.shape[-1] == DIMENSION

results = []
for candidate, embedding in zip(
    [*text_candidates, *image_candidates],
    [*text_embeddings, *image_embeddings],
):
    score = float(model.similarity(query_embedding, embedding).item())
    results.append((candidate, score))

scores = {candidate["name"]: score for candidate, score in results}

assert scores["red-square-text"] > scores["blue-circle-text"]
assert scores["red-square-code"] > scores["blue-circle-code"]
assert scores["red-square-image"] > scores["blue-circle-image"]

print(f"model: {MODEL}")
print(f"dimension: {DIMENSION}")
print(f"query: {QUERY}")
print("ranking:")

for rank, (candidate, score) in enumerate(
    sorted(results, key=lambda result: result[1], reverse=True),
    start=1,
):
    print(
        f"{rank}. {candidate['modality']} "
        f"{candidate['name']} score={score:.6f}"
    )
