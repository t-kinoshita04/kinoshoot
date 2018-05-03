require 'dxruby'

image = Image.load('data.png')  # data.pngを読み込む
x = 0
y = 0
s = 0
t = 0

Window.loop do
  x = x + Input.x  # x座標の更新
  y = y + Input.y  # y座標の更新
  t = (t + 3)
  Window.draw(x, y, image)  # data.pngを描画する
  Window.draw(s, t, image)
end
