# Fill in an Excel template and save it as a new workbook.

require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open 'template.xls'

# Read sheet 1
sheet1 = book.worksheet 0

# Division name
sheet1[0, 1] = "第五金融事業部"

# Project
sheet1[1, 2] = "ほげほげ案件 (作番 xxxx-xxxxx)"

# Summary
sheet1[2, 4] = "概要を Ruby で記入します"

# User
sheet1[3, 4] = "ほげほげ商事"

# Contract party
sheet1[3, 7] = "ふがふがシステム"

# Contract party
sheet1[3, 10] = "150,000 千円"

# Contract type
sheet1[4, 4] = "一括"

# Sales representative
sheet1[4, 6] = "山田部長"

# PM (PL)
sheet1[4, 8] = "田中課長"

# Team structure
sheet1[4, 10] = "社員 5 名、BP 8 名"

# Schedule
sheet1[5, 4] = "2016/04/01 〜 2016/09/30"

# Service start
sheet1[5, 4] = "2016/10/01"

# Overview
sheet1[7, 4] = "
あああ
　いいい
　　ううう"

# Progress
sheet1[8, 4] = "
あああ
　いいい
　　ううう"

# Quality
sheet1[9, 4] = "
あああ
　いいい
　　ううう"

# Other
sheet1[10, 4] = "
あああ
　いいい
　　ううう"

# Save as a new file
book.write 'out.xls'
