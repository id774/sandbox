require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open '/path/to/an/excel-file.xls'

book.worksheets

sheet1 = book.worksheet 0
sheet2 = book.worksheet 'Sheet1'

sheet1.each do |row|
  # do something interesting with a row
end

sheet2.each 2 do |row|
  # do something interesting with a row
end

row = sheet1.row(3)

row[0]

row.format 2

book = Spreadsheet::Workbook.new

sheet1 = book.create_worksheet

sheet2 = book.create_worksheet :name => 'My Second Worksheet'
sheet1.name = 'My First Worksheet'

sheet1.row(0).concat %w{Name Country Acknowlegement}
sheet1[1,0] = 'Japan'
row = sheet1.row(1)
row.push 'Creator of Ruby'
row.unshift 'Yukihiro Matsumoto'
sheet1.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
                        'Author of original code for Spreadsheet::Excel' ]
sheet1.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
sheet1.row(3).insert 1, 'Unknown'
sheet1.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'


sheet1.row(0).height = 18

format = Spreadsheet::Format.new :color => :blue,
                                 :weight => :bold,
                                 :size => 18
sheet1.row(0).default_format = format

bold = Spreadsheet::Format.new :weight => :bold
4.times do |x| sheet1.row(x + 1).set_format(0, bold) end


book.write '/path/to/output/excel-file.xls'
