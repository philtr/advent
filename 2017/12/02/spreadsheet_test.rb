require "minitest/autorun"
require_relative "spreadsheet"

class SpreadsheetTest < Minitest::Test

  def test_checksum_with_sample_input
    sample_input = <<-SAMPLE
      5 1 9 5
      7 5 3
      2 4 6 8
    SAMPLE

    spreadsheet = Spreadsheet.new(sample_input)

    assert_equal 18, spreadsheet.checksum
  end

  def test_checksum_with_challenge_input
    challenge_input = File.read(File.join(File.dirname(__FILE__), "spreadsheet_input.txt"))
    spreadsheet = Spreadsheet.new(challenge_input)

    assert_equal 43074, spreadsheet.checksum
  end
end
