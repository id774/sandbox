# daemon.rb: Minimal daemon with a PID file and logger
#
# Description:
# Fork into the background, write ./daemon.pid, log start and stop messages to
# standard output, run a loop that sleeps one second per iteration, and remove
# the PID file on shutdown.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby daemon.rb
#
# Requirements:
# - Ruby on a platform that supports fork
#

require 'fileutils'
require 'logger'

class DaemonTest
  def initialize
    @term = false
    @logger = Logger.new(STDOUT)
    @logger.info "daemon start..."
    @pid_file_path = './daemon.pid'
    @file = "./test.txt"
  end

  def execute
    File.open(@file, "w") do |f|
      loop do
        f.puts "test"
        f.flush
        break if @term
        sleep 1
      end
    end
  end

  def run
    daemonize
    begin
      Signal.trap(:TERM) { shutdown }
      Signal.trap(:INT) { shutdown }
      execute
    rescue => ex
      @logger.error ex
    end
  end

  def shutdown
    @term = true
    @logger.info "daemon close..."
    @logger.close
    FileUtils.rm @pid_file_path
  end

  def daemonize
    exit!(0) if Process.fork
    Process.setsid
    exit!(0) if Process.fork
    open_pid_file
  end

  def open_pid_file
    begin
      open(@pid_file_path, 'w') {|f| f << Process.pid } if @pid_file_path
    rescue => ex
      @logger.error "could not open pid file (#{@pid_file_path})"
      @logger.error "error: #{ex}"
      @logger.error ex.backtrace * "\n"
    end
  end
end

DaemonTest.new.run
