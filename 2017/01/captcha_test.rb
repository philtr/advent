require "minitest/autorun"
require_relative "captcha"

class TestCaptcha < Minitest::Test
  def test_first_example
    captcha = Captcha.new(1122)
    assert_equal 3, captcha.response
  end

  def test_second_example
    captcha = Captcha.new(1111)
    assert_equal 4, captcha.response
  end

  def test_third_example
    captcha = Captcha.new(1234)
    assert_equal 0, captcha.response
  end

  def test_fourth_example
    captcha = Captcha.new(91212129)
    assert_equal 9, captcha.response
  end

  def test_challenge_input
    input = File.read(File.join(File.dirname(__FILE__), "captcha_input.txt"))
    captcha = Captcha.new(input)

    assert_equal captcha.response, 1223
  end

  def test_challenge_with_distance
    input = File.read(File.join(File.dirname(__FILE__), "captcha_input.txt"))
    captcha = Captcha.new(input, halfway: true)

    assert_equal captcha.response, 1284
  end
end
