#!/usr/bin/env python
# -*- encoding: utf-8 -*-

from sqlalchemy import *

def run():
    engine = create_engine("sqlite:///test.db")
    metadata = MetaData(bind=engine, reflect=True)
    blogs = metadata.tables['blogs']

    stmt = blogs.select()
    result = engine.execute(stmt)
    print stmt
    for row in result:
        print row.title

if __name__ == "__main__":
    run()
