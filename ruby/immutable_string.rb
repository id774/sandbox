# -*- frozen_string_literal: true -*-

sec_id = 1
stats_tablename = "hoge"
path_tablename = "fuga"

sql = "SELECT #{sec_id}, pt.path, st.doc_count "
sql << "FROM #{stats_tablename} AS st "  #### can't modify frozen String (RuntimeError)
sql << "JOIN #{path_tablename} AS pt ON (st.path_id = pt.id)"

p sql
