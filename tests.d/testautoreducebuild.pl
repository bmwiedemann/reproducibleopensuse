#!/usr/bin/perl
use strict;
use Test::More tests => 4;
$ENV{PATH}=".:$ENV{PATH}";

system("autoreducebuild echo constantoutput");
is($?>>8, 2, "reproducible");
system("autoreducebuild sh -c 'echo some error > /dev/stderr'");
is($?>>8, 1, "FTBFS");
system("autoreducebuild false");
is($?>>8, 1, "FTBFS");
system(q"autoreducebuild bash -c 'echo $RANDOM'");
is($?>>8, 0, "FTBR");
