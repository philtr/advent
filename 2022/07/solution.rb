require "minitest/autorun"
require "minitest/spec"

class Communicator

  attr_reader :io, :disk_usage, :total_disk_space

  def initialize(io, total_disk_space: 70000000)
    @io = io
    @disk_usage = calculate_disk_usage
    @total_disk_space = total_disk_space
  end

  def dir_sum_max(max = 100_000)
    disk_usage.sum { _2 <= max ? _2 : 0 }
  end

  def space_used = disk_usage["/"]
  def space_free = total_disk_space - space_used

  def make_free_space(min = 30_000_000)
    bytes_to_delete = min - space_free

    disk_usage
      .select {|_dir, size| size > bytes_to_delete }
      .sort_by(&:last)
      .first
  end

  private

  def calculate_disk_usage
    du = Hash.new(0)
    cwd = []

    until io.eof? do
      case (cmd = io.gets.chomp)
      when "$ cd /" then :noop
      when "$ cd .." then cwd.pop
      when /\$ cd (.+)/ then cwd.push([*cwd, $1].compact.join("/"))
      when /(\d+)/ then
        size = $1.to_i
        du["/"] += $1.to_i
        cwd.each { du[_1] += $1.to_i }
      end
    end

    du
  end

end

comm = Communicator.new(File.open("input.txt"))

puts "=========================================================="
puts "Part 1: #{comm.dir_sum_max(100_000)}"
puts "Part 2: #{comm.make_free_space(30_000_000)[1]}"
puts "=========================================================="

describe Communicator do
  let(:io) { File.open("example.txt") }
  let(:subject) { Communicator.new(io) }

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
