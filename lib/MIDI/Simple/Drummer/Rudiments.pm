package MIDI::Simple::Drummer::Rudiments;
our $VERSION = '0.02';
use strict;
use warnings;
use base 'MIDI::Simple::Drummer';

use constant PAN_CENTER => 64;

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

=head2 new()

Sets pan_width to 1/4 distance from center.
Sets the reverb effect to 1 and chorus to 0.

=cut

sub new {
    my $self = shift;
    $self->SUPER::new(
        -pan_width => 32, # [ 0 .. 64 ] # From center
        -chorus    => 0,
        -reverb    => 1,
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

=head1 I. Roll Rudiments

=head2 single_stroke_roll()

1. Single Stroke Roll

=cut

sub single_stroke_roll { # 1
    my $self = shift;
    for my $beat (1 .. 8) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->THIRTYSECOND, $self->strike);
    }
}

=head2 single_stroke_four()

2. Single Stroke Four

=cut

sub single_stroke_four { # 2
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 8) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        if ($beat == 4 || $beat == 8) {
            $self->score('V'.$self->accent); # Accent!
            $self->note($self->EIGHTH, $self->strike);
            $self->score('V'.$self->volume); # Reset the note volume.
        }
        else {
            $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
        }
    }
}

=head2 single_stroke_seven()

3. Single Stroke Seven

=cut

sub single_stroke_seven { # 3
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 7) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        if ($beat == 7) {
            $self->score('V'.$self->accent); # Accent!
            $self->note($self->EIGHTH, $self->strike);
            $self->score('V'.$self->volume); # Reset the note volume.
        }
        else {
            $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
        }
    }
}

=head1 B. Multiple Bounce Rudiments

=head2 multiple_bounce_roll()

TODO: Not yet implemented...

=cut

sub multiple_bounce_roll { # 4
    my $self = shift;
    # TODO Set $multiple and then do a multi-stroke below.
    # TODO Set a random $multiple each X number of times.
}

=head2 triple_stroke_roll()

5. Triple Stroke Roll

=cut

sub triple_stroke_roll { # 5
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 12) {
        # Pan after groups of three.
        $self->alternate_pan(_groups_of($beat, 3), $self->pan_width);
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
}

=head2 double_stroke_open_roll()

6. Double Stroke Open Roll (Long Roll)

=cut

sub double_stroke_open_roll { # 6
    my $self = shift;
    my %args = @_;
    for my $beat (1 .. 8) {
        # Pan after groups of two.
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->THIRTYSECOND, $self->strike);
    }
}

=head2 five_stroke_roll()

7. Five Stroke Roll

=cut

sub five_stroke_roll { # 7
    my $self = shift;
    # Start on left.
    for my $beat (0 .. 3) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->THIRTYSECOND, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);

    # Start on right.
    for my $beat (1 .. 4) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->THIRTYSECOND, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);
}

=head2 six_stroke_roll()

8. Six Stroke Roll

=cut

