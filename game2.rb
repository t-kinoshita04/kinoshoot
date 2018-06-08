require 'dxruby'

class Game < Sprite
  @@image1 = Image.load('glove.png')
  @@image2 = Image.load('bat.png')
  @@score = 0
  def initialize(x, y)
    super
    self.angle = rand * 360
    self.image = @@image1
    @x = x
    @y = y
    @bx = x
    @by = y
    @flag = 0
    @limit_time = 10
    @start_time = Time.now
  end

  def update
    self.y += 3
    self.vanish if self.y > 480
  end

  def hit(o)
    if self.vanish
      @@score += 10 * rand(1..10)
    end
  end

  def move(dx)
    @x = @x + dx * 3
  end

  def appearance(dx)
    move(dx)
    Window.draw(@x, @y, @@image2)
  end

  def ball(m)
    move(Input.x)
    if Input.key_push?(K_SPACE)
      @flag = 1
      @bx = @x
      @by = @y
    end

    if @flag == 1
    	@by -= 10
      m.x, m.y = @bx, @by
      m.draw
    end
  end

  def score
    Window.draw_font(0, 0, "#{@@score}", Font.new(32))
  end

  def time
    now_time = Time.now
	  diff_time = now_time - @start_time
	  countdown = (@limit_time - diff_time).to_i
	  Window.draw_font(0, 100, "#{countdown}", Font.new(32))
    if countdown == 0
      Window.loop do
        Window.draw_font(110, 180, "Score:#{@@score}", Font.new(80))
      end
    end
  end
end

s = []
m = Sprite.new(0, 0, Image.load('ball.png'))
count = 15

game = Game.new(0, 400)
Window.loop do
  count -= 1
  if count == 0
    count = 15
    s << Game.new(rand*540, -100)
  end
  game.appearance(Input.x)
  game.ball(m)
  Sprite.update(s)
  Sprite.check(m, s)
  Sprite.draw(s)
  game.score
  game.time
end
