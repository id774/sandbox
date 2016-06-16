require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open File.join(File.expand_path("~"), "tmp", "1.xls")

# シート 1 を読み込み
sheet1 = book.worksheet 0

sheet1.each_with_index {|row, i|
  if row[34].to_s.match(/【案件/)
    puts "#{i}: #{row[4]}"
  end
}
