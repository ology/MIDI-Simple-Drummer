package MIDI::Simple::Drummer::Euclidean;
use strict;
use warnings;
use parent 'MIDI::Simple::Drummer';

sub new {
    my $self = shift;
    $self->SUPER::new(
        -onsets => 4,
        -patch  => 25,
        -rhythm => undef,
        -pad    => 'kick',
        @_
    );
}

sub _default_patterns {
    my $self = shift;
    return {

1 => sub {
    my $self = shift;
    my $rhythm = $self->{-rhythm}
        ? $self->{-rhythm}
        : $self->euclid($self->{-onsets}, $self->beats);
    for my $i ( @$rhythm ) {
        if ( $i eq 'x' ) {
            my $pad = $self->{-pad};
            my $note = $self->$pad || $self->snare;
            $self->note($self->EIGHTH, $note );
        }
        else {
            $self->rest($self->EIGHTH);
        }
    }
}

    };
}

sub euclid {
    my $self = shift;
    my ($p, $q) = @_;

    # Onsets per measure
    $p ||= $self->{-onsets};
    # Beats per measure
    $q ||= $self->beats;

    # Line is from x=0, y=1 to x=$BPM, y=$mod+1
    # Then from that, for each $y from # 1..$mod
    # figure out the x value to see where beat would be.

    my $intercept = 1;

    # y = mx + b; b is 1 as we're drawing the intercept through that point,
    # and then (y2-y1)/(x2-x1) reduces to just:
    my $slope = $p / $q;

    my @onsets = ('.') x $q;

    for my $y ( 1 .. $p ) {
        # solve x = (y-b)/m rounding nearest and put the beat there
        $onsets[ sprintf "%.0f", ( $y - $intercept ) / $slope ] = 'x';
    }

    return \@onsets;
};

sub rotate {
    my $self = shift;
    my $phrase = shift;

    my $done = 0;
    while ( $done == 0 ) {
        my $i = shift @$phrase;
        push @$phrase, $i;
        $done++ if $phrase->[0] eq 'x';
    }

    return $phrase;
}

1;
__END__

=head1 DESCRIPTION

Generate Euclidean rhythms and "world beat" grooves.

=head1 METHODS

=head2 euclid

Return a list of B<x> onsets or B<.> rests given the C<onsets> and C<beats>.

=head2 rotate

Rotate the given list of onsets and rests to the next (to the right) onset.

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/*> and F<t/*> scripts.

L<http://student.ulb.ac.be/~ptaslaki/publications/phdThesis-Perouz.pdf>

L<http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf>

L<http://www.ageofthewheel.com/2011/03/euclidean-rhythm-midi-file-resource-in.html>

=cut