sub six_stroke_roll { # 8
    my $self = shift;
    # Start on left.
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
    for my $beat (0 .. 3) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # Start on right.
    $self->accent_note($self->EIGHTH);
    for my $beat (1 .. 4) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 seven_stroke_roll()

9. Seven Stroke Roll

=cut

sub seven_stroke_roll { # 9
    my $self = shift;
    # 3 diddles
    for my $beat (0 .. 5) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 3 diddles
    for my $beat (1 .. 6) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 nine_stroke_roll()

10. Nine Stroke Roll

=cut

sub nine_stroke_roll { # 10
    my $self = shift;
    # 4 diddles
    for my $beat (0 .. 7) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 4 diddles
    for my $beat (1 .. 8) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 ten_stroke_roll()

11. Ten Stroke Roll

=cut

sub ten_stroke_roll { # 11
    my $self = shift;
    # 4 diddles
    for my $beat (0 .. 7) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);
    $self->pan_left;
    $self->accent_note($self->EIGHTH);

    # 4 diddles
    for my $beat (1 .. 8) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
    $self->pan_right;
    $self->accent_note($self->EIGHTH);
}

=head2 eleven_stroke_roll()

12. Eleven Stroke Roll

=cut

sub eleven_stroke_roll { # 12
    my $self = shift;
    # 5 diddles
    for my $beat (0 .. 9) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 5 diddles
    for my $beat (1 .. 10) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 thirteen_stroke_roll()

13. Thirteen Stroke Roll

=cut

sub thirteen_stroke_roll { # 13
    my $self = shift;
    # 6 diddles
    for my $beat (0 .. 11) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 6 diddles
    for my $beat (1 .. 12) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->TRIPLET_SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 fifteen_stroke_roll()

14. Fifteen Stroke Roll

=cut

sub fifteen_stroke_roll { # 14
    my $self = shift;
    # 7 diddles
    for my $beat (0 .. 13) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 7 diddles
    for my $beat (1 .. 14) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head2 seventeen_stroke_roll()

15. Seventeen Stroke Roll

=cut

sub seventeen_stroke_roll { # 15
    my $self = shift;
    # 8 diddles
    for my $beat (0 .. 15) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_right;
    $self->accent_note($self->EIGHTH);

    # 8 diddles
    for my $beat (1 .. 16) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
}

=head1 II. Diddle Rudiments

=head2 single_paradiddle()

16. Single Paradiddle

=cut

sub single_paradiddle {
    my $self = shift;
    # 2 single strokes left
    for my $beat (0 .. 1) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (0 .. 1) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }

    # 2 single strokes right
    for my $beat (1 .. 2) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (1 .. 2) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
}

=head2 double_paradiddle()

17. Double Paradiddle

=cut

sub double_paradiddle {
    my $self = shift;
    # 4 single strokes starting left
    for my $beat (0 .. 3) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (0 .. 1) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }

    # 2 single strokes right
    for my $beat (1 .. 4) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (1 .. 2) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
}

=head2 triple_paradiddle()

18. Triple Paradiddle

=cut

sub triple_paradiddle {
    my $self = shift;
    # 6 single strokes starting left
    for my $beat (0 .. 5) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (0 .. 1) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }

    # 2 single strokes right
    for my $beat (1 .. 6) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (1 .. 2) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
}

=head2 paradiddle_diddle()

19. Paradiddle-Diddle

=cut

sub paradiddle_diddle {
    my $self = shift;
    # 2 single strokes starting left
    for my $beat (0 .. 1) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 2 diddles
    for my $beat (0 .. 3) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }

    # 2 single strokes right
    for my $beat (1 .. 2) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
    # 1 diddle
    for my $beat (1 .. 4) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
}

=head1 III. Flam Rudiments

=head2 flam()

20. Flam

=cut

sub flam {
    my $self = shift;

    $self->pan_left;
    $self->score('V' . $self->duck); # Duck!
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->score('V' . $self->volume); # Reset the note volume.
    $self->pan_right;
    $self->note($self->EIGHTH, $self->strike);

    $self->pan_right;
    $self->score('V' . $self->duck); # Duck!
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->score('V' . $self->volume); # Reset the note volume.
    $self->pan_left;
    $self->note($self->EIGHTH, $self->strike);
}

=head2 flam_accent()

21. Flam Accent

=cut

sub flam_accent {
    my $self = shift;

    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->accent_note($self->EIGHTH);
    # 2 single strokes.
    for my $beat (0 .. 1) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->EIGHTH, $self->strike);
    }

    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    $self->accent_note($self->EIGHTH);
    # 2 single strokes.
    for my $beat (1 .. 2) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->EIGHTH, $self->strike);
    }
}

=head2 flam_tap()

22. Flam Tap

=cut

sub flam_tap {
    my $self = shift;

    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    # 1 diddle
    $self->accent_note($self->SIXTEENTH);
    $self->note($self->SIXTEENTH, $self->strike);

    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    # 1 diddle
    $self->accent_note($self->EIGHTH);
    $self->note($self->SIXTEENTH, $self->strike);
}

=head2 flamacue()

23. Flamacue

=cut

sub flamacue {
    my $self = shift;

    # Flam
    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_left;
    $self->accent_note($self->SIXTEENTH);
    # 2 single strokes.
    for my $beat (0 .. 1) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->EIGHTH, $self->strike);
    }
    # Flam
    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);

    # Flam
    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_right;
    $self->accent_note($self->SIXTEENTH);
    # 2 single strokes.
    for my $beat (1 .. 2) {
        $self->alternate_pan($beat % 2, $self->pan_width);
        $self->note($self->EIGHTH, $self->strike);
    }
    # Flam
    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);

}

=head2 flam_paradiddle()

24. Flam Paradiddle

=cut

