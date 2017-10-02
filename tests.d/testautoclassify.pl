#!/usr/bin/perl
use strict;
use Test::More tests => 5;
$ENV{PATH}="tests.d/bin:$ENV{PATH}";

sub test1($$)
{
    my($pkg, $expected)=@_;
    $ENV{PKG}=$pkg;
    my $out = `autoclassify`;
    like($out, "/classified as $expected/", "test classifying $pkg package");
}

test1("0bit", "0 0 0 0 0 0 0 0 0 0");
test1("1bit", "0 0 1 0 0 0 0 0 0 0");
test1("3bit", "1 0 1 0 0 0 0 1 0 0");
test1("nonbuilding", "1 1 1 1 1 1 1 1 1 1 99"); # FIXME
test1("unreproducible", "1 1 1 1 1 1 1 1 1 1 99");
