require 'dxruby'

class Fighter

  def initialize
    @x = 0
    @y = 0
    @image = Image.load('data.png')
  end

  def move(dx, dy)
    @x = @x + dx
    @y = @y + dy
    Window.draw(@x, @y, @image)
  end
end


class Target

  def initialize
    @image = Image.new(80, 80, color=[255,255,0,0])
  end

  def arrangement
    3.times {|n| Window.draw(500, 50 + n * 120, @image)}
  end
end

class Bullet




end




fighter = Fighter.new
target = Target.new
Window.loop do
  fighter.move(Input.x, Input.y)
  target.arrangement
end
