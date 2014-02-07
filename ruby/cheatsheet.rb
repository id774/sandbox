# -*- coding: utf-8 -*-
# モジュールはいろんなクラスで共有できる部品のようなもの
# クラスに組み込むには'include'で指定する
# モジュールはincludeの前に記述されている必要がある
module Keyboard

  # モジュールをincludeしたクラスのインスタンス変数を表示するメソッド
  def type(key)
    puts "You typed [#{key}] with #{self.name}.\n\n"
  end

end

class Phone
  # モジュールを読み込む
  include Keyboard

  # 定数
  TYPE = "mobile"

  # クラス変数
  # Phoneクラス、もしくはPhoneを継承しているクラスの
  # インスタンスからアクセスできる
  # アクセサメソッドではアクセスできないので、
  # 参照したい場合は別にメソッドを用意する必要がある
  @@count = 0

  # クラスインスタンス変数
  # 継承先のクラスからは参照できない / 継承先で同じ名前で定義しても互いに影響しない
  # インスタンスからも参照できない
  @camera = "NO"

  # インスタンスが作られる時に自動的に実行されるメソッド
  # JAVAでいうコンストラクタ
  def initialize(name, version, color)
    # インスタンス変数
    # 名前は同じでもインスタンスごとに実態は異なる
    @name = name
    @version = version
    @color = color
    # 新しくインスタンスが作られた時に、クラス変数を更新してみる
    @@count += 1
  end

  # アクセサメソッド
  # phone.nameみたいにインスタンス変数を参照することができるようにする
  # 3種類あり、できることがそれぞれ違う
  attr_reader   :name     # read
  attr_writer   :version  # write
  attr_accessor :color    # read/write

  def start
    puts "Welcome to #{self.color} #{self.name}! (instance method)\n\n"
  end

  def sleep(wake_up_time)
    puts "See you at #{wake_up_time}, zzz.... (instance method)\n\n"
  end

  def exit
    puts "Good bye! from #{self.name} (instance method)\n\n"
  end

  def change_color(color)
    # インスタンス変数の値を変えてみる
    self.color = color
    puts "You changed color to #{color} (instance method)\n\n"
  end

  # クラスメソッドは.selfをつける
  # Phone.show_device_countとしてクラス変数を表示している
  # インスタンスの状況に左右されない処理をおこなう
  def self.show_device_count
    puts "@@count : #{@@count} ('Class' method with class variable)\n\n"
  end

  # クラスメソッドを定義してクラスインスタンス変数を表示してみる
  def self.camera?
    puts "Camera : #{@camera}\n\n"
  end

end

# クラスの継承
# SmartPhoneクラスはPhoneクラスを継承している
class SmartPhone < Phone

  # Phoneクラスで読み込んでいるで再度モジュールを読み込む必要はない
  # include Keyboard

  # このメソッドはSmartPhoneクラスのインスタンスだけが使える
  def take_photo
    puts "You can take photo with smartphone!\n\n"
    # プライベートメソッド / 下記private参照
    store_photo(self)
  end

  # メソッドのオーバーライド（上書き）
  # Phoneクラスでもchange_colorが定義されているが、同じ名前で上書きできる
  def change_color(color, surface)
    # スーパークラス（親クラス）のメソッドを実行する場合はsuperを使う
    super(color)
    puts "Now your phone's surface is polished! (Override instance method)\n\n"
  end

  # @cameraはnilを返す
  # @camearaはPhoneのクラスインスタンス変数でありSmartPhoneクラスからは参照できない
  def self.camera?
    puts "Camera : #{@camera} (of course dosn't work)\n\n"
  end

  # privateから下に書かれたメソッドはプライベートメソッドとなる
  # 同じクラス内のメソッドからのみ実行できる
  private

    def store_photo(device)
      puts " -> Photo is saved in #{device.name}. (Private method)\n\n"
    end

end

# Phoneクラスのインスタンスを作成してphoneに代入
# 3つの引数はinitializeメソッドに使われる
phone = Phone.new('Traditional Phone', 1.0, 'black')

# 定数を表示してみる :: で参照可能
puts "\n\nTYPE : #{Phone::TYPE}"

# クラスメソッド（self.がついたメソッド）を実行
puts Phone.camera?

# インスタンスメソッド
phone.start

# 引数ありのインスタンスメソッド
phone.change_color('white')

# @versionはattr_writerが設定されているので、
# アクセサメソッドで@versionの値を'変更'できるが'表示'はできない
phone.version = 1.1

now = Time.now()
wake_up_time = now + 2*60*60
phone.sleep(wake_up_time)

# 読み込んだモジュールのメソッドを使ってみる
phone.type('t')

# クラスメソッド
# クラス変数@@countを表示する
Phone.show_device_count

# SmartPhoneクラスからインスタンスを作成
# SmartPhoneクラスではinitializeを定義していないが、
# Phoneクラスを継承しているので引数を3つとる
iphone = SmartPhone.new('iPhone', 5.2, 'black')
# Phoneクラスのメソッドが使える
iphone.start

# クラス変数@@countを表示
# クラス変数は継承先のクラスとも共有されるので2を返すはず
# これがクラスインスタンス変数と異なる特徴
Phone.show_device_count

# PhoneクラスにはないメソッドがSmartPhoneクラスでは使える
iphone.take_photo

# オーバーライドされたメソッドを使ってみる
iphone.change_color('gold', 'polished')

# 上で書いたようにこのメソッドは意図した通り動かない
# SmartPhoneクラスでは@cameraというクラスインスタンス変数が定義されていない
SmartPhone.camera?

# 継承先のクラスでも継承元で読み込んだモジュールのメソッドが使える
iphone.type('i')

phone.exit
iphone.exit