sub flam_paradiddle {
    my $self = shift;

    # Flam
    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->accent_note($self->SIXTEENTH);
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);
    # 1 diddle
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->note($self->SIXTEENTH, $self->strike);

    # Flam
    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    $self->accent_note($self->SIXTEENTH);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);
    # 1 diddle
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->note($self->SIXTEENTH, $self->strike);

}

=head2 flammed_mill()

25. Flammed Mill

=cut

sub flammed_mill {
    my $self = shift;

    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->accent_note($self->SIXTEENTH);
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);

    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    $self->accent_note($self->SIXTEENTH);
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);

}

=head2 flam_paradiddle_diddle()

26. Flam Paradiddle-Diddle

=cut

sub flam_paradiddle_diddle {
    my $self = shift;

    $self->pan_left;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_right;
    $self->accent_note($self->SIXTEENTH);
    $self->pan_left;
    $self->note($self->SIXTEENTH, $self->strike);
    # 2 diddles
    for my $beat (0 .. 3) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }

    $self->pan_right;
    $self->note($self->THIRTYSECOND, $self->strike);
    $self->pan_left;
    $self->accent_note($self->SIXTEENTH);
    $self->pan_right;
    $self->note($self->SIXTEENTH, $self->strike);
    # 2 diddles
    for my $beat (1 .. 4) {
        $self->alternate_pan(_groups_of($beat, 2), $self->pan_width);
        $self->note($self->SIXTEENTH, $self->strike);
    }
}

=head2 pataflafla()

27. Pataflafla * Not yet implemented

=cut

sub pataflafla {
    my $self = shift;
}

=head2 swiss_army_triplet()

28. Swiss Army Triplet * Not yet implemented

=cut

sub swiss_army_triplet {
    my $self = shift;
}

=head2 inverted_flam_tap()

29. Inverted Flam Tap * Not yet implemented

=cut

sub inverted_flam_tap {
    my $self = shift;
}

=head2 flam_drag()

30. Flam Drag * Not yet implemented

=cut

sub flam_drag {
    my $self = shift;
}

=head1 IV. Drag Rudiments

=head2 drag()

31. Drag (Half Drag or Ruff) * Not yet implemented

=cut

sub drag {
    my $self = shift;
}

=head2 single_drag_tap()

32. Single Drag Tap * Not yet implemented

=cut

sub single_drag_tap {
    my $self = shift;
}

=head2 double_drag_tap()

33. Double Drag Tap * Not yet implemented

=cut

sub double_drag_tap {
    my $self = shift;
}

=head2 lesson_25_two_and_three()

34. Lesson 25 (Two and Three) * Not yet implemented

=cut

sub lesson_25_two_and_three {
    my $self = shift;
}

=head2 single_dragadiddle()

35. Single Dragadiddle * Not yet implemented

=cut

sub single_dragadiddle {
    my $self = shift;
}

=head2 drag_paradiddle_1()

36. Drag Paradiddle #1 * Not yet implemented

=cut

sub drag_paradiddle_1 {
    my $self = shift;
}

=head2 drag_paradiddle_2()

37. Drag Paradiddle #2 * Not yet implemented

=cut

sub drag_paradiddle_2 {
    my $self = shift;
}

=head2 single_ratamacue()

38. Single Ratamacue * Not yet implemented

=cut

sub single_ratamacue {
    my $self = shift;
}

=head2 double_ratamacue()

39. Double Ratamacue * Not yet implemented

=cut

sub double_ratamacue {
    my $self = shift;
}

=head2 triple_ratamacue()

40. Triple Ratamacue * Not yet implemented

=cut

sub triple_ratamacue {
    my $self = shift;
}

=head2 pan_left(), pan_center(), pan_right()

 $d->pan_left($width);
 $d->pan_center();
 $d->pan_right($width);

Convenience methods to pan in different directions.

=cut

sub pan_left {
    my $self = shift;
    $self->pan(PAN_CENTER - $self->pan_width);
}
sub pan_center {
    my $self = shift;
    $self->pan(PAN_CENTER);
}
sub pan_right {
    my $self = shift;
    $self->pan(PAN_CENTER + $self->pan_width);
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

    # Set balance to center unless a width is given.
    $width = PAN_CENTER unless defined $width;

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

L<MIDI::Simple::Drummer>, the F<eg/*> and F<t/*> scripts.

L<http://en.wikipedia.org/wiki/Drum_rudiment>

L<http://www.vicfirth.com/education/rudiments.php>

L<http://www.drumrudiments.com/>

=cut

