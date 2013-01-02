class ViewMode
  attr_reader :modes, :mode

  def initialize(modes, initial=nil)
    @modes = modes
    goto(initial)
  end

  def at(mode)
    ViewMode.new(@modes, mode)
  end

  def goto(mode)
    if mode.nil?
      @mode = modes.first
    elsif @modes.include?(mode)
      @mode = mode
    else
      raise ArgumentError
    end
  end

  def current_index
    @modes.index(@mode) || -1
  end

  def next
    next_index = (current_index + 1) % @modes.size
    @modes[next_index]
  end
end
