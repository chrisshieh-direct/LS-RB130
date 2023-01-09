require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(1000)
    @sample_trans = Transaction.new(300)
    @sample_trans.amount_paid = 375
    @register.accept_money(@sample_trans)
  end

  def test_accept_money
    assert_equal(1375, @register.total_money)
  end

  def test_change
    assert_equal(75, @register.change(@sample_trans))
  end

  def test_receipt
    assert_output("You've paid $300.\n") { @register.give_receipt(@sample_trans) }
  end
end
