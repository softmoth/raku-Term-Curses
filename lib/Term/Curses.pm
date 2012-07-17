class Term::Curses {
    use Term::Curses::Raw;

    has $!stdscr;

    submethod BUILD(
        :$cbreak = True,
        :$echo = False,
        :$nl = False,
        :$intrflush = False,
        :$keypad = True,
        :$use_default_colors = True,
        :$start_color = True
    ) {
        setlocale(0, "");

        # TODO: use newterm() instead of initscr()?
        $!stdscr = initscr();

        cbreak() if $cbreak;
        noecho() unless $echo;
        nonl() unless $nl;
        intrflush($!stdscr, 0) unless $intrflush;
        keypad($!stdscr, 1) if $keypad;

        if ($start_color and has_colors()) {
            use_default_colors() if $use_default_colors;
            start_color();
        }
    }

    # RAKUDO: NYI, DESTROY() must be called manually for now
    method DESTROY() {
        endwin();
    }

    method refresh() { wrefresh($!stdscr) }
    method erase() { werase($!stdscr) }
    method clear() { wclear($!stdscr) }
    method clrtobot() { wclrtobot($!stdscr) }
    method clrtoeol() { wclrtoeol($!stdscr) }
    method getch() { wgetch($!stdscr); }
    method addstr($str) { waddstr($!stdscr, $str) }
    method addnstr($str, $len) { waddnstr($!stdscr, $str, $len) }
    method maxy() { getmaxy($!stdscr) }
    method maxx() { getmaxx($!stdscr) }

    method getkey() {
        my $c = $.getch;
        if ($c < 0x20) {
            $c = unctrl($c);
        }
        elsif $c >= 0xff {
            $c = keyname($c);
        }
        else {
            $c = chr($c);
        }

        $c;
    }

    method y() is rw {
        my $w := $!stdscr;
        my $s := self;
        return Proxy.new:
            FETCH => method () {
                return getcury($w);
            },
            STORE => method ($val) {
                #note "Moving {$s.y} to $val, keeping {$s.x}";
                wmove($w, $val, $s.x);
                return $val;
            };
    }
    method x() is rw {
        my $w := $!stdscr;
        my $s := self;
        return Proxy.new:
            FETCH => method () {
                return getcurx($w);
            },
            STORE => method ($val) {
                wmove($w, $s.y, $val);
                return $val;
            };
    }
}

# vim:set ft=perl6:
