class Spreadsheet
  def initialize(input)
    @input = input.chomp
  end

  def difference_checksum
    reduce_rows do |row|
      row.max - row.min
    end
  end

  def divisor_checksum
    reduce_rows do |row|
      row.combination(2).each do |pair|
        pair = pair.sort.reverse
        break pair.reduce(:/) if pair.reduce(:%) == 0
      end
    end
  end

  private

  def reduce_rows
    @input.each_line.reduce(0) do |sum, row|
      row = row.split(/(\t|\s)/).select {|n| n =~ /\d/ }.map(&:to_i)
      sum += yield row
    end
  end
end
