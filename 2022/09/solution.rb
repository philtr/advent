require "minitest/autorun"
require "minitest/spec"

DIRECTIONS = {
  "R" => [1, 0],
  "L" => [-1, 0],
  "U" => [0, 1],
  "D" => [0, -1]
}

def follow(h,t)
  return t if adjacent?(h,t)

  move = if in_line?(h,t)
    sub(h,t).map { _1 / 2 }
  else
    sub(h,t).map { (_1 / 2.0) > 0 ? 1 : -1 }
  end

  add(t, move)
end

def tr(h,t)         = [h,t].transpose
def in_line?(h,t)   = tr(h,t).map { _1.uniq.size }.any? { _1 < 2 }
def adjacent?(h,t)  = sub(h,t).none? { _1.abs > 1 }
def add(a,b)        = tr(a,b).map { _1.reduce(&:+) }
def sub(h,t)        = tr(h,t).map { _1.reduce(&:-) }

$head = ($tail = [1,1]).dup
$visited = [[1,1]]

File.readlines(ARGV[0]).map do |instruction|
  direction, distance = instruction.split
  move = DIRECTIONS[direction]

  distance.to_i.times do |j|
    $head = add($head,move)
    $tail = follow($head, $tail)

    puts "#{instruction.chomp}.#{j+1}: { h: #$head, t: #$tail }"

    $visited << $tail
  end
end

puts $visited.uniq.length

describe "adjacent" do
  let(:same_location) { [[5,5],[5,5]] }
  let(:bottom_left)   { [[5,5],[4,4]] }
  let(:bottom_center) { [[5,5],[5,4]] }
  let(:bottom_right)  { [[5,5],[6,4]] }
  let(:middle_right)  { [[5,5],[6,5]] }
  let(:top_right)     { [[5,5],[6,6]] }
  let(:top_center)    { [[5,5],[5,6]] }
  let(:top_left)      { [[5,5],[4,6]] }
  let(:middle_left)   { [[5,5],[5,6]] }

  describe "is true when" do
    it { _(adjacent?(*same_location)).must_equal(true) }
    it { _(adjacent?(*bottom_left)).must_equal(true) }
    it { _(adjacent?(*bottom_center)).must_equal(true) }
    it { _(adjacent?(*bottom_right)).must_equal(true) }
    it { _(adjacent?(*middle_right)).must_equal(true) }
    it { _(adjacent?(*top_right)).must_equal(true) }
    it { _(adjacent?(*top_center)).must_equal(true) }
    it { _(adjacent?(*top_left)).must_equal(true) }
    it { _(adjacent?(*middle_left)).must_equal(true) }
  end

  describe "it is false when" do
    it { _(adjacent?([2,3],[1,1])).must_equal(false) }
    it { _(adjacent?([1,1],[1,3])).must_equal(false) }
    it { _(adjacent?([3,1],[1,1])).must_equal(false) }
  end
end

describe "follow" do
  describe "it does not move if it is already adjacent" do
    it { _(follow([5,5],[5,6])).must_equal([5,6]) }
  end

  describe "it moves straight when in the same column or row" do
    it { _(follow([3,2],[1,2])).must_equal([2,2]) }
    it { _(follow([1,1],[1,3])).must_equal([1,2]) }
  end

  describe "it moves diagonally when not in the same column or row" do
    it { _(follow([2,3],[1,1])).must_equal([2,2]) }
    it { _(follow([3,2],[1,1])).must_equal([2,2]) }
    it { _(follow([5,4],[3,5])).must_equal([4,4]) }
  end
end
