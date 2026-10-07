#!/usr/bin/env python3

# embeddinggemma2_retrieval.py: Text, code, and image retrieval with EmbeddingGemma 2
#
# Description:
# Embeds one text query and six candidates, text, code, and image, with
# EmbeddingGemma 2 in its shared 768-dimensional space. It ranks all of them
# in one list by similarity to the query, and checks that in each modality the
# relevant candidate scores above the distractor. The images are drawn in
# memory, so no data file is needed.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Reference: https://developers.googleblog.com/embeddinggemma-2-the-developer-guide/
# Model: https://huggingface.co/google/embeddinggemma-2
#
# Usage:
#     ./embeddinggemma2_retrieval.py
#
# Requirements:
# - Python 3.10 or later
# - sentence-transformers 6.1.0 or later, with the image extra
# - PyTorch
#
# Notes:
# - The first run downloads the public model from the Hugging Face Hub, so
#   it needs network access, and stores it in the local Hugging Face cache.
#   Later runs read the cache.
# - The audio encoder is switched off, so only the text and vision parts of
#   the model are loaded.
# - No Hugging Face token is needed.
# - The script exits with a non-zero status when a check fails.

import sys

from PIL import Image, ImageDraw
from sentence_transformers import SentenceTransformer

MODEL_ID = "google/embeddinggemma-2"
DIMENSION = 768
QUERY = "red square"

IMAGE_SIZE = 224
BOX = (56, 56, 168, 168)

CODE_RED_SQUARE = 'draw.rectangle((56, 56, 168, 168), fill="red")'
CODE_BLUE_CIRCLE = 'draw.ellipse((56, 56, 168, 168), fill="blue")'


def draw_shape(shape, color):
    image = Image.new("RGB", (IMAGE_SIZE, IMAGE_SIZE), "white")
    draw = ImageDraw.Draw(image)
    if shape == "square":
        draw.rectangle(BOX, fill=color)
    else:
        draw.ellipse(BOX, fill=color)
    return image


# (modality, name, content, is_relevant)
CANDIDATES = [
    ("text", "red-square-text", "A solid red square on a white background.", True),
    ("text", "blue-circle-text", "A solid blue circle on a white background.", False),
    ("code", "red-square-code", CODE_RED_SQUARE, True),
    ("code", "blue-circle-code", CODE_BLUE_CIRCLE, False),
    ("image", "red-square-image", draw_shape("square", "red"), True),
    ("image", "blue-circle-image", draw_shape("circle", "blue"), False),
]


def check_dimension(name, embeddings):
    if embeddings.shape[-1] != DIMENSION:
        sys.exit(f"{name}: expected {DIMENSION} dimensions, got {embeddings.shape[-1]}")


model = SentenceTransformer(MODEL_ID, config_kwargs={"audio_config": None})

query_vector = model.encode(QUERY, prompt_name="SearchQuery")
check_dimension("query", query_vector)

scores = {}
for modality in ("text", "code", "image"):
    group = [c for c in CANDIDATES if c[0] == modality]
    contents = [c[2] for c in group]
    if modality == "image":
        vectors = model.encode(contents)
    else:
        vectors = model.encode(contents, prompt_name="Document")
    check_dimension(modality, vectors)
    for candidate, score in zip(group, model.similarity(query_vector, vectors)[0]):
        scores[candidate[1]] = float(score)

print(f"model: {MODEL_ID}")
print(f"dimension: {DIMENSION}")
print(f"query: {QUERY}")
print("ranking:")
ranked = sorted(CANDIDATES, key=lambda c: scores[c[1]], reverse=True)
for rank, (modality, name, _, _) in enumerate(ranked, start=1):
    print(f"{rank}. {modality:<5} {name:<18} {scores[name]:.4f}")

failed = False
for modality in ("text", "code", "image"):
    relevant = next(c[1] for c in CANDIDATES if c[0] == modality and c[3])
    distractor = next(c[1] for c in CANDIDATES if c[0] == modality and not c[3])
    ok = scores[relevant] > scores[distractor]
    failed = failed or not ok
    print(f"{modality}: {relevant} > {distractor}: {'PASS' if ok else 'FAIL'}")

sys.exit(1 if failed else 0)
