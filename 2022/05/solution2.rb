require "minitest/autorun"
require "minitest/spec"

class SupplyMover
  INIT = /\[/
  MOVE = /\Am/

  def initialize(crane: CrateMover9000.new)
    @crane = crane
  end

  def run(instructions)
    instructions
      .lines(chomp: true)
      .reduce([], &method(:instruction))
  end

  def self.run(crane:, instructions:)
    new(crane: crane).run(instructions)
  end

  def self.tops(**kwargs)
    run(**kwargs).map(&:pop)
  end

  private

  def instruction(stacks, line)
    case line
    when INIT then init(stacks, line)
    when MOVE then move(stacks, line)
    else stacks
    end
  end

  def init(stacks, line)
    line.scan(/\s{4}|\w/).each_with_index do |crate, stack|
      stacks[stack] ||= []
      stacks[stack].unshift(crate) if crate =~ /\w/
    end

    stacks
  end

  def move(stacks, line)
    count, from, to = line.scan(/\d+/).map(&:to_i)
    crates = @crane.pickup(stacks[from - 1], count)
    stacks[to - 1].push(*crates)
    stacks
  end
end

class CrateMover9000
  def pickup(stack, count)
    stack.pop(count).reverse
  end
end

class CrateMover9001
  def pickup(stack, count)
    stack.pop(count)
  end
end

describe SupplyMover do
  let(:input) { File.read("example.txt") }

  it "moves crates one at a time" do
    result = SupplyMover.tops(
      crane: CrateMover9000.new,
      instructions: input
    )

    expect(result.join).must_equal("CMZ")
  end

  it "moves crates many at a time" do
    result = SupplyMover.tops(
      crane: CrateMover9001.new,
      instructions: input
    )

    expect(result.join).must_equal("MCD")
  end
end


INPUT = File.read("input.txt")

[CrateMover9000, CrateMover9001].each do |crane|
  result = SupplyMover.tops(
    crane: crane.new,
    instructions: INPUT
  )

  puts "#{crane}: #{result.join}"
end

puts "\n\n"
