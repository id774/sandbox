
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

