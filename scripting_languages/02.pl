#!/usr/bin/perl

use strict;
use warnings;
use Time::Local qw( timegm );

sub convert
{
    my $date_str = shift;

    if (!($date_str =~ /.*T(\d{2})(\d{2}).*/)) {
        die "Format not recognized: $date_str\n"
    }
    return timegm(0, $2, $1, 1, 1, 2010);
}

my $teaching_hours = 0;
my $in_event = 0;
my $evt_start_time;
while (<>) {
    chomp;
    if ($_ =~ /BEGIN:VEVENT.*/) {
        $in_event = 1;
    } elsif ($_ =~ /END:VEVENT.*/) {
        $in_event = 0;
    } elsif ($_ =~ /DTSTART.*:(.*)/ and $in_event eq 1) {
        $evt_start_time = convert($1);
    } elsif ($_ =~ /DTEND.*:(.*)/ and $in_event eq 1) {
        $teaching_hours += (convert($1) - $evt_start_time) / (45 * 60);
    }
}
print "Teaching hours: $teaching_hours\n";
