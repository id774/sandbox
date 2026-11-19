#!/usr/bin/perl
# hbc.pl: Post a URL to Hatena Bookmark with a comment
#
# Description:
# Post the URL given as an argument to Hatena Bookmark with a comment read
# from standard input through the AtomPub API. The user name and password in
# the source are empty placeholders.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     echo <comment> | perl hbc.pl <URL>
#
# Requirements:
# - Perl with XML::Atom
# - A Hatena account filled in for the placeholders and network access to
#   b.hatena.ne.jp
#

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
