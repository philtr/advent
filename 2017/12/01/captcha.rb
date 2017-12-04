class Captcha
  def initialize(challenge)
    @challenge = challenge
  end

  def response
    challenge_digits
      .each_with_index
      .reduce(0) { |sum, (digit, index)|
        sum += digit.to_i if challenge_digits[index-1] == digit
        sum
      }
  end

  private

  def challenge_digits
    @challenge_digits ||= @challenge.to_s.reverse.chars.select { |n| n =~ /\d/ }
  end
end
