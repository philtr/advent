require "irb"
require "minitest/autorun"
require "minitest/spec"

def packet_start(signal)
  signal.chars.each_cons(4).each_with_index do |chars, index|
    return index+4 if chars.uniq.size == 4
  end
end

describe "find start of packet" do
  it "finds the marker correctly" do
    value(packet_start("mjqjpqmgbljsphdztnvjfqwrcgsmlb")).must_equal(7)
    value(packet_start("bvwbjplbgvbhsrlpgdmjqwftvncz")).must_equal(5)
    value(packet_start("nppdvjthqldpwncqszvftbrmjlhg")).must_equal(6)
    value(packet_start("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")).must_equal(10)
    value(packet_start("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")).must_equal(11)
  end
end

puts "First marker: #{packet_start(File.read("input.txt"))}"
