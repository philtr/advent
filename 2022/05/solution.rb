def init(stacks, line)
  line.scan(/(\s{4}|[A-Z])/).map(&:first).each_with_index do |crate, stack|
    stacks[stack] ||= []
    stacks[stack].unshift(crate) if crate =~ /[A-Z]/
  end
  stacks
end

def move(stacks, line, part2 = false)
  count, from, to = line.scan(/\d+/).map { _1.to_i-1 }
  stacks[to] ||= []
  stacks[from] ||= []
  crates = stacks[from].pop(count+1)
  part2 ? :noop : crates.reverse!
  stacks[to].push(*crates)
  stacks
end

File.open ARGV[0] do |f|
  stacks = []
  until f.eof?
    stacks =
      case (line = f.readline)
      when /\A\s*\[/ then init(stacks, line)
      when /\Amove/ then move(stacks, line, ARGV[1].to_i == 2)
      else stacks
      end
  end

  puts stacks.map(&:pop).join
end
