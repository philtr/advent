class Captcha
  def initialize(challenge, halfway: false)
    @challenge = challenge.to_s.gsub(/[^\d]/,"")
    @halfway = halfway
  end

  def response
    challenge_digits
      .each_with_index
      .reduce(0) { |sum, (digit, index)|
        sum += check(digit, index) ? digit.to_i : 0
      }
  end

  private

  def challenge_digits
    @challenge_digits ||= @challenge.to_s.reverse.chars
  end

  def check(digit, index)
    challenge_digits[index-distance] == digit
  end

  def distance
    @halfway ? challenge_digits.size / 2 : 1
  end
end
