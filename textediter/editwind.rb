require "curses"

class EditWind
  def initialize(wind)

    @window = wind.subwin(wind.maxy - 3, wind.maxx, 0, 0)

    @window.scrollok(true)
  end

  def display(file_name)
    @file_name = file_name
    begin
      @file = open(@file_name, "a+")
      @data = []
      @file.each_line do |line|
        @data.push(line.chop)
      end

      @data[0..(@window.maxy - 1)].each_with_index do |line, idx|
        @window.setpos(idx, 0)
        @window.addstr(line)
      end
    rescue
      raise IOError, "FILE OPEN ERROR: #{file_name}"
    end
    @cursor_y = 0
    @cursor_x = 0
    @top_statement = 0
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def getch
    return @window.getch
  end

  def cursor_down
    if @cursor_y >= (@window.maxy - 1)
      scroll_down
    elsif @cursor_y >= (@data.length - 1)
    else
      @cursor_y += 1
    end
    if @cursor_x >= (@data[@cursor_y + @top_statement].length)
      @cursor_x = @data[@cursor_y + @top_statement].length
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_up
    if @cursor_y <= 0
      scroll_up
    else
      @cursor_y -= 1
    end
    if @cursor_x >= (@data[cursor_y + @top_statement].length)
      @cursor_x = @data[@cursor_y + @top_statement].length
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_left
    unless @cursor_x <= 0
      @cursor_x -= 1
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_right
    unless @cursor_x >= (@data[@cursor_y + @top_statement].length)
      @cursor_x += 1
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def scroll_up
    if(@top_statement > 0)
      @window.scrl(-1)
      @top_statement -= 1

      str = @data[@top_statement]
      if(str)
        @window.setpos(0, 0)
        @window.addstr(str)
      end
    end
  end

  def scroll_down
    if(@top_statement + @window.maxy < @data.length)
      @window.scrl(1)
      str = @data[@top_statement + @window.maxy]
      if(str)
        @window.setpos(@window.maxy - 1, 0)
        @window.addstr
      end
      @top_statement += 1
    end
  end

  def input(input_ch)
    @window.insch(input_ch)
    @window.setpos(@cursor_y, @cursor_x += 1)
  end

  def delete
    @window.delch
  end

end
