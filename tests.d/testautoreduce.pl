#!/usr/bin/perl
use strict;
use Test::More tests => 7;
$ENV{PATH}=".:$ENV{PATH}";
our $allcontent="line1\nline2\nline3\nline4\n";

sub runone(@)
{
    my $file="tests.d/autoreduceinput";
    open(my $fd, ">", $file) or die;
    print $fd $allcontent;
    close $fd;
    system("autoreduce", $file, @_);
    die unless $? == 0;
    my $out=`cat $file`;
    die unless $? == 0;
    #unlink $file;
    return substr($out, 0, 32);
}
is(runone("false"), $allcontent, "all fail");
is(runone("bash -c 'exit 2'"), $allcontent, "all reproducible");
is(runone("true"), "", "all unreproducible");
is(runone('bash -c "grep -q line1 tests.d/autoreduceinput"'), "line1\n", "1 unreproducible");
is(runone('bash -c "grep -q line2 tests.d/autoreduceinput"'), "line2\n", "2 unreproducible");
is(runone('bash -c "grep -q line4 tests.d/autoreduceinput"'), "line4\n", "4 unreproducible");
is(runone('bash -c "grep -q line2 tests.d/autoreduceinput && grep -q line4 tests.d/autoreduceinput"'), "line2\nline4\n", "2+4 unreproducible");
