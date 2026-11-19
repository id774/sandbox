# ruby_growl_multibyte_for_ruby192.rb: Multibyte Growl notifications on Ruby 1.9.2
#
# Description:
# Patch Growl notification packets to carry multibyte text on Ruby 1.9.2.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Ruby 1.9.2 with a Growl class to patch
#

class Growl
  private

  def notification_packet(name, title, description, priority, sticky)
    flags = 0
    data = []

    packet = [
      GROWL_PROTOCOL_VERSION,
      GROWL_TYPE_NOTIFICATION,
    ]

    flags = 0
    flags |= ((0x7 & priority) << 1) # 3 bits for priority
    flags |= 1 if sticky # 1 bit for sticky

    packet << flags
    packet << name.bytesize
    packet << title.bytesize
    packet << description.bytesize
    packet << @app_name.bytesize

    data << name
    data << title
    data << description
    data << @app_name

    packet << data.join
    packet = packet.pack GNN_FORMAT

    checksum = MD5.new packet
    checksum.update @password unless @password.nil?

    packet << checksum.digest

    return packet.force_encoding('utf-8')
  end

  def send(packet)
    packet.force_encoding('UTF-8')
    set_sndbuf packet.bytesize
    @socket.send packet, 0
    @socket.flush
  end
end

