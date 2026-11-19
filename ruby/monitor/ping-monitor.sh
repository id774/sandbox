#!/bin/bash
# ping-monitor.sh: Mail an alert when a monitored host is unreachable
#
# Description:
# Run /root/bin/ping-monitor.rb for the placeholder targets, write the result
# to /var/log/sysadmin/ping-monitor.log, and mail it to the placeholder
# administrator address when a host is unreachable.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash ping-monitor.sh
#
# Requirements:
# - Bash, nkf, and mail
# - Ruby at /opt/ruby/current/bin/ruby and ping-monitor.rb at
#   /root/bin/ping-monitor.rb
# - Real targets and an administrator address in place of the placeholders
#

ADMIN_MAIL_ADDRESS=xxxxxx@gmail.com
RUBY=/opt/ruby/current/bin/ruby
MONITOR=/root/bin/ping-monitor.rb
JOBLOG=/var/log/sysadmin/ping-monitor.log
TARGETS="
A B C
"

$RUBY $MONITOR $TARGETS > $JOBLOG
grep "unreachable" $JOBLOG && (nkf -w $JOBLOG | mail -s "[admin][`/bin/hostname`] Ping unreachable detected" $ADMIN_MAIL_ADDRESS)

exit 0
