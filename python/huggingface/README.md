# Hugging Face

Small, independent samples that try out the Hugging Face libraries from Python.

Each file covers one concept, so that the boundary between the layers stays
visible: `transformers` for models and pipelines, `datasets` for data, and
`huggingface_hub` for plain file access to the Hub.

## Requirements

Any recent Python 3 with the libraries in `requirements.txt`:

    pip install -r requirements.txt

The CPU build of PyTorch is enough. If pip installs a CUDA build that the
machine cannot use, take the CPU wheel instead:

    pip install torch --index-url https://download.pytorch.org/whl/cpu

## Samples

- `pipeline_classification.py` builds a `pipeline()` for sentiment analysis and
  prints the task, the model, its labels, and the predictions.
- `tokenizer_model.py` does the same work one layer down, calling
  `AutoTokenizer` and `AutoModel` directly and showing the tensor shapes.
- `text_generation.py` continues a short prompt with a text-generation pipeline
  and a `GenerationConfig`.
- `watermark_generation.py` compares ordinary GPT-2 generation with generation
  using Transformers `WatermarkingConfig`.
- `watermark_detection.py` runs `WatermarkDetector` against plain and
  watermarked completion tokens.
- `datasets_load.py` reads a small dataset, prints its columns, features, and
  first rows, then reads a larger one in streaming mode.
- `hub_download.py` fetches a single `config.json` with `hf_hub_download()` and
  prints the cached path and a few of its values.

Run any of them directly:

    ./pipeline_classification.py
    ./tokenizer_model.py
    ./text_generation.py
    ./watermark_generation.py
    ./watermark_detection.py
    ./datasets_load.py
    ./hub_download.py

## Models and datasets

- `distilbert/distilbert-base-uncased-finetuned-sst-2-english`
  ([model card](https://huggingface.co/distilbert/distilbert-base-uncased-finetuned-sst-2-english))
- `distilbert/distilbert-base-uncased`
  ([model card](https://huggingface.co/distilbert/distilbert-base-uncased))
- `openai-community/gpt2`
  ([model card](https://huggingface.co/openai-community/gpt2))
- `cornell-movie-review-data/rotten_tomatoes`
  ([dataset card](https://huggingface.co/datasets/cornell-movie-review-data/rotten_tomatoes))
- `stanfordnlp/imdb`
  ([dataset card](https://huggingface.co/datasets/stanfordnlp/imdb))

All of them are public and not gated, they need no authentication, and they run
on CPU alone.

## Notes

The first run of a sample downloads its model or dataset from the Hugging Face
Hub and stores it under the local cache, `~/.cache/huggingface` unless
`HF_HOME` says otherwise. Later runs read the cache and start much faster.

Download size differs per model, from a few hundred megabytes for the DistilBERT
and GPT-2 examples down to a few megabytes for the small dataset and the single
config file, so the first run of each sample takes a different amount of time.

No token is needed here, and no token belongs in the source. For a private or
gated repository, log in with `hf auth login` or export `HF_TOKEN` in the
shell instead.

Official documentation: [Transformers](https://huggingface.co/docs/transformers),
[Datasets](https://huggingface.co/docs/datasets), and
[Hub Python library](https://huggingface.co/docs/huggingface_hub).
