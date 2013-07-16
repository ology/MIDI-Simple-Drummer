package MIDI::Simple::Drummer::Euclidean;
our $VERSION = '0.0100';
use strict;
use warnings;
use base 'MIDI::Simple::Drummer';

sub _setup {
    my $self = shift;
    $self->SUPER::_setup(@_);
}

sub _default_patterns {
    my $self = shift;
    return {

1 => sub { my $self = shift; }, # TBD...

    };
}

1;
__END__

=head1 NAME

MIDI::Simple::Drummer::Euclidean - Euclidean Rhythms

=head1 DESCRIPTION

This package contains a collection of Euclidean based patterns that are loaded
by L<MIDI::Simple::Drummer>.

Additionally, the methods below are available.

=head1 METHODS

=head2 foo()

Foo!

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/euclidean> and F<t/05-Euclidean.t> test
scripts.

=cut

