package MIDI::Simple::Drummer::Euclidean;
use strict;
use warnings;
use parent 'MIDI::Simple::Drummer';
our $VERSION = '0.01';

sub new {
    my $self = shift;
    $self->SUPER::new(
        -patch  => 25,
        -tr_808 => 0,
        @_
    );
}

sub _default_patterns {
    my $self = shift;
    return {
    };
}

sub euclid {
    my $self = shift;
    my ($m, $n) = @_;

    # Onsets per measure
    $m ||= 3;
    # Beats per measure
    $n ||= $self->beats;

    # Line is from x=0, y=1 to x=$BPM, y=$mod+1
    # Then from that, for each $y from # 1..$mod
    # figure out the x value to see where beat would be.

    my $intercept = 1;

    # y = mx + b; b is 1 as we're drawing the intercept through that point,
    # and then (y2-y1)/(x2-x1) reduces to just:
    my $slope = $m / $n;

    my @onsets = ('.') x $n;
    for my $y ( 1 .. $m ) {
        # solve x = (y-b)/m rounding nearest and put the beat there
        $onsets[ sprintf "%.0f", ( $y - $intercept ) / $slope ] = 'x';
    }

    return \@onsets;
};

1;
__END__

=head1 NAME

MIDI::Simple::Drummer::Euclidean - Euclidean Rhythms

=head1 DESCRIPTION

Sadly, this module is but a stub.

=head1 METHODS

=head2 euclid()

Thinking out loud. Work in progress...

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/*> and F<t/*> scripts.

L<http://student.ulb.ac.be/~ptaslaki/publications/phdThesis-Perouz.pdf>

L<http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf>

L<http://www.ageofthewheel.com/2011/03/euclidean-rhythm-midi-file-resource-in.html>

=cut

