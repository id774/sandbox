# vim_muscle_scouter.rb Vim muscle scouter
# Author: Sora Harakami <sora134[at]gmail(dot)com>

def scouter(str)
    return str.gsub(/^\n/,"").gsub(/^\s*".+\n/,"").gsub(/^\s*\\.+\n/,"").split("\n").length
end

p scouter(File.read(ENV['HOME']+"/_vimrc"))

