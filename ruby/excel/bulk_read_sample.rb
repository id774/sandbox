require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open File.join(File.expand_path("~"), "tmp", "1.xls")

# シート 1 を読み込み
sheet1 = book.worksheet 0

sheet1.each_with_index {|row, i|
  if row[34].to_s.match(/【案件/)
    # puts "案件番号 #{i}: #{row[4]}"
    puts "案件番号 #{i}: #{sheet1[i, 4].to_s.match(/^\d{4}-\d{5}/)}"
    puts "案件名 #{i}: #{sheet1[i+6, 9].gsub(/[\r\n]/," ")}" unless sheet1[i, 4].nil?
    puts "期間 #{i}: #{sheet1[i, 16]}"
    puts "売上規模 #{i}: #{sheet1[i+1, 16]}"
    puts "見込み利益率 #{i}: #{sheet1[i+3, 16]}"
    puts "工程 #{i}: #{sheet1[i+4, 16]}"
    puts "案件種別 #{i}: #{sheet1[i+5, 16]}"
    puts "社員数 #{i}: #{sheet1[i, 32]}"
    puts "BP 数 #{i}: #{sheet1[i+1, 32]}"
    puts "PM #{i}: #{sheet1[i+3, 30].gsub(/[\r\n]/," ")}" unless sheet1[i+3, 30].nil?
  end
}
