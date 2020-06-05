# Term::Curses

The curses library provides terminal-independent, portable manipulation of
character screens. This Raku module provides a NativeCall wrapper around
the system ncurses library.

## Synopsis

```raku
use Term::Curses;

my $win = Term::Curses.new(:start_color);
END $win.endwin();
$win.x = 10;
$win.y = $win.maxy / 2;
$win.addstr("Hello, world!");
$win.refresh;
$win.getkey;
```

## TODO

- Handle UTF-8 input; currently it comes in one-key-per-octet
- Use the wide-character functions consistently
- Work out a decent API
- Port example programs from other curses libs
- Proper tests
- Expose much more of the curses library
- Expose menu, forms, and panel features
- More docs

## LICENSE

Released under the
[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

Copyright © 2012-2020 Tim Siegel `<github:softmoth>`
