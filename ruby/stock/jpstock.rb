require 'optparse'
require 'logger'
require 'jpstock'
require 'csv'
require 'date'
require 'fluent-logger'

class Stock
  def initialize(args, options)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
    @codes = args
    @options = options
    if options[:fluentd]
      @fluentd = Fluent::Logger::FluentLogger.open(nil,
        host = 'localhost',
        port = 9999)
    end
  end

  def main
    read_from_file unless @options[:filename].nil?
    get_price
  end

  private

  def puts(message, level=:info)
    @logger.send(level, message)
  end

  def puts_fluentd(stock)
    begin
      @fluentd.post('stock.price', {
        :created_at => stock.date,
        :open => stock.open,
        :high => stock.high,
        :low => stock.low,
        :close => stock.close,
        :volume => stock.volume,
        :adj_close => stock.close
      })
    rescue
      puts("Fault in forwarding fluentd", level=:error)
    end
  end

  def write_price(stock)
    CSV.open("stock_#{stock.code}.csv", "a") {|csv|
      csv << [
        stock.date.strftime("%Y-%m-%d"),
        stock.open,
        stock.high,
        stock.low,
        stock.close,
        stock.volume,
        stock.close
      ]
    }
    puts("Saved stock code: #{stock.code}", level=:debug)
    puts_fluentd(stock) if @options[:fluentd]
  end

  def write_title(stock)
    CSV.open("stock_#{stock.code}.csv", "w") {|csv|
      csv << [
        "Date",
        "Open",
        "High",
        "Low",
        "Close",
        "Volume",
        "Adj Close"
      ]
    }
    puts("Create csv with title: #{stock.code}", level=:debug)
  end

  def read_from_file
    open(@options[:filename]) do |file|
      file.each_line do |line|
        @codes << line.force_encoding("utf-8").strip.split(",")[0]
      end
    end
    puts("Target codes: #{@codes}", level=:info)
  end

  def get_price
    @codes.each do |code|
      begin
        if @options[:start_date].nil?
          stock = JpStock.price(:code => code)
          write_price(stock)
        else
          date = Date.parse(@options[:start_date])
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
    parser.on('-f', '--file FILE', String, "read stocks data from FILENAME"){|f| options[:filename] = f }
    parser.on('-d', '--date DATE', String, "new records start from YYYY-MM-DD"){|d| options[:start_date] = d }
    parser.on('-l', '--log', "Output log with fluentd"){ options[:fluentd] = true }
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
