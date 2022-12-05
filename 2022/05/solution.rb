def init(stacks, line)
  line.scan(/(\s{4}|[A-Z])/).map(&:first).each_with_index do |crate, stack|
    stacks[stack] ||= []
    stacks[stack].unshift(crate) if crate =~ /[A-Z]/
  end
  p stacks
end

def move(stacks, line)
  count, from, to = line.scan(/\d+/).map { _1.to_i-1 }
  p "move #{count+1} from #{from+1} to #{to+1}"
  stacks[to] ||= []
  stacks[from] ||= []
  stacks[to].push(*(stacks[from].pop(count+1).reverse))
  p stacks
end

File.open ARGV[0] do |f|
  stacks = []
  n = 0
  until f.eof?
    stacks =
      case (line = f.readline)
      when /\A\s*\[/ then init(stacks, line)
      when /\Amove/ then move(stacks, line)
      else stacks
      end
  end

  puts stacks.map(&:pop).join
end

