# jpstock_quote.rb: Quotes of listed stock codes written to CSV
#
# Description:
# Write the quotes of the listed stock codes into ref_index.csv.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby jpstock_quote.rb
#
# Requirements:
# - Ruby
# - The jpstock gem
#

require 'csv'
require 'jpstock'

CSV.open('ref_index.csv', "wb") do |csv|
  csv << ["銘柄コード", "銘柄名称", "株価", "前日終値", "予想株価 (PERxEPS)", "始値", "高値", "安値", "出来高", "時価総額 (百万円)", "発行済株式数", "配当利回り (会社予想)", "1 株配当 (会社予想)", "PER (会社予想)", "PBR (実績)", "EPS (会社予想)", "BPS (実績)", "最低購入代金", "単元株数", "年初来高値", "年初来安値"]

  CSV.foreach('stocks.txt') do |row|
    code = row[0]
    unless code == "N225"
      jps = JpStock.quote(:code=>code)
      if jps.per and jps.eps
        expected_price = jps.per * jps.eps
      else
        expected_price = nil
      end
      csv << [jps.code, jps.company_name, jps.close, jps.prev_close, expected_price, jps.open, jps.high, jps.low, jps.volume, jps.market_cap, jps.shares_issued, jps.dividend_yield, jps.dividend_one, jps.per, jps.pbr, jps.eps, jps.bps, jps.price_min, jps.round_lot, jps.years_high, jps.years_low]
    end
  end
end
