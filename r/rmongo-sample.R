# rmongo-sample.R: Query a MongoDB collection with rmongodb
#
# Description:
# Connect to the fluentd database on localhost:27017 with rmongodb and print
# up to 100 records of the fluentd.news.feed collection.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript rmongo-sample.R
#
# Requirements:
# - R with the rmongodb package
# - A MongoDB server on localhost:27017
#

library(rmongodb)

#mongo <- mongo.create(c("172.16.0.0.:00000", "172.16.0.0.:00000"), db="fluentd")
mongo <- mongo.create("localhost:27017", db="fluentd")

if (mongo.is.connected(mongo)) {
  buf <- mongo.bson.buffer.create()
  # mongo.bson.buffer.append(buf, "age", 18L)
  query <- mongo.bson.from.buffer(buf)

  # Find the first 100 records
  # in collection people of database test where age == 18
  cursor <- mongo.find(mongo, "fluentd.news.feed", query, limit=100L)

  # Step though the matching records and display them
  while (mongo.cursor.next(cursor))
    print(mongo.cursor.value(cursor))
  mongo.cursor.destroy(cursor)
}

