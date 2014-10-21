require 'optparse'
require 'logger'
require 'jpstock'
require 'csv'
require 'date'

class Stock
  def initialize(args, options)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
    @args = args
    @options = options
  end

  def main
    if @options['filename'].nil?
      get_price
    end
  end

  private

  def puts(message, level=:info)
    @logger.send(level, message)
  end

  def write_price(stock)
    CSV.open("stock_#{stock.code}.csv", "a") {|csv|
      csv << [
        stock.date.strftime("%Y-%m-%d"),
        stock.code,
        stock.open,
        stock.close,
        stock.high,
        stock.low,
        stock.volume
      ]
    }
  end

  def write_title(stock)
    CSV.open("stock_#{stock.code}.csv", "w") {|csv|
      csv << [
        "日付",
        "コード",
        "始値",
        "終値",
        "高値",
        "安値",
        "出来高"
      ]
    }
    puts("Saved stock code: #{stock.code}}")
  end

  def get_price
    @args.each do |code|
      begin
        if @options['start_date'].nil?
          stock = JpStock.price(:code => code)
          write_price(stock)
        else
          date = Date.parse(@options['start_date'])
          stocks = JpStock.historical_prices(:code => code, :start_date => date, :end_date => Date.today)
          write_title(stocks.first)
          stocks.reverse.each {|stock| write_price(stock)}
        end
      rescue JpStock::PriceException
        puts("Failed in getting stock code: #{code}}". level=:error)
      end
    end
  end

end

if __FILE__ == $0
  options = Hash.new
  parser = OptionParser.new do |parser|
    parser.banner = "#{File.basename($0,".*")}
    Usage: #{File.basename($0,".*")} [options] args"
    parser.separator "options:"
    parser.on('-f', '--file FILE', String, "read data from FILENAME"){|f| options['filename'] = f }
    parser.on('-d', '--date DATE', String, "state date is YYYY-MM-DD"){|d| options['start_date'] = d }
    parser.on('-v', '--verbose', "verbose"){ options['verbose'] = true }
    parser.on('-q', '--quiet', "quiet"){ options['verbose'] = false }
    parser.on('-h', '--help', "show this message"){
      puts parser
      exit
    }
  end

  begin
    parser.parse!
  rescue OptionParser::ParseError => err
    $stderr.puts err.message
    $stderr.puts parser.help
    exit 1
  end

  stock = Stock.new(ARGV, options)
  stock.main
end
