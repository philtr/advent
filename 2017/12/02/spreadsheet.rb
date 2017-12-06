class Spreadsheet
  def initialize(input)
    @input = input.chomp
  end

  def checksum
    @input.each_line.reduce(0) do |sum, row|
      row = row.split(/(\t|\s)/).select {|n| n =~ /\d/ }.map(&:to_i)
      sum += row.max - row.min
    end
  end
end
