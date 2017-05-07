require "curses"
require "./editwind"
require "./commandwind"
require "./handler"

if ARGV.size != 1
  printf("usage: fe file_name\n")
  exit
else
  file_name = ARGV[0]
end

Curses.init_screen
Curses.cbreak
Curses.noecho

defo_wind = Curses.stdscr

edit_wind = EditWind.new(defo_wind)

cmmd_wind = CommandWind.new(defo_wind, file_name)

handler = Handler.new

edit_wind.display(file_name)
begin true
  while true
    ch = edit_wind.getch
    handler = handler.execute(edit_wind, ch)
  end
end

Curses.close_screen
