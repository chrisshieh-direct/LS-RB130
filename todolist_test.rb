require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    gone = @list.shift
    assert_equal([@todo2, @todo3],@list.to_a)
    assert_equal(@todo1, gone)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_error
    assert_raises(TypeError) {@list.add(3)}
  end

  def test_additions
    @todo4 = Todo.new("todo4")
    @todo5 = Todo.new("todo5")
    @list.add(@todo4)
    @list << @todo5
    assert_equal([@todo1, @todo2, @todo3, @todo4, @todo5], @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(100) }
    assert_equal(@todo2, @list.item_at(1))
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(2).done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    @list.mark_undone_at(1)
    assert_equal(false, @list.item_at(1).done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    assert_equal(3, @list.size)
    @list.remove_at(1)
    assert_equal(2, @list.size)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    @list.item_at(1).done!

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    @list.done!

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    x = 0
    @list.each { |y| x += 1 }
    assert_equal(@list.size, x)
  end

  def test_each_return
    test_object = @list.each { |x| x }
    assert_same(test_object, @list)
  end

  def test_select
    @list.mark_done_at(1)
    new_list = TodoList.new(@list.title)
    new_list.add(@list.item_at(1))
    assert_equal(new_list.to_s,@list.select { |x| x.done? }.to_s)
  end

  def test_all_done_and_not_done
    @list.mark_done_at(1)
    new_list = TodoList.new(@list.title)
    new_list.add(@list.item_at(1))
    assert_equal(new_list.to_s, @list.all_done.to_s)

    new_list_2 = TodoList.new(@list.title)
    new_list_2.add(@list.item_at(0))
    new_list_2.add(@list.item_at(2))
    assert_equal(new_list_2.to_s, @list.all_not_done.to_s)
  end

  def test_mark_all_undone
    @list.done!
    assert_equal(@list.size, @list.all_done.size)
    @list.mark_all_undone
    assert_equal(@list.size, @list.all_not_done.size)
  end
end
