require "minitest/autorun"
require "minitest/spec"

module Communicator

  module_function

  def packet_start(signal) = first_unique_chars(signal, 4)
  def message_start(signal) = first_unique_chars(signal, 14)

  def first_unique_chars(signal, n)
    signal.chars.each_cons(n).each_with_index do |chars, index|
      return index+n if chars.uniq.size == n
    end
  end
end

puts "First start-of-packet marker: #{Communicator.packet_start(File.read("input.txt"))}"
puts "First start-of-message marker: #{Communicator.message_start(File.read("input.txt"))}"

describe Communicator do
  it "finds the marker correctly" do
    value(Communicator.packet_start("mjqjpqmgbljsphdztnvjfqwrcgsmlb")).must_equal(7)
    value(Communicator.packet_start("bvwbjplbgvbhsrlpgdmjqwftvncz")).must_equal(5)
    value(Communicator.packet_start("nppdvjthqldpwncqszvftbrmjlhg")).must_equal(6)
    value(Communicator.packet_start("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")).must_equal(10)
    value(Communicator.packet_start("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")).must_equal(11)
  end

  it "finds the marker correctly" do
    value(Communicator.message_start("mjqjpqmgbljsphdztnvjfqwrcgsmlb")).must_equal(19)
    value(Communicator.message_start("bvwbjplbgvbhsrlpgdmjqwftvncz")).must_equal(23)
    value(Communicator.message_start("nppdvjthqldpwncqszvftbrmjlhg")).must_equal(23)
    value(Communicator.message_start("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")).must_equal(29)
    value(Communicator.message_start("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")).must_equal(26)
  end
end
