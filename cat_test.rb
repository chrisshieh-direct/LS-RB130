require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cat'

class CatTest < MiniTest::Test
  def setup
    @kitty = Cat.new('Kitty', 1)
  end

  def test_name
    refute_equal('Kitty', @kitty.name)
    # assert_equal('Milo', @kitty.name)
  end

  def test_miaow
  end

  def test_raises_error
  end

  def test_is_not_purrier
  end
end
