module Term::Curses::Raw;

use NativeCall;

my %lib;
BEGIN {
    # TODO: Make this portable, this only works on OS X Zavolaj uses
    # %*VM<config><load_ext>, which is just ".bundle" on OS X. But OS X has
    # several possible (incompatible) library extensions to choose from, so
    # another approach is needed.
    %lib<c>      = 'libc.dylib';
    %lib<curses> = 'libcurses.dylib';
}

# RAKUDO: Not sure why, but this is failing with "SORRY! Missing block"
sub setlocale(int32, Str) returns Str
    is export is native(%lib<c>) {}

sub initscr() returns OpaquePointer
    is export is native(%lib<curses>) {}
sub cbreak()
    is export is native(%lib<curses>) {}
sub noecho()
    is export is native(%lib<curses>) {}
sub nonl()
    is export is native(%lib<curses>) {}
sub intrflush(OpaquePointer, int32)
    is export is native(%lib<curses>) {}
sub keypad(OpaquePointer, int32)
    is export is native(%lib<curses>) {}
sub has_colors() returns int32
    is export is native(%lib<curses>) {}
sub use_default_colors() returns int32
    is export is native(%lib<curses>) {}
sub start_color() returns int32
    is export is native(%lib<curses>) {}
sub endwin()
    is export is native(%lib<curses>) {}

sub waddstr(OpaquePointer, Str) returns int32
    is export is native(%lib<curses>) {}
sub waddnstr(OpaquePointer, Str, int32) returns int32
    is export is native(%lib<curses>) {}

sub wrefresh(OpaquePointer)
    is export is native(%lib<curses>) {}
sub werase(OpaquePointer)
    is export is native(%lib<curses>) {}
sub wclear(OpaquePointer)
    is export is native(%lib<curses>) {}
sub wclrtobot(OpaquePointer)
    is export is native(%lib<curses>) {}
sub wclrtoeol(OpaquePointer)
    is export is native(%lib<curses>) {}
sub wgetch(OpaquePointer) returns int32
    is export is native(%lib<curses>) {}
sub wmove(OpaquePointer, int32, int32)
    is export is native(%lib<curses>) {}

sub unctrl(int32) returns Str
    is export is native(%lib<curses>) {}
sub keyname(int32) returns Str
    is export is native(%lib<curses>) {}

# These are non-standard, but curses doesn't provide a non-macro alternative
# for getyx() and similar. A portable alternative would require compiling a
# library that wraps the macros. See examples/term-curses.c for an example.
sub getmaxy(OpaquePointer) returns int32
    is export is native(%lib<curses>) {}
sub getmaxx(OpaquePointer) returns int32
    is export is native(%lib<curses>) {}
sub getcury(OpaquePointer) returns int32
    is export is native(%lib<curses>) {}
sub getcurx(OpaquePointer) returns int32
    is export is native(%lib<curses>) {}

# vim:set ft=perl6:
