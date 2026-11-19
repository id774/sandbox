#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# example2.py: Reflect a SQLite table and select every row
#
# Description:
# Reflect an existing SQLite table and select every row.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 example2.py
#
# Requirements:
# - Python 3
# - SQLAlchemy
# - An SQLite database test.db in the current directory
#

from sqlalchemy import *

def run():
    engine = create_engine("sqlite:///test.db")
    metadata = MetaData(bind=engine, reflect=True)
    statuses = metadata.tables['statuses']

    stmt = statuses.select()
    result = engine.execute(stmt)
    print(stmt)
    for row in result:
        print(row.screen_name, row.text, sep="\t")

if __name__ == "__main__":
    run()
