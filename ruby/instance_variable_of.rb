# define_method

class Foo
  def initialize(message)
    @message = message
  end

  def method_missing(method, *args, &block)
    if method == :hi
      'hello'
    else
      super
    end
  end

end

foo = Foo.new('hi')
p foo.instance_variable_get( '@message' )
p foo.hi

