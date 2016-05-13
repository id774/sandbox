require 'spreadsheet'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open 'template.xls'

# シート 1 を読み込み
sheet1 = book.worksheet 0

# 事業部名
sheet1[0, 1] = "第五金融事業部"

# 案件
sheet1[1, 2] = "ほげほげ案件 (作番 xxxx-xxxxx)"

# 概要
sheet1[2, 4] = "概要を Ruby で記入します"

# ユーザ
sheet1[3, 4] = "ほげほげ商事"

# 契約先
sheet1[3, 7] = "ふがふがシステム"

# 契約先
sheet1[3, 10] = "150,000 千円"

# 契約形態
sheet1[4, 4] = "一括"

# 営業担当
sheet1[4, 6] = "山田部長"

# PM (PL)
sheet1[4, 8] = "田中課長"

# 体制
sheet1[4, 10] = "社員 5 名、BP 8 名"

# 対応時期
sheet1[5, 4] = "2016/04/01 〜 2016/09/30"

# サービス開始
sheet1[5, 4] = "2016/10/01"

# 概況
sheet1[7, 4] = "
あああ
　いいい
　　ううう"

# 進捗
sheet1[8, 4] = "
あああ
　いいい
　　ううう"

# 品質
sheet1[9, 4] = "
あああ
　いいい
　　ううう"

# その他
sheet1[10, 4] = "
あああ
　いいい
　　ううう"

# 名前を付けて保存
book.write 'out.xls'
