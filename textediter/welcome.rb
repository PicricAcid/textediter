require "curses"

Curses::init_screen
Curses::setpos(5, 2)
Curses::addstr("Hello Curses")
Curses::refresh
Curses::getch
Curses::close_screen
