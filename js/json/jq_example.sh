#!/bin/bash

echo '{"key1": 1, "key2": 2}' | jq -r "[.key1, .key2] | @csv"
echo '{"key1": 1, "key2": [1, 2, 3, 4]}' | jq -r "[.key1, .key2[]] | @csv"
echo '{"key1": 1, "key2": [1, 2, 3, 4]}' | jq -r "{key1, key2: .key2[]} | [.key1, .key2] | @csv"
