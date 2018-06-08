require 'dxruby'

class Box < Sprite
  @@image = Image.new(100,100,C_RED)
  def initialize(x, y)
    super
    self.angle = rand * 360
    self.image = @@image
  end

  def update
    self.y += 1
    self.vanish if self.y > 480
  end

  def hit(o)
    self.vanish
  end
end

s = []
m = Sprite.new(0, 0, Image.new(100,20,C_WHITE))
count = 50

Window.loop do
  count -= 1
  if count == 0
    count = 50
    s << Box.new(rand*540,-100)
  end
  m.x, m.y = Input.mouse_pos_x - 50, Input.mouse_pos_y - 10
  m.angle -= 5 if Input.mouse_down?(M_LBUTTON)
  m.angle += 5 if Input.mouse_down?(M_RBUTTON)

  Sprite.update(s)
  Sprite.check(m, s)
  Sprite.draw(s)
  m.draw
end
