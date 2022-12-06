def moves(map, count = 0)
  succ = map
  begin
    # puts "After #{count} steps:\n#{succ.join("\n")}"
    map = succ
    east = move(map, ">")
    south = move(transpose(east), "v")
    succ = transpose(south)
    count += 1
  end until succ == map

  count
end

def move(map, cuke)
  map.map {
    chars = _1.chars

    if chars[0] == "." && chars[-1] == cuke
      "#{cuke}#{chars[1..-2].join.gsub(/#{cuke}\./, ".#{cuke}")}."
    else
      chars.join.gsub(/#{cuke}\./, ".#{cuke}")
    end
  }
end

def transpose(map) = map.map(&:chars).transpose.map(&:join)

p moves($<.readlines(chomp:1))


