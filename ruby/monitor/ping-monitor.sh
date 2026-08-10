#!/bin/bash

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
