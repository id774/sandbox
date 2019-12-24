import os
import sys
import pandas as pd
import psycopg2


def connection_config(owner):
    return {
            'host' :     '127.0.0.1',
            'port' :     '5432',
            'database' : owner,
            'user' :     owner,
            'password' : owner
        }


def read_by_sql(sql, owner):
    connect = connection_config(owner)
    conn = psycopg2.connect(**connect)
    conn.autocommit = True
    df = pd.read_sql(sql=sql, con=conn)
    conn.close()
    return df


def select_from_db(sid, owner, table_name):
    sql = "select sid, uid, department, attendant, account_number, role, electronic_delivery, active from %s where sid = '%s' order by uid asc;" % (table_name, sid)
    return read_by_sql(sql, owner)


def main(args):
    sid = args[1]
    owner = 's' + sid
    table_name = 'users'

    df = select_from_db(sid, owner, table_name)
    filename = (table_name + '.csv')

    df = pd.concat([df, pd.DataFrame([['password','']]*len(df))], axis=1)

    df.to_csv(filename, date_format='%Y/%m/%d %H:%M:%S', index=False, encoding="utf8")


if __name__ == "__main__":
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main(sys.argv)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
