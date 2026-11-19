#!/usr/bin/perl
# loadtest.pl: Generate CPU load with forked busy loops
#
# Description:
# Generate load by forking the requested number of busy looping processes, one
# by default.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     perl loadtest.pl [processes]
#
# Requirements:
# - Perl on a platform that supports fork
#

my $nprocs = $ARGV[0] || 1;
for( my $i=0; $i<$nprocs; $i++ ){
    my $pid = fork;
    die $! if( $pid < 0 );
    if( $pid == 0 ){
        while(1){
            if( $ARGV[1] ){
                open(IN, ">/dev/null");
                close(IN);
            }
        }
    }
}
wait
