# Term::Curses

The curses library provides terminal-independent, portable manipuation
of character screens. This library provides a native-call wrapper around
the system ncurses library.

## Synopsis

    use Term::Curses;

    my $win = Term::Curses.new(:start_color);
    $win.x = 10;
    $win.y = $win.maxy / 2;
    $win.addstr("Hello, world!");
    $win.refresh;
    $win.getkey;
    $win.DESTROY();  # RAKUDO Required, not called automatically

## TODO

Most important TODO item is to not hard-code the curses library name, so
it can be used on systems other than OS X. This may require changes to
the NativeCall module, or there may be some way to do it in this code.

The next most important item is to create decent tests that can be run
without user interaction.

Then, other items:

- Handle UTF-8 input; currently it comes in one-key-per-octet
- Expose much more of the library API
- Port example programs from other curses libs
- More docs

## LICENSE

Released under the
[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

Copyright © 2012-2020 Tim Siegel `<github:softmoth>`
