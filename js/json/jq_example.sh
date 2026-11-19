#!/bin/bash
# jq_example.sh: Turn JSON objects into CSV rows with jq
#
# Description:
# Pipe three fixed JSON objects through jq filters that produce CSV rows.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash jq_example.sh
#
# Requirements:
# - Bash
# - jq
#

echo '{"key1": 1, "key2": 2}' | jq -r "[.key1, .key2] | @csv"
echo '{"key1": 1, "key2": [1, 2, 3, 4]}' | jq -r "[.key1, .key2[]] | @csv"
echo '{"key1": 1, "key2": [1, 2, 3, 4]}' | jq -r "{key1, key2: .key2[]} | [.key1, .key2] | @csv"
