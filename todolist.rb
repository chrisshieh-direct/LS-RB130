# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "Can only add Todo objects" if todo.class != Todo
    todos << todo
  end
  alias_method :<<, :add

  def size
    todos.length
  end

  def first
    todos[0]
  end

  def last
    todos[-1]
  end

  def to_a
    todos.clone
  end

  def done?
    todos.all? { |x| x.done? }
  end

  def item_at(index)
    raise IndexError, "Given index out of range of todo list" if index >= todos.length
    todos[index]
  end

  def mark_done_at(index)
    raise IndexError, "Given index out of range of todo list" if index >= todos.length
    todos[index].done!
  end

  def mark_undone_at(index)
    raise IndexError, "Given index out of range of todo list" if index >= todos.length
    todos[index].undone!
  end

  def remove_at(index)
    raise IndexError, "Given index out of range of todo list" if index >= todos.length
    todos.delete_at(index)
  end

  def done!
    todos.each { |x| x.done! }
  end
  alias_method :mark_all_done, :done!

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def to_s
    output = "___ Your To Do List ___\n"
    todos.each do |x|
      output += "#{x}\n"
    end
    output
  end

  def each
    idx = 0
    until idx == todos.length
      yield(todos[idx])
      idx += 1
    end
    self
  end

  def select
    result = TodoList.new(title)
    todos.each do |x|
      result << x if yield(x)
    end
    result
  end

  def find_by_title(str)
    todos.find { |x| x.title == str }
  end

  def all_done
    result = self.select { |x| x.done? }
  end

  def all_not_done
    result = self.select { |x| x.done? == false }
  end

  def mark_done(title)
    !!(find_by_title(title) && find_by_title(title).done!)
  end

  def mark_all_undone
    todos.each { |x| x.undone! }
  end

  private

  attr_accessor :todos
end

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!
p list.mark_done("Go to gym")
