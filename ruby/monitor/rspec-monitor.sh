#!/bin/bash

ADMIN_MAIL_ADDRESS=xxxxxx@gmail.com
RSPEC=/opt/ruby/current/bin/rspec
RSPEC_PATH=/root/local/github/heartbeat-id774net
MONITOR=browser_spec.rb
JOBLOG=/var/log/sysadmin/rspec-monitor.log

cd $RSPEC_PATH
$RSPEC -fs $MONITOR > $JOBLOG || (nkf -w $JOBLOG | mail -s "[admin][`/bin/hostname`] RSpec failed" $ADMIN_MAIL_ADDRESS)

exit 0
