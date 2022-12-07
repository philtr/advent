require "minitest/autorun"
require "minitest/spec"

describe "Golf Solution" do
  let(:result) { `ruby golf.rb example.txt`.lines(chomp: true) }

  it "finds the correct answers for the sample input" do
    _(result).must_equal(["95437","24933642"])
  end
end

part1, part2 = solution = `ruby golf.rb input.txt`.lines(chomp: true)
puts "=" * (solution.join(?,).length + 17)
puts "| GOLF SCORE: #{File.read("golf.rb").length} bytes        |"
puts "|" + "-" * (solution.join(?,).length + 15) + "|"
puts "| SOLUTION: [#{part1}, #{part2}] |"
puts "=" * (solution.join(?,).length + 17)
