#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sqlalchemy

class Status(object):
    pass

def create_engine():
    config = {"sqlalchemy.url": "sqlite:///test.db"}
    engine = sqlalchemy.engine_from_config(config)

    from sqlalchemy.orm import scoped_session, sessionmaker
    db_session = scoped_session(sessionmaker(autoflush=True, transactional=True, bind=engine))
    return engine

def statuses():
    from sqlalchemy import MetaData
    from sqlalchemy import Column, Table, types
    from sqlalchemy.orm import mapper, relation
    metadata = MetaData()
    status = Table("statuses", metadata,
                   Column("id", types.Integer, primary_key=True),
                   Column("screen_name", types.Unicode, nullable=False),
                   Column("text", types.Unicode),
                   Column("created_at", types.Date),
                   Column("protected", types.Boolean),
                   Column("in_reply_to_status_id", types.Integer),
                   Column("in_reply_to_user_id", types.Integer),
                   Column("in_reply_to_screen_name", types.Unicode),
                   Column("statuses_count", types.Integer),
                   Column("friends_count", types.Integer),
                   Column("followers_count", types.Integer),
                   Column("source", types.Unicode))
    mapper(Status, status)
    return status

def run():
    engine = create_engine()
    status = statuses()

    sql = status.delete()
    result = engine.execute(sql)

    sql = status.insert().values(id=1,screen_name="hoge",text=u"ほげ")
    result = engine.execute(sql)

    sql = status.insert().values(id=2,screen_name="fuga",text=u"ふが")
    result = engine.execute(sql)

    sql = status.insert().values(id=3,screen_name="piyo",text=u"ぴよ")
    result = engine.execute(sql)

    sql = status.update().where(status.c.screen_name=="piyo").values(screen_name="taro")
    result = engine.execute(sql)

    sql = status.delete().where(status.c.screen_name=="fuga")
    result = engine.execute(sql)

    sql = status.select()
    result = engine.execute(sql)
    for row in result:
        print row

if __name__ == "__main__":
    run()
