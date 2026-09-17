# LangChain

## Overview

This directory holds small samples that try out retrieval behavior in
LangChain from Python.

`parent_child_retrieval.py` compares two retrieval strategies over the same
document:

- flat retrieval, which returns the 200-token child chunk that matched the
  query as is
- parent-child retrieval, which searches over 200-token child chunks but
  returns the 1000-token parent chunk that contains the matched child

The sample lets the retrieval granularity (the child chunk size used for
search) and the context volume passed on for answer generation (the parent
chunk size) be observed as two independent settings.

## Requirements

The sample was written against Python 3.12.

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

An OpenAI API key is required for the embeddings call:

```sh
export OPENAI_API_KEY='YOUR_API_KEY'
```

## Run

```sh
python3 parent_child_retrieval.py
```

The output shows the flat child chunk retrieved for the query, the child
chunk and parent chunk retrieved by `ParentDocumentRetriever`, and the token
counts of the retrieved child and parent chunks.

## Files

- `parent_child_retrieval.py`: runs the flat retrieval and parent-child
  retrieval comparison and prints the retrieved chunks and their token
  counts.
- `requirements.txt`: dependencies used by the sample.

## Source

This sample reproduces the code from the following article:

<https://qiita.com/ynakayama/items/88005c72a6272939ad0b>
