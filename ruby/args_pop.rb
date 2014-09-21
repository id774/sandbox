class Test
  def initialize(args)
    @args_first = args.shift || "First"
    @args_second = args.shift || "Second"
    @args_third = args.shift || "Third"
  end

  def main
    p @args_first
    p @args_second
    p @args_third
  end
end

if __FILE__ == $0
  test = Test.new(ARGV)
  test.main
end
