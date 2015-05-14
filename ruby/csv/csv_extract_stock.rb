#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'sysadmin'
require 'pp'

CSV_PATH = 'ti_N225.csv'

def create_hash(hash)
  table = CSV.table(File.expand_path(CSV_PATH), encoding: "UTF-8")
  keys = table.headers

  CSV.foreach(File.expand_path(CSV_PATH), encoding: "UTF-8" ) do |row|
    hashed_row = Hash[*keys.zip(row).flatten]
    #=> {:date=>"2015-05-08", :open=>"19315.63086", :high=>"19458.75", :low=>"19302.71094", :close=>"19379.18945", :volume=>"176200.0", :adj_close=>"19379.18945", :sma5=>"19453.214452000004", :sma25=>"19734.3049216", :sma75=>"18911.497532133344", :ewma5=>"19469.880040313907", :ewma25=>"19617.12401593871", :ewma75=>"19008.305720479864", :upperband=>"19692.498444493685", :middleband=>"19492.65780835779", :lowerband=>"19292.817172221898", :ret_index=>"1.243355625489215", :vol=>"1.512240216244905", :rsi9=>"36.36087024082427", :rsi14=>"43.071151392818926", :mfi=>"44.96250228552546", :roc=>"-3.748458695935753", :cci=>"-94.10101914325246", :ultosc=>"42.94788430703307", :slowk=>"21.797492402107945", :slowd=>"17.898246130074572", :fastk=>"41.620161774153736", :fastd=>"21.797492402107945", :macd=>"10.449286059603764", :macdsignal=>"111.83030072523063", :macdhist=>"-101.38101466562686", :mom10=>"-754.7109399999972", :mom25=>"344.3496100000011", :natr=>"1.0981910499182597", :v_ratio=>"52.50297973778307"}

    pri_key = hashed_row[:date]
    unless pri_key == "Date"
      hash[pri_key] =
        {
          "Open"  => hashed_row[:open],
          "High"  => hashed_row[:high],
          "Low"   => hashed_row[:low],
          "Close" => hashed_row[:adj_close]
        }
    end
  end

  return hash
end

def extract
  array = []

  hash = Sysadmin::Util.create_multi_dimensional_hash
  hash = create_hash(hash)

  i = 3
  hash.each do |k, v|
    pp k, v if i < 10
    i += 1
  end
end

if __FILE__ == $0
  extract
end
