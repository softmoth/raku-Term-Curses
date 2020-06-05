#! /usr/bin/env raku

use Term::Curses;

my $win = Term::Curses.new;
END $win.endwin;

messAroundABit($win, :count(5));

loop {
    $win.y = 0;
    $win.x = 0;
    my $k = $win.getkey;
    $win.clrtoeol;
    $win.addstr("Key: '$k'");
    $win.refresh;

    last if $k.lc eq 'q';
}

$win.endwin;

exit(0);

sub messAroundABit($win, :$count = 5, :$delay = 0.1) {
    $win.y = 0;

    for ^$count {
        $win.x = 8;
        $win.y += 2;
        $win.addstr("¿'あ' works?");
        $win.refresh();
        sleep(0.1);
    }

    my ($save_y, $save_x) = $win.y, $win.x;

    ++$win.y;
    $win.x = 0;
    $win.addstr("012345678|012345678|012345678|  I finished at: y: {$save_y}, x: {$save_x}");
    ++$win.y;
    $win.x = 0;
    $win.addstr("Max is y: {$win.maxy}, x: {$win.maxx}");
    ++$win.y;
    $win.x = 0;
    $win.refresh();
}

# vim:set ft=raku
