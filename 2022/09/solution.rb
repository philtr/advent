require "minitest/autorun"
require "minitest/spec"
require "benchmark"

module KnottedRope
  DIRECTIONS = {
    "R" => [1, 0],
    "L" => [-1, 0],
    "U" => [0, 1],
    "D" => [0, -1]
  }

  START = [1,1]

  module_function

  # returns the number of unique locations visited by the tail of the rope
  def run(instructions, knots: 2)
    rope = Array.new(knots, [1,1])
    visited = [START]

    instructions.map(&:split).map do |direction, distance|
      move = DIRECTIONS[direction]

      distance.to_i.times do
        # move the head to the instructed location
        rope[0] = apply(rope.first, move)

        # follow each knot in the rope and update rope positions
        rope = rope.reduce([]) do |knots, cur|
          knots << follow(knots.last || cur, cur)
        end

        # mark tail as visited
        visited << rope.last
      end
    end

    visited.uniq.count
  end


  # move knots according to simplistic string physics
  def follow(prev, cur)
    case
    when adjacent?(prev, cur)   then return cur
    when orthogonal?(prev, cur) then apply(cur, ortho(prev, cur))
    when true                   then apply(cur, diag(prev, cur))
    end
  end

  # returns true if the two points are adjacent (incl. diagonal)
  def adjacent?(a, b) = sub(a, b).none? { _1.abs > 1 }

  # apply the given move transformation and return the result
  def apply(a, b) = tr(a, b).map { _1.reduce(&:+) }

  # returns the move transformation for a diagonal move
  def diag(a, b) = sub(a, b).map { (_1 / 2.0) > 0 ? 1 : -1 }

  # returns true if the two points are orthogonal (they share a column or row)
  def orthogonal?(a, b) = tr(a, b).any? { _1.reduce(:==) }

  # returns the move transformation for an orthogonal move
  def ortho(a, b) = sub(a, b).map { _1 / 2 }

  # returns the differential between two points
  def sub(a, b) = tr(a, b).map { _1.reduce(&:-) }

  # transposes two arrays such that x and y are collected
  def tr(a, b) = [a, b].transpose
end

instructions = File.readlines(ARGV[0])

puts "    in #{Benchmark.measure { puts "PART 1: #{KnottedRope.run(instructions)}" }.real.round(5)} seconds"
puts "    in #{Benchmark.measure { puts "PART 2: #{KnottedRope.run(instructions, knots: 10)}" }.real.round(5)} seconds"

describe KnottedRope do
  let(:rope) { KnottedRope }

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
      it { _(rope.adjacent?(*same_location)).must_equal(true) }
      it { _(rope.adjacent?(*bottom_left)).must_equal(true) }
      it { _(rope.adjacent?(*bottom_center)).must_equal(true) }
      it { _(rope.adjacent?(*bottom_right)).must_equal(true) }
      it { _(rope.adjacent?(*middle_right)).must_equal(true) }
      it { _(rope.adjacent?(*top_right)).must_equal(true) }
      it { _(rope.adjacent?(*top_center)).must_equal(true) }
      it { _(rope.adjacent?(*top_left)).must_equal(true) }
      it { _(rope.adjacent?(*middle_left)).must_equal(true) }
    end

    describe "it is false when" do
      it { _(rope.adjacent?([2,3],[1,1])).must_equal(false) }
      it { _(rope.adjacent?([1,1],[1,3])).must_equal(false) }
      it { _(rope.adjacent?([3,1],[1,1])).must_equal(false) }
    end
  end

  describe "follow" do
    describe "it does not move if it is already adjacent" do
      it { _(rope.follow([5,5],[5,6])).must_equal([5,6]) }
    end

    describe "it moves straight when in the same column or row" do
      it { _(rope.follow([3,2],[1,2])).must_equal([2,2]) }
      it { _(rope.follow([1,1],[1,3])).must_equal([1,2]) }
    end

    describe "it moves diagonally when not in the same column or row" do
      it { _(rope.follow([2,3],[1,1])).must_equal([2,2]) }
      it { _(rope.follow([3,2],[1,1])).must_equal([2,2]) }
      it { _(rope.follow([5,4],[3,5])).must_equal([4,4]) }
    end
  end
end
