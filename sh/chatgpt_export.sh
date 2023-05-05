#!/bin/bash

# 出力ディレクトリを作成
output_dir="output"
mkdir -p "$output_dir"

# YYYY-MM-DD-conversationsフォルダを検索
for conversation_dir in *-conversations; do
  # YYYY-MM-DDフォルダを検索
  for date_dir in "$conversation_dir"/*; do
    # マークダウンファイルを検索
    for file in "$date_dir"/*.md; do
      # ファイル名から余計な数字を除外してリネーム
      new_filename=$(echo "$(basename "$file")" | sed -r 's/^[0-9]{1,2}-[0-9]{1,2}-[0-9]{1,2}-//')
      # 出力ディレクトリにコピー
      cp "$file" "$output_dir/$new_filename"
    done
  done
done

