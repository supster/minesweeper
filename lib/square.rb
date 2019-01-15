class Square
  attr_accessor :id, :value, :open
  def initialize(id, value)
    @id = id
    @value = value
    @open = false
  end

  def open?
    @open
  end

  def color_code
    return 31 if @value == 'M'
    colors = [32, 33, 34, 35]
    colors[@value.to_i]
  end

  def display(open_all)
    if @open || open_all
      if @value.nil?
        space = '  '
      elsif @value.size <= 1
        space = ' ';
      end
      print " | \e[#{color_code}m#{space}#{@value} \e[0m"
    else
      val = @id
      space = @id <=9 ? ' ' : '';
      print " | #{space}#{val} "
    end
  end
end