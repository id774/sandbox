def extract_basename(filename)
  basename = File.basename(filename, File.extname(filename))
  return "#{filename} => #{basename}"
end

p extract_basename("hoge.txt")
p extract_basename("fuga.tar.gz")
p extract_basename("test.csv")
p extract_basename("a.b.c.d.e")
