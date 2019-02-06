#!/usr/bin/perl -w
use strict;
use JSON::XS;
use POSIX qw(strftime);

sub processfile
{
    my $json = shift;
    my %status;
    foreach my $pkg (@$json) {
        my $s = $pkg->{status};
        $status{$s}++;
    }
    return \%status;
}

sub dumpstatus(@)
{
    my @headers=(qw(datum reproducible FTBR FTBFS other));
    print join(",",@headers)."\n";
    @headers = map {s/datum/mtime/; s/FTBR/unreproducible/; $_} @headers;
    foreach my $line (@_) {
        #foreach(sort(keys(%$line))) { print "$_ $line->{$_} " } # raw stat dump
        my @line;
        foreach(@headers) {
            my $v = $line->{$_}||0;
            if($_ eq "mtime") { $v = strftime("%Y-%m-%d", gmtime($v)) }
            if($_ eq "other") { $v = ($line->{nobinaries}||0) + ($line->{waitdep}||0) } # ignoring notforus (other arch)
            push(@line, $v);
        }
        print join(",", @line),"\n"; # CSV out
    }
}

my @files = @ARGV;
my @status;

foreach my $f (@files) {
    open(my $fd, "<", $f) or die "error opening $f: $!";
    my $json;
    { local $/ ; $json = <$fd>; }
    close $fd;
    my $s = processfile(decode_json($json));
    $s->{mtime} = (stat($f))[9];
    push(@status, $s);
}
dumpstatus(@status);
