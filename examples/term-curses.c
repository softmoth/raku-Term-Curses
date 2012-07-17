/*
Example of wrapper for getyx() and similar macros, in case this is needed for
portability. Compile this into a dynamic library, and then use something like
this to access:

class CursesPoint is repr('CStruct') {
    has int $.y;
    has int $.x;
}

sub term_curses_getyx(OpaquePointer, CursesPoint) is native('your-library-name');
sub term_curses_getmaxyx(OpaquePointer, CursesPoint) is native('your-library-name');

my $p = CursesPoint.new;
term_curses_getyx($!stdscr, $p);
say "I'm at {$p.y}, {$p.x}";

*/

#include <curses.h>

struct Point {
    long y;
    long x;
};

void term_curses_getyx(WINDOW *win, struct Point *p) {
    getyx(win, p->y, p->x);
}

void term_curses_getmaxyx(WINDOW *win, struct Point *p) {
    getmaxyx(win, p->y, p->x);
}
