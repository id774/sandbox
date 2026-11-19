#!/bin/bash
# rspec-monitor.sh: Mail an alert when a monitoring RSpec run fails
#
# Description:
# Run browser_spec.rb in /root/local/github/heartbeat-id774net with RSpec,
# write the result to /var/log/sysadmin/rspec-monitor.log, and mail it to the
# placeholder administrator address when the run fails.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash rspec-monitor.sh
#
# Requirements:
# - Bash, nkf, and mail
# - RSpec at /opt/ruby/current/bin/rspec
# - An administrator address in place of the placeholder
#

ADMIN_MAIL_ADDRESS=xxxxxx@gmail.com
RSPEC=/opt/ruby/current/bin/rspec
RSPEC_PATH=/root/local/github/heartbeat-id774net
MONITOR=browser_spec.rb
JOBLOG=/var/log/sysadmin/rspec-monitor.log

cd $RSPEC_PATH
$RSPEC -fs $MONITOR > $JOBLOG || (nkf -w $JOBLOG | mail -s "[admin][`/bin/hostname`] RSpec failed" $ADMIN_MAIL_ADDRESS)

exit 0
