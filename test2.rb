require 'dxruby'

font = Font.new(32)

limit_time = 3 * 60  # 分*60
start_time = Time.now

Window.loop do
  now_time = Time.now
	diff_time = now_time - start_time
	countdown = (limit_time - diff_time).to_i
	min = countdown / 60
	sec = countdown % 60
	Window.drawFont(100, 100, "#{min}:#{sec}", font)
end
