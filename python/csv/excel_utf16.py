import csv

# http://akiyoko.hatenablog.jp/entry/2017/12/09/010411

def main():
    rows = [['神崎 蘭子'], ['あああ', 'いいい', 'ううう'], ['Ⅰ・Ⅱ・Ⅲ', '①②③']]

    # OK
    with open('utf_16_excel_tab.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # これでも OK
    with open('utf_16_excel_tab_2.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, dialect='excel', delimiter='\t', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # 文字化けしないが、セルごとに分かれないので NG
    with open('utf_16.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # 文字化け （しない場合もある）
    with open('utf_8_sig.csv', 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # 文字化け （しない場合もあるが、セルごとに分かれないので NG）
    with open('utf_8_sig_excel_tab.csv', 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # 文字化け
    with open('utf_8.csv', 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # 文字化け
    with open('utf_8_excel_tab.csv', 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

if __name__ == '__main__':
    main()
