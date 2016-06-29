require 'zip/zip'

Zip::ZipFile.open("hoge.zip") do |zip|
  zip.each do |entry|
    puts "extract #{entry.to_s}"
    zip.extract(entry, entry.to_s) { true } # true で上書き
  end
end
