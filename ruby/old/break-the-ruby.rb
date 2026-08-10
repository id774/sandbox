#a = TrueClass
#b = FalseClass
#TrueClass = b
#FalseClass = a
#true.instance_eval {
#  undef :&
#  undef :|
#  undef :^
#}
class Foobar
  def hoge
    puts "hogehoge"
    undef :hoge
  end
end
a = Foobar.new
a.hoge
a.hoge
