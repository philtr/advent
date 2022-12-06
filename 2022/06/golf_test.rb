require "minitest/autorun"
require "minitest/spec"

def result(input) = `echo "#{input}" | ruby golf.rb`.chomp

describe "Golf Solution" do
  it "finds the correct solutions" do
    _(result "mjqjpqmgbljsphdztnvjfqwrcgsmlb").must_equal "[7, 19]"
    _(result "bvwbjplbgvbhsrlpgdmjqwftvncz").must_equal "[5, 23]"
    _(result "nppdvjthqldpwncqszvftbrmjlhg").must_equal "[6, 23]"
    _(result "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").must_equal "[10, 29]"
    _(result "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").must_equal "[11, 26]"
  end
end

solution = `ruby golf.rb input.txt`.chomp
puts "=" * (solution.length + 14)
puts "| GOLF SCORE: #{File.read("golf.rb").length} bytes   |"
puts "|" + "-" * (solution.length + 12) + "|"
puts "| SOLUTION: #{solution} |"
puts "=" * (solution.length + 14)
