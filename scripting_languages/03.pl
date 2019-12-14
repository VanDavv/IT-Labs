#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(first);

sub get_indexes_from_header {
    my $header = shift;
    my @headers;
    while ($header =~ /<th.*?>(.*?)<\/th>/g) {
        push @headers, $1;
    }

    my $name_index = first { $headers[$_] eq 'NAME' } 0..$#headers;
    my $score_index = first { $headers[$_] eq 'SCORE' } 0..$#headers;
    return ($name_index, $score_index);
}

sub get_values_from_row {
    (my $line, my $name_index, my $score_index) = (@_);

    my @values;
    while ($line =~ /<td.*?>(.*?)<\/td>/g) {
        push @values, $1;
    }
    (my $name, my $score) = ($values[$name_index], $values[$score_index]);
    while ($name =~ /<a.*?>(.*?)<\/a>/g) {
        $name = $1;
    }
    return ($name, $score);
}

while (<>) {
    chomp;
    if ($_ =~ /^<tbody>/) {
        my @rows;
        while ($_ =~ /<tr.*?>(.*?)<\/tr>/g) {
            push @rows, $1;
        }
        my $header = shift @rows;
        (my $name_index, my $score_index) = get_indexes_from_header($header);

        foreach my $row (@rows) {
            (my $name, my $score) = get_values_from_row($row, $name_index, $score_index);
            print "\"$name\",\"$score\"\n";
        }
    }
}
