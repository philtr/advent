class CommunicatorStorage

  attr_reader :total_space
  attr_accessor :usage

  def initialize(total_space: 70000000)
    @usage = Hash.new(0)
    @total_space = total_space
  end

  def calculate_usage(io)
    cwd = []

    until io.eof? do
      case io.gets.chomp

      when "$ cd .."
        cwd.pop

      when /\$ cd ([^\/]+)/
        cwd.push([*cwd, $1].compact.join("/"))

      when /(\d+)/ then
        size = $1.to_i
        usage["/"] += $1.to_i
        cwd.each { usage[_1] += $1.to_i }
      end
    end
  end

  def space_used = usage["/"]

  def space_free = total_space - space_used

  def dir_sum_max(max) = usage.sum {|_, size| size <= max ? size : 0 }

  def make_free_space(min)
    usage
      .select {|_, size| size > (min - space_free) }
      .sort_by(&:last)
      .first
  end
end

comm = CommunicatorStorage.new
comm.calculate_usage(File.open("input.txt"))

puts "=========================================================="
puts "Part 1: #{comm.dir_sum_max(100_000)}"
puts "Part 2: #{comm.make_free_space(30_000_000)[1]}"
puts "=========================================================="

require "minitest/autorun"
require "minitest/spec"

describe CommunicatorStorage do
  let(:io) { File.open("example.txt") }
  let(:subject) { CommunicatorStorage.new }

  before { subject.calculate_usage(io) }

  describe "Part 1" do
    it "finds the sum of all directories of size <= 100000" do
      expect(subject.dir_sum_max(100_000)).must_equal(95437)
    end
  end

  describe "Part 2" do
    it "finds the smallest directory to delete to ensure free space" do
      expect(subject.make_free_space(30_000_000))
        .must_equal(["d", 24_933_642])
    end
  end

  describe "Utils" do
    it "finds the total of all directories" do
      expect(subject.space_used).must_equal(48381165)
    end

    it "finds the free space available" do
      expect(subject.space_free).must_equal(21618835)
    end
  end
end
