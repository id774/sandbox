require 'jpstock'
require 'awesome_print'

code = "9613"

ap JpStock.sector(:code=>code)
ap JpStock.quote(:code=>code)
ap JpStock.price(:code=>code)
ap JpStock.historical_prices(:code=>code, :start_date=>Date.new(2014,10,1), :end_date=>Date.today)
