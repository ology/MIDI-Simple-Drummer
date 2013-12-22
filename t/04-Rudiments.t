#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

BEGIN { use_ok('MIDI::Simple::Drummer::Rudiments') }

my $d = eval {
    MIDI::Simple::Drummer::Rudiments->new(
        -bpm => 60,
        -phrases => 1,
    )
};
isa_ok $d, 'MIDI::Simple::Drummer::Rudiments';
ok !$@, 'created with no arguments';
my $x = $d->patterns(0);
is $x, undef, 'unknown pattern is undef';

# TODO $d->dump_score tests.

# Execute rudiments.
for my $name (6 .. 6) {
    $d->beat(-name => $name) for 1 .. $d->phrases;
}

# Write to file.
my $f = 'Rudiments.mid';
$x = $d->write($f);
#ok $x eq $f && -e $x, "named write of $f";
#unlink $x;
#ok !-e $x, "removed $f";

done_testing();
