# Define a function to check if a string is "nice"
def is_nice(string)
  # Check if the string contains a pair of any two letters that appears at least twice
  has_repeated_pair = string.scan(/(.)\1/).any? { |pair| string.count(pair.join) >= 2 }

  # Check if the string contains at least one letter which repeats with exactly one letter between them
  has_repeated_letter_with_one_between = string.scan(/(.)(.)\1/).any?

  # Return true if the string satisfies both conditions, false otherwise
  has_repeated_pair && has_repeated_letter_with_one_between
end

# Open the input file
File.open("input.txt", "r") do |file|
  puts file.readlines.count { is_nice(_1) }
end
