def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      first = array[index - 1]
      second = array[index]
      if block_given?
        next if yield(first) <= yield(second)
      else
        next if first <= second
      end
      first, second = second, first
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)
