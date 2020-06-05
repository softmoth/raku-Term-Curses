unit module Term::Curses::Raw;

use NativeCall;

my %lib;
BEGIN {
    use LibraryCheck;
    # NB: Needs testing on various platforms; please open an issue
    # with any portability concerns
    my $curses = ((v6, v5) X <ncursesw ncurses curses>)
            .map(*.reverse.cache)
            .grep({ library-exists |$_ })
            .first
        // ('curses', Version);

    %lib<curses> = $curses;
    if $curses and $curses.head.starts-with('ncurses') {
        my $w = $curses.head.ends-with('w') ?? 'w' !! '';
        for <form menu panel> -> $lib {
            %lib{$lib} = $lib ~ $w, $curses.tail
        }
    }
}

sub setlocale(int32, Str) returns Str
    is export is native {}

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

sub isendwin() returns bool
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
