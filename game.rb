require 'dxruby'
# x = 0
# y = 0
# s = 0
# t = 0
#
# Window.loop do
#   x = x + Input.x  # x座標の更新
#   y = y + Input.y  # y座標の更新
#   t = (t + 3)
#   Window.draw(x, y, image)  # data.pngを描画する
#   Window.draw(s, t, image)
# end

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

fighter = Fighter.new
Window.loop do
fighter.move(Input.x, Input.y)
end

# class Bullet
# end
