package MIDI::Simple::Drummer::Rudiments;
our $VERSION = '0.02';
use strict;
use warnings;
use base 'MIDI::Simple::Drummer';

use constant PAN_CENTER => 63;

=head1 NAME

MIDI::Simple::Drummer::Rudiments - Drum rudiments

=head1 SYNOPSIS

  use MIDI::Simple::Drummer::Rudiments;
  my $d = MIDI::Simple::Drummer::Rudiments->new;
  $d->count_in;
  $d->beat(-name => 1) for 1 .. $d->phrases;
  $d->write('single_stroke_roll.mid');

=head1 DESCRIPTION

This package contains rudiment patterns.

Defaults are to pan full left and right for each hand, and to have no MIDI
effects.

=head1 METHODS

=cut

sub new {
    my $self = shift;
    $self->SUPER::new(
        -reverb => 1,
        -chorus => 0,
        @_,
    );
}

sub _default_patterns {
    my $self = shift;
    return {
        1  => \&single_stroke_roll,
        2  => \&single_stroke_four,
        3  => \&single_stroke_seven,
        4  => \&multiple_bounce_roll,
        5  => \&triple_stroke_roll,
        6  => \&double_stroke_open_roll,
        7  => \&five_stroke_roll,
        8  => \&six_stroke_roll,
        9  => \&seven_stroke_roll,
        10 => \&nine_stroke_roll,
        11 => \&ten_stroke_roll,
        12 => \&eleven_stroke_roll,
        13 => \&thirteen_stroke_roll,
        14 => \&fifteen_stroke_roll,
        15 => \&seventeen_stroke_roll,
        16 => \&single_paradiddle,
        17 => \&double_paradiddle,
        18 => \&triple_paradiddle,
        19 => \&paradiddle_diddle,
        20 => \&flam,
        21 => \&flam_accent,
        22 => \&flam_tap,
        23 => \&flamacue,
        24 => \&flam_paradiddle,
        25 => \&flammed_mill,
        26 => \&flam_paradiddle_diddle,
        27 => \&pataflafla,
        28 => \&swiss_army_triplet,
        29 => \&inverted_flam_tap,
        30 => \&flam_drag,
        31 => \&drag,
        32 => \&single_drag_tap,
        33 => \&double_drag_tap,
        34 => \&lesson_25_two_and_three,
        35 => \&single_dragadiddle,
        36 => \&drag_paradiddle_1,
        37 => \&drag_paradiddle_2,
        38 => \&single_ratamacue,
        39 => \&double_ratamacue,
        40 => \&triple_ratamacue,
    };
};

sub _groups_of {
    my ($beat, $group) = @_;
    return ($beat - 1) % $group;
}

=head2 I. Roll Rudiments

=head3 A. Single Stroke Rudiments

1. Single Stroke Roll

=cut

sub single_stroke_roll {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 8) {
        $self->alternate_pan($beat % 2, $args{pan_width});
        $self->note($self->THIRTYSECOND, $self->strike);
    }
}

=pod

2. Single Stroke Four

=cut

sub single_stroke_four {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 8) {
        $self->alternate_pan($beat % 2, $args{pan_width});
        if ($beat == 4 || $beat == 8) {
            $self->note($self->EIGHTH, $self->strike);
        }
        else {
            $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
        }
    }
}

=pod

3. Single Stroke Seven

=cut

sub single_stroke_seven {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 7) {
        $self->alternate_pan($beat % 2, $args{pan_width});
        if ($beat == 7) {
            $self->note($self->EIGHTH, $self->strike);
        }
        else {
            $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
        }
    }
}

=head3 B. Multiple Bounce Rudiments

4. Multiple Bounce Roll

TODO: Not yet implemented...

=cut

sub multiple_bounce_roll {
    my $self = shift;
    # TODO Set $multiple and then do a multi-stroke below.
    # TODO Set a random $multiple each X number of times.
}

=pod

5. Triple Stroke Roll

=cut

sub triple_stroke_roll {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 12) {
        # Pan after groups of three.
        $self->alternate_pan(_groups_of($beat, 3), $args{pan_width});
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
}

=pod

=head3 C. Double Stroke Rudiments

6. Double Stroke Open Roll (Long Roll)

=cut

sub double_stroke_open_roll {
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 8) {
        # Pan after groups of two.
        $self->alternate_pan(_groups_of($beat, 2), $args{pan_width});
        $self->note($self->THIRTYSECOND, $self->strike);
    }
}

