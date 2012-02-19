#!/usr/bin/perl
use warnings;
use strict;

use XML::Atom::Client;
use XML::Atom::Entry;
use XML::Atom::Link;

my $url = shift;
print "\n$url\n";
print "はてなブックマーク: ";
my $summary = <STDIN>;
my $entry = XML::Atom::Entry->new;
my $link  = XML::Atom::Link->new;
$link->rel('related');
$link->type('text/html');
$link->href($url);
$entry->add_link($link);
$entry->summary($summary);

my $client = XML::Atom::Client->new;
$client->username( "" );
$client->password( "" );
my $edit_uri = $client->createEntry( "http://b.hatena.ne.jp/atom/post", $entry )
  or warn $client->errstr;
