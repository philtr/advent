cycles, _i, screen = $<.reduce([{0=>1}, 0, ""]) do |(cycles, i, screen), ins|
  cursor = cycles[i] % 40
  sprite = (cursor-1)..(cursor+1)
  screen << (sprite.cover?(i % 40) ? "#" : ".")

  # process instruction
  case ins
  when /n/ then next [ cycles.merge(i+1 => cycles[i]),
                       i+1,
                       screen ]
  when /-?\d+/ then
    cycles[i+1] = cycles[i]
    cycles[i+2] = cycles[i] + $&.to_i

    screen << (sprite.cover?((i+1) % 40) ? "#" : ".")

    next [cycles, i+2, screen]
  end
end

# part 1
puts 20.step(by: 40, to: cycles.size).map { cycles[_1] * _1 }.reduce(&:+)

# part 2
puts screen.chars.each_slice(40).map(&:join)
