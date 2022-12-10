cycles = $<.reduce([{1=>1}, 1]) do |(cycles, i), ins|
  case ins
  when /n/ then next [cycles.merge(i+1 => cycles[i]), i+1]
  when /-?\d+/ then
    cycles[i+1] = cycles[i]
    cycles[i+2] = cycles[i] + $&.to_i
    next [cycles, i+2]
  end
  raise "should not get here"
end[0]

puts 20.step(by: 40, to: cycles.size).map { cycles[_1] * _1 }.reduce(&:+)


