WIDTH = 40
ON, OFF = ["▓", "░"]

cycles, _i, screen = $<.reduce([{1=>1}, 1, ""]) do |(cycles, i, screen), ins|

  # draw pixel on screen
  cursor = (cycles[i] + 1) % WIDTH
  sprite = (cursor-1)..(cursor+1)
  screen << (sprite.cover?(i % WIDTH) ? ON : OFF)

  # set next cycle's register to this one's value
  cycles[i+1] = cycles[i]

  # run an extra cycle if this is an addx operation
  if ins =~ /-?\d+/
    # finish the 'calculation'
    cycles[i+2] = cycles[i] + $&.to_i
    screen << (sprite.cover?((i+1) % WIDTH) ? ON : OFF)
    i += 1
  end

  [cycles, i+1, screen]

end

# part 1
puts 20.step(by: 40, to: 220).map { cycles[_1] * _1 }.reduce(&:+)

# part 2
puts screen.chars.each_slice(WIDTH).map(&:join)
