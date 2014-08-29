#!/bin/bash

# ADMIN_MAIL_ADDRESS=xxxxxx@gmail.com
RUBY=/opt/ruby/current/bin/ruby
JOBLOG="/var/log/sysadmin/ping-monitor.log"
TARGETS="A B C"

case "$ADMIN_MAIL_ADDRESS" in
  *@*)
    $RUBY ping-monitor.rb $TARGETS > $JOBLOG
    grep "unreachable" $JOBLOG && (nkf -w $JOBLOG | mail -s "[admin][`/bin/hostname`] Ping unreachable detected" $ADMIN_MAIL_ADDRESS)
    ;;
esac

exit 0
