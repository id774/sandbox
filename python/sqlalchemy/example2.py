#!/usr/bin/env python
# -*- encoding: utf-8 -*-

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
