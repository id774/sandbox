def extract_basename(filename)
  basename = File.basename(filename, File.extname(filename))
  p "#{filename} => #{basename}"
end

extract_basename("hoge.txt")
extract_basename("fuga.tar.gz")
extract_basename("test.csv")
extract_basename("a.b.c.d.e")
