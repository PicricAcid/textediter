require "./editwind"
require "curses"

class Handler
  def execute(wind, input_ch)
    case input_ch
    when ?s
      wind.cursor_down
    when ?w
      wind.cursor_up
    when ?a
      wind.cursor_left
    when ?d
      wind.cursor_right
    when ?q
      raise "QUIT"
    when 27
      return EditHandler.new
    when ?x
      wind.delete
    end
    return self
  end
end

class EditHandler
  def execute(wind, input_ch)
    case input_ch
    when 27
      return Handler.new
    else
      wind.input(input_ch)
    end
    return self
  end
end
