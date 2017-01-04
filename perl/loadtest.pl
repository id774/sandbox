#!/usr/bin/perl

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