=pod

7. Five Stroke Roll

=cut

sub five_stroke_roll {
    my $self = shift;
    for my $beat (1 .. 12) {
    }
}

=pod

8. Six Stroke Roll

=cut

sub six_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

9. Seven Stroke Roll

=cut

sub seven_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

10. Nine Stroke Roll

=cut

sub nine_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

11. Ten Stroke Roll

=cut

sub ten_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

12. Eleven Stroke Roll

=cut

sub eleven_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

13. Thirteen Stroke Roll

=cut

sub thirteen_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

14. Fifteen Stroke Roll

=cut

sub fifteen_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

15. Seventeen Stroke Roll

=cut

sub seventeen_stroke_roll {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

=head2 II. Diddle Rudiments

16. Single Paradiddle

=cut

sub single_paradiddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

17. Double Paradiddle

=cut

sub double_paradiddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

18. Triple Paradiddle

=cut

sub triple_paradiddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

19. Paradiddle-Diddle

=cut

sub paradiddle_diddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

=head2 III. Flam Rudiments

20. Flam

=cut

sub flam {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

21. Flam Accent

=cut

sub flam_accent {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

22. Flam Tap

=cut

sub flam_tap {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

23. Flamacue

=cut

sub flamacue {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

24. Flam Paradiddle

=cut

sub flam_paradiddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

25. Flammed Mill

=cut

sub flammed_mill {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

26. Flam Paradiddle-Diddle

=cut

sub flam_paradiddle_diddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

27. Pataflafla

=cut

sub pataflafla {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

28. Swiss Army Triplet

=cut

sub swiss_army_triplet {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

29. Inverted Flam Tap

=cut

sub inverted_flam_tap {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

30. Flam Drag

=cut

sub flam_drag {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=head2 IV. Drag Rudiments

31. Drag (Half Drag or Ruff)

=cut

sub drag {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

32. Single Drag Tap

=cut

sub single_drag_tap {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

33. Double Drag Tap

=cut

sub double_drag_tap {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

34. Lesson 25 (Two and Three)

=cut

sub lesson_25_two_and_three {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

35. Single Dragadiddle

=cut

sub single_dragadiddle {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

36. Drag Paradiddle #1

=cut

sub drag_paradiddle_1 {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

37. Drag Paradiddle #2

=cut

sub drag_paradiddle_2 {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

38. Single Ratamacue

=cut

sub single_ratamacue {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

39. Double Ratamacue

=cut

sub double_ratamacue {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=pod

40. Triple Ratamacue

=cut

sub triple_ratamacue {
    my $self = shift;
    for my $beat (1 .. $self->beats) {
    }
}

=head2 pan_left() pan_center() pan_right()

 $d->pan_left($width);
 $d->pan_center();
 $d->pan_right($width);

Convenience methods to pan in different directions.

=cut

sub pan_left {
    my ($self, $width) = @_;
    $self->pan(PAN_CENTER - $width);
}
sub pan_center {
    my ($self, $width) = @_;
    $self->pan(PAN_CENTER);
}
sub pan_right {
    my ($self, $width) = @_;
    $self->pan(PAN_CENTER + $width);
}


=head2 alternate_pan()

 $d->alternate_pan();
 $d->alternate_pan($direction);
 $d->alternate_pan($direction, $width);

Pan the stereo balance by an amount.

The pan B<direction> is B<0> for left (the default) and B<1> for right.

The B<width> can be any integer between B<1> and B<64> (the default).
A B<width> of B<64> means "stereo pan 100% left/right."

=cut

sub alternate_pan {
    my ($self, $pan, $width) = @_;
    # Pan hard left if not given.
    $pan = 0 unless defined $pan;
    # Set balance to 100% if necessary.
    $width = PAN_CENTER + 1 unless defined $width;
    # Pan the stereo balance.
    $self->pan( $pan ? abs($width - PAN_CENTER) : PAN_CENTER + $width );
    # Return the pan dimensions.
    return $pan, $width;
}

1;
__END__

=head1 TO DO

Tempo increase-decrease

With and without metronome

Straight or swing time

Duple or triple application (for 5 & 7 stroke rolls)

Touch velocity

=head1 SEE ALSO

L<MIDI::Simple::Drummer>, the F<eg/> and F<t/> test scripts.

L<http://en.wikipedia.org/wiki/Drum_rudiment>

L<http://www.vicfirth.com/education/rudiments.php>

L<http://www.drumrudiments.com/>

=cut

