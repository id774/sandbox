# Extract every entry of a zip archive, overwriting existing files.

require 'zip/zip'

Zip::ZipFile.open("hoge.zip") do |zip|
  zip.each do |entry|
    puts "extract #{entry.to_s}"
    zip.extract(entry, entry.to_s) { true } # true overwrites
  end
end
