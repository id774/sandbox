#!/Users/sorah/local/bin/ruby

require 'open-uri'
base_url = "http://build.chromium.org/buildbot/snapshots/chromium-rel-mac/"
latest_url = base_url+"LATEST"
puts "Base: "+base_url
#GET latest
puts "Getting latest..."
latest_s = ""
open(latest_url) do |f|
    f.each_line{|line|latest_s += line}
end
puts "Latest build id: "+latest_s
chrometan = base_url+latest_s+"/chrome-mac.zip"
puts "Chromium zip url: "+chrometan
#GET chrometan
puts "Downloading chromium..."
open(chrometan) do |h|
    File.open("/tmp/chrometan.zip","wb") do |f|
        print "."
        f.write(h.read)
    end
end
print "done"
puts "Downloaded"
#unzip chrometan
puts "Unzip chrome-mac.zip"
Dir.chdir("/tmp/") {|path| system("unzip","/tmp/chrometan.zip")}
    puts "Installing..."
Dir.chdir("/tmp/chrome-mac/"){|path| system("cp","-R","Chromium.app","/Applications")}
puts "Removing temp file/directory"
Dir.chdir("/tmp/") do |path|
    puts "rm chrometan.zip"
    system("rm","chrometan.zip")
    puts "rm -rf chrome-mac"
    system("rm","-rf","chrome-mac")
end
puts "All completed!"
