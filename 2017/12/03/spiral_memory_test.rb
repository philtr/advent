require "minitest/autorun"
require_relative "spiral_memory"

class SpiralMemoryTest < Minitest::Test
  def test_steps_address_1
    memory = SpiralMemory.new(address: 1)
    assert_equal 0, memory.steps
  end

  def test_steps_address_12
    memory = SpiralMemory.new(address: 12)
    assert_equal 3, memory.steps
  end

  def test_address_265149
    memory = SpiralMemory.new(address: 265149)
    assert_equal 438, memory.steps
  end
end
