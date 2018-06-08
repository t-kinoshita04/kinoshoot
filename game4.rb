require 'dxruby'

class Glove < Sprite

  $score = 0

  def initialize(x, y)
    super
    self.angle = rand * 360
    self.image = Image.load('glove.png')
    @limit_time = 10
    @start_time = Time.now
  end

  def update
    self.y += 3
    self.vanish if self.y > 480
  end

  def hit
    if self.vanish
      $score += 10 * rand(1..10)
    end
  end
end


class Bat

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(dx)
    @x = @x + dx * 3
  end

  def appearance(dx)
    move(dx)
    Window.draw(@x, @y, Image.load('bat.png'))
  end

end

class Ball < Sprite

  def initialize(x, y)
    super
    @x = x
    @y = y
    @flag = 0
    self.image = Image.load('ball.png')
  end

  def ball_move(x)
    if Input.key_push?(K_SPACE)
      @flag = 1
      @y = 400
      @x = x
    end

    if @flag == 1
    	@y -= 10
      self.x, self.y = @x, @y
      self.draw
    end
  end
end


class Result

  def initialize
    @limit_time = 10
    @start_time = Time.now
  end

  def score
    Window.draw_font(0, 0, "#{$score}", Font.new(32))
  end

  def time
    now_time = Time.now
	  diff_time = now_time - @start_time
	  countdown = (@limit_time - diff_time).to_i
	  Window.draw_font(0, 100, "#{countdown}", Font.new(32))
    if countdown == 0
      Window.loop do
        Window.draw_font(120, 180, "Score: #{$score}", Font.new(80))
      end
    end
  end
end


glove = []
count = 15
bat = Bat.new(0, 400)
ball = Ball.new(0, 0)
result = Result.new

Window.loop do
  count -= 1
  if count == 0
    count = 15
    glove << Glove.new(rand*540, -100)
  end
  bat.appearance(Input.x)
  ball.ball_move(bat.move(Input.x))
  Sprite.update(glove)
  Sprite.check(ball, glove)
  Sprite.draw(glove)
  result.score
  result.time
end
