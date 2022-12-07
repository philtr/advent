require "minitest/autorun"
require "minitest/spec"

module Communicator
  module_function

  def dir_sum_max(io, max = 100_000)
    disk_usage(io).sum { _2 <= max ? _2 : 0 }
  end

  def disk_usage(io)
    du = Hash.new(0)
    cwd = []

    until io.eof? do
      case (cmd = io.gets.chomp)
      when "$ cd /" then :noop
      when "$ cd .." then cwd.pop
      when /\$ cd (.+)/ then cwd.push("#{cwd.last}/#$1")
      when /(\d+)/ then cwd.each { du[_1] += $1.to_i }
      end
    end

    du
  end
end

puts "=========================================================="
puts "Part 1: #{Communicator.dir_sum_max(File.open("input.txt"))}"
puts "=========================================================="

describe Communicator do
  let(:io) { File.open("example.txt") }

  it "finds the sum of all directories of size </ 100000" do
    expect(Communicator.dir_sum_max(io)).must_equal(95437)
  end
end
