#!/usr/bin/perl

use strict;
use warnings;
use Cwd qw();

my ($dirname) = @ARGV;

if (not defined $dirname) {
  $dirname = Cwd::cwd();
    print "Using default: $dirname\n"
}
opendir my $dir, $dirname or die "Cannot open directory: $!";
my @files = readdir $dir or die "Cannot read directory: $!";
@files = sort @files;
foreach my $file (@files) {
  print "$file\n";
}
closedir $dir;
