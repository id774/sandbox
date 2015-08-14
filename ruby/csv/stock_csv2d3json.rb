# -*- coding: utf-8 -*-

require 'csv'
require 'json'
require 'time'

class Converter
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
  end

  def main
    array = read_from_file
    write_file("out.json", array)
  end

  private

  def read_from_file
    array = []

    Dir.glob(File.join(@in_dir, "ti_*.csv")).each do |filename|
      hash = transform_file(filename) if FileTest.file?(filename)
      array.push(hash)
    end

    return array
  end

  def transform_file(filename)
    array = []

    table = CSV.table(File.expand_path(filename), encoding: "UTF-8")
    keys = table.headers

    CSV.foreach(File.expand_path(filename), encoding: "UTF-8" ) do |row|
      hashed_row = Hash[*keys.zip(row).flatten]
      #=> {:date=>"2015-05-08", :open=>"19315.63086", :high=>"19458.75", :low=>"19302.71094", :close=>"19379.18945", :volume=>"176200.0", :adj_close=>"19379.18945", :sma5=>"19453.214452000004", :sma25=>"19734.3049216", :sma75=>"18911.497532133344", :ewma5=>"19469.880040313907", :ewma25=>"19617.12401593871", :ewma75=>"19008.305720479864", :upperband=>"19692.498444493685", :middleband=>"19492.65780835779", :lowerband=>"19292.817172221898", :ret_index=>"1.243355625489215", :vol=>"1.512240216244905", :rsi9=>"36.36087024082427", :rsi14=>"43.071151392818926", :mfi=>"44.96250228552546", :roc=>"-3.748458695935753", :cci=>"-94.10101914325246", :ultosc=>"42.94788430703307", :slowk=>"21.797492402107945", :slowd=>"17.898246130074572", :fastk=>"41.620161774153736", :fastd=>"21.797492402107945", :macd=>"10.449286059603764", :macdsignal=>"111.83030072523063", :macdhist=>"-101.38101466562686", :mom10=>"-754.7109399999972", :mom25=>"344.3496100000011", :natr=>"1.0981910499182597", :v_ratio=>"52.50297973778307"}

      pri_key = hashed_row[:date]
      unless pri_key == "Date"
        unixtime = Time.parse(pri_key).to_i
        array.push([unixtime * 1000,
                    # hashed_row[:ret_index].to_f])
                    hashed_row[:adj_close].to_f])
      end
    end

    basename = File.basename(filename)
    base_numbers = basename.scan(/[0-9]/).join("")
    hash = {"key" => base_numbers, "values" => array}

    return hash
  end

  def write_file(filename, array)
    File.write(
      File.join(@out_dir, File.basename(filename)),
      JSON.pretty_generate(array)
    )
  end
end

if __FILE__ == $0
  c = Converter.new(ARGV)
  c.main
end

