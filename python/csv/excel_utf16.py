# Compare CSV dialects that keep UTF-16 output readable in Excel.

import csv

# http://akiyoko.hatenablog.jp/entry/2017/12/09/010411

def main():
    rows = [['神崎 蘭子'], ['あああ', 'いいい', 'ううう'], ['Ⅰ・Ⅱ・Ⅲ', '①②③']]

    # OK
    with open('utf_16_excel_tab.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # This works too
    with open('utf_16_excel_tab_2.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, dialect='excel', delimiter='\t', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # No garbled text, but the cells are not separated, so this one is no good
    with open('utf_16.csv', 'w', newline='', encoding='utf-16') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # Garbled text, though not always
    with open('utf_8_sig.csv', 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # Sometimes garbled, and the cells are not separated either, so this one is no good
    with open('utf_8_sig_excel_tab.csv', 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # Garbled text
    with open('utf_8.csv', 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f, quoting=csv.QUOTE_ALL)
        w.writerows(rows)

    # Garbled text
    with open('utf_8_excel_tab.csv', 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f, dialect='excel-tab', quoting=csv.QUOTE_ALL)
        w.writerows(rows)

if __name__ == '__main__':
    main()
