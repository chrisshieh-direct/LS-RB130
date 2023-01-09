require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'transaction'

class TransactionTest < Minitest::Test
  def setup
    @sample_trans = Transaction.new(500)
  end

  def test_prompt_for_payment
    flower = StringIO.new("501\n")
    blankness = StringIO.new
    @sample_trans.prompt_for_payment(boing: flower, screen: blankness)
    assert_equal(501, @sample_trans.amount_paid)
  end
end
