# -*- frozen_string_literal: true -*-
# immutable_string.rb: Modify a frozen string literal
#
# Description:
# Append to a string literal under the frozen_string_literal magic comment,
# which raises an error because the literal is frozen.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby immutable_string.rb
#
# Requirements:
# - Ruby 2.3 or later, which supports the frozen_string_literal magic
#   comment
#

sec_id = 1
stats_tablename = "hoge"
path_tablename = "fuga"

sql = "SELECT #{sec_id}, pt.path, st.doc_count "
sql << "FROM #{stats_tablename} AS st "  #### can't modify frozen String (RuntimeError)
sql << "JOIN #{path_tablename} AS pt ON (st.path_id = pt.id)"

p sql
