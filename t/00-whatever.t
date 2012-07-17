#! /usr/bin/env perl6

use v6;

use Term::Curses;

my $win = Term::Curses.new;

messAroundABit($win, :count(5));

while ((my $k = $win.getkey()) ne 'q') {
    $win.x = $win.y = 1;
    $win.clrtoeol;
    $win.addstr("Key: '$k'");
    $win.refresh;
}

$win.DESTROY();

note "Done.";

exit(0);


sub messAroundABit($win, :$count = 5, :$delay = 0.1) {
    $win.x = $win.y = 10;

    for ^$count {
        $win.y += 2;
        $win.addstr("¿Dis work?");
        $win.refresh();
        sleep(0.05);
    }

    my ($save_y, $save_x) = $win.y, $win.x;

    ++$win.y;
    $win.x = 0;
    $win.addstr("I finished at: y: {$save_y}, x: {$save_x}");
    ++$win.y;
    $win.x = 0;
    $win.addstr("Max is y: {$win.maxy}, x: {$win.maxx}");
    ++$win.y;
    $win.x = 0;
    $win.refresh();
}

# vim:set ft=perl6:
