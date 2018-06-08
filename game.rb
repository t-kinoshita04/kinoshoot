# Rubyのライブラリ
require 'dxruby'

# 自機
class Fighter
# 自機のスタート位置と画像の読み込み
  def initialize
    @x = 0
    @y = 0
    @image = Image.load('fighter.png')
  end
# 自機の移動
  def move(dx, dy)
    @x = @x + dx
    @y = @y + dy
  end
  # 自機の出現
  def appearance(dx, dy)
    move(dx, dy)
    Window.draw(@x, @y, @image)
  end
end

# 的
 class Target
# 的の作成
  def initialize
    @image = Image.load('target.png')
  end
  # 的の配置
  def arrangement
    3.times {|n| Window.draw(500, 50 + n * 120, @image)}
  end
end

# 弾
class Bullet < Fighter

  def initialize
    super
    @bx = 0
    @by = 0
    @flag = 0
    @nflag = [0, 0, 0]
    @bullet = Image.load('bullet.png')
    @image = Image.new(90, 90, color=[255,0,0,0])
  end

  def tama
    move(Input.x, Input.y) # 戦闘機の座標を登録
    if Input.key_push?(K_Z)
      @flag = 1
      @bx = @x
      @by = @y
    end

    if @flag == 1
    	@bx += 10
    	Window.draw(@bx, @by, @bullet)
    end
  end

  def hit
    3.times do |n|
      if @bx >= 450 && @bx <= 550 && @by >= 50 + n * 100 && @by <= 80 + n * 100
        case n
          when 0
            @nflag[0] = 1
          when 1
            @nflag[1] = 1
          when 2
            @nflag[2] = 1
        end
      end

      if @nflag[0] == 1
        Window.draw(500, 50, @image)
      end
      if @nflag[1] == 1
        Window.draw(500, 170, @image)
      end
      if @nflag[2] == 1
        Window.draw(500, 290, @image)
      end
    end
  end
end

# 実行
fighter = Fighter.new
target = Target.new
bullet = Bullet.new
Window.loop do
  fighter.appearance(Input.x, Input.y)
  bullet.tama
  target.arrangement
  bullet.hit
end
