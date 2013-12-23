package MIDI::Simple::Drummer::Euclidean;
our $VERSION = '0.00_01';
use strict;
use warnings;
use base 'MIDI::Simple::Drummer';

sub new {
    my $self = shift;
    $self->SUPER::new(
        -patch  => 25,
        -tr_808 => 0,
        @_
    );
    # Use the requested kit.
    if ($self->{-tr_808}) {
        $self->patch(26);
    }
}

sub _default_patterns {
    my $self = shift;
    return {

1 => \&euclid,

    };
}

sub euclid {
    my $self = shift;
    my ($m, $n) = @_;

    my $ones = 1 x $m;
    my $zeros = 0 x ($n - $m);
    
    if (@k <= 1) {
        return $m;
    }
    else {
        return euclid($n % $m, $m);
    }
};

1;
__END__

=head1 NAME

MIDI::Simple::Drummer::Euclidean - Euclidean Rhythms

=head1 DESCRIPTION

Sadly, this module is but a stub.

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/euclidean> and F<t/05-Euclidean.t> test
scripts.

L<http://student.ulb.ac.be/~ptaslaki/publications/phdThesis-Perouz.pdf>

L<http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf>

L<http://www.ageofthewheel.com/2011/03/euclidean-rhythm-midi-file-resource-in.html>

=cut

