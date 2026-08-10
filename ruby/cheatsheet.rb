# -*- coding: utf-8 -*-
# A module is a piece of behaviour that many classes can share
# Bring it into a class with 'include'
# The module must be written before the include
module Keyboard

  # Print the instance variables of whichever class included this module
  def type(key)
    puts "You typed [#{key}] with #{self.name}.\n\n"
  end

end

class Phone
  # Include the module
  include Keyboard

  # Constant
  TYPE = "mobile"

  # Class variable
  # Reachable from instances of Phone and of any class that
  # inherits from Phone
  # An accessor method cannot reach it, so a separate method is
  # needed to read it
  @@count = 0

  # Class instance variable
  # A subclass cannot see it, and defining the same name there does not affect it
  # An instance cannot see it either
  @camera = "NO"

  # Runs automatically when an instance is created
  # The constructor, in Java terms
  def initialize(name, version, color)
    # Instance variable
    # The name is shared but each instance holds its own value
    @name = name
    @version = version
    @color = color
    # Update the class variable whenever a new instance is created
    @@count += 1
  end

  # Accessor methods
  # Let an instance variable be read as phone.name
  # There are three of them, each allowing something different
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
    # Change the value of an instance variable
    self.color = color
    puts "You changed color to #{color} (instance method)\n\n"
  end

  # A class method is prefixed with self.
  # Phone.show_device_count prints the class variable
  # It does work that does not depend on any instance
  def self.show_device_count
    puts "@@count : #{@@count} ('Class' method with class variable)\n\n"
  end

  # Define a class method that prints the class instance variable
  def self.camera?
    puts "Camera : #{@camera}\n\n"
  end

end

# Inheritance
# SmartPhone inherits from Phone
class SmartPhone < Phone

  # Phone already included the module, so there is no need to include it again
  # include Keyboard

  # Only instances of SmartPhone can use this method
  def take_photo
    puts "You can take photo with smartphone!\n\n"
    # Private method; see the private section below
    store_photo(self)
  end

  # Method override
  # Phone also defines change_color, and the same name overrides it here
  def change_color(color, surface)
    # Use super to call the method of the parent class
    super(color)
    puts "Now your phone's surface is polished! (Override instance method)\n\n"
  end

  # @camera returns nil
  # @camera is a class instance variable of Phone, so SmartPhone cannot see it
  def self.camera?
    puts "Camera : #{@camera} (of course dosn't work)\n\n"
  end

  # Methods written below private become private methods
  # They can only be called from methods of the same class
  private

    def store_photo(device)
      puts " -> Photo is saved in #{device.name}. (Private method)\n\n"
    end

end

# Create an instance of Phone and assign it to phone
# The three arguments go to the initialize method
phone = Phone.new('Traditional Phone', 1.0, 'black')

# Print the constant; :: reaches it
puts "\n\nTYPE : #{Phone::TYPE}"

# Call a class method, the kind prefixed with self.
puts Phone.camera?

# Instance method
phone.start

# Instance method taking an argument
phone.change_color('white')

# @version has attr_writer, so the accessor can change its value
# but cannot print it
phone.version = 1.1

now = Time.now()
wake_up_time = now + 2*60*60
phone.sleep(wake_up_time)

# Call a method from the included module
phone.type('t')

# Class method
# Print the class variable @@count
Phone.show_device_count

# Create an instance of SmartPhone
# SmartPhone does not define initialize, but it inherits from
# Phone, so it still takes three arguments
iphone = SmartPhone.new('iPhone', 5.2, 'black')
# The methods of Phone are available
iphone.start

# Print the class variable @@count
# A class variable is shared with subclasses, so this should print 2
# This is where it differs from a class instance variable
Phone.show_device_count

# A method absent from Phone is available on SmartPhone
iphone.take_photo

# Call the overridden method
iphone.change_color('gold', 'polished')

# As noted above, this method does not work as intended
# SmartPhone does not define a class instance variable named @camera
SmartPhone.camera?

# A subclass can also use the methods of a module included by its parent
iphone.type('i')

phone.exit
iphone.exit

