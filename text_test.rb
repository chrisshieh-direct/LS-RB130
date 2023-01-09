require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'text'

class TextTest < Minitest::Test
  def setup
    str = File.read('sample.txt')
    @bob = Text.new(str)
  end

  def test_swap
    str_test = File.read('sample_test_med2.txt')
    assert_output(str_test) { puts @bob.swap('a', 'e') }
    assert_equal(str_test, @bob.swap('a', 'e'))
  end

  def test_word_count
    assert_equal(72, @bob.word_count)
  end

  def teardown
  end
end
