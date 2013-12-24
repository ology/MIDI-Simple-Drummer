#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok('MIDI::Simple::Drummer::Euclidean') }

__END__
# Not Yet Ready for Prime Time:
my $d = eval { MIDI::Simple::Drummer::Euclidean->new };
isa_ok $d, 'MIDI::Simple::Drummer::Euclidean';
ok !$@, 'created with no arguments';

my $x = $d->patterns(0);
is $x, undef, 'get unknown pattern is undef';
my $y = sub { $d->note($d->EIGHTH, $d->strike) };
$x = $d->patterns('y', $y);
is_deeply $x, $y, 'set y pattern';
$x = $d->patterns('y fill', $y);
is_deeply $x, $y, 'set y fill pattern';

$x = $d->write('Euclidean-Drummer.mid');
ok $x eq 'Euclidean-Drummer.mid' && -e $x, 'named write';
#unlink $x;
#ok !-e $x, 'removed';

done_testing();
