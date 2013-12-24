package MIDI::Simple::Drummer::Rock;
our $VERSION = '0.02';
use strict;
use warnings;
use base 'MIDI::Simple::Drummer';

sub new {
    my $self = shift;
    $self->SUPER::new(
        -patch => 1, # Standard
        -power => 0,
        -room  => 0,
        @_
    );
}

# "Quater-note beat" Qn tick. Cym on 1. Kick 1&3. Snare 2&4.
sub _quarter {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. $self->beats) {
        $self->note($self->QUARTER,
            $self->rotate($beat, $args{-rotate}),
            $self->strike($args{-key_patch})
        );
    }
}

# Common eighth-note based grooves with kick syncopation.
sub _eighth {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. $self->beats) {
        # Lay-down a back-beat rhythm.
        $self->note($self->EIGHTH,
            $self->backbeat_rhythm(%args, -beat => $beat)
        );
        # Add another kick or tick if we're at the right beat.
        $self->note($self->EIGHTH,
            ((grep { $beat == $_ } @{$args{-key_beat}})
                ? ($self->kick, $self->tick) : $self->tick)
        ) if $args{-key_beat} && @{$args{-key_beat}};
    }
}

sub _default_patterns {
    my $self = shift;
    return {

1.1 => sub {
    my $self = shift;
    my %args = (-key_patch => 'Closed Hi-Hat', @_);
    $self->_quarter(%args);
},
1.2 => sub {
    my $self = shift;
    my %args = (-key_patch => 'Ride Bell', @_);
    $self->_quarter(%args);
},
1.3 => sub {
    my $self = shift;
    my %args = (-key_patch => 'Ride Cymbal 2', @_);
    $self->_quarter(%args);
},

2.1 => sub { # "Basic rock beat" en c-hh. qn k1,3. qn s2,4. Crash after fill.
    my $self = shift;
    my %args = (-key_beat => [0], @_);
    $self->_eighth(%args);
},
2.2 => sub { # "Main beat" en c-hh. qn k1,3,3&. qn s2,4.
    my $self = shift;
    my %args = (-key_beat => [3], @_);
    $self->_eighth(%args);
},
2.3 => sub { # "Syncopated beat 1" en c-hh. qn k1,3,4&. qn s2,4.
    my $self = shift;
    my %args = (-key_beat => [4], @_);
    $self->_eighth(%args);
},
2.4 => sub { # "Syncopated beat 2" en c-hh. qn k1,3,3&,4&. qn s2,4.
    my $self = shift;
    my %args = (-key_beat => [3, 4], @_);
    $self->_eighth(%args);
},

# XXX These fills all suck.
'1 fill' => sub {
    my $self = shift;
    $self->note($self->QUARTER, $self->snare) for 0 .. 1;
    $self->note($self->EIGHTH, $self->snare) for 0 .. 3;
},
'2 fill' => sub {
    my $self = shift;
    $self->note($self->EIGHTH, $self->snare) for 0 .. 1;
    $self->rest($self->EIGHTH);
    $self->note($self->EIGHTH, $self->snare);
    $self->note($self->QUARTER, $self->snare) for 0 .. 1;
},
'3 fill' => sub {
    my $self = shift;
    $self->note($self->EIGHTH, $self->snare) for 0 .. 1;
    $self->rest($self->EIGHTH);
    $self->note($self->EIGHTH, $self->snare) for 0 .. 2;
    $self->rest($self->EIGHTH);
    $self->note($self->EIGHTH, $self->snare);
},
'4 fill' => sub {
    my $self = shift;
    $self->note($self->QUARTER, $self->snare) for 0 .. 1;
    $self->note($self->SIXTEENTH, $self->snare) for 0 .. 3;
    $self->note($self->QUARTER, $self->snare);
},

    };
}

1;
__END__

=head1 NAME

MIDI::Simple::Drummer::Rock - Rock drum grooves

=head1 DESCRIPTION

This package contains a collection of common rock patterns, loaded by
L<MIDI::Simple::Drummer>.

The constructor can be provided with a specific patch number (default 1
"Standard Kit") or the arguments C<-power =E<gt> 1> or C<-room =E<gt> 1> to use
the alternate rock kits.

=head1 TO DO

Some cooler fills, Man.

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/*> and F<t/*> scripts.

=cut

