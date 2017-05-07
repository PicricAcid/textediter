require "curses"

class CommandWind
  def initialize(wind, file_name="")
    max_y = wind.maxy
    max_x = wind.maxx
    begin_y = wind.maxy - 3
    wind.setpos(begin_y, 0)
    wind.standout
    wind.addstr(""*max_x)
    wind.standend

    wind.setpos(begin_y, (max_x/2) - (file_name.length/2))
    wind.addstr(file_name)

    @window = wind.subwin((max_y - begin_y), max_x, begin_y, 0)
    @window.refresh
  end
end
