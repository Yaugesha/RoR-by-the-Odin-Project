def merge_sort arr
  length = arr.length
  if length > 1
    left_arr = merge_sort arr[0..length/2-1]
    right_arr = merge_sort arr[length/2..length-1]
  end

  new_arr = []
  return arr if length == 1
  left_arr.each do |left_el|
    left_el_pushed = false
    right_arr.each do |right_el|
      if right_el <= left_el
        new_arr << right_el
        right_arr.delete(right_el)
      else
        new_arr << left_el
        left_el_pushed = !left_el_pushed
        break
      end
    end
    new_arr << left_el unless left_el_pushed
  end
  right_arr.each { |el| new_arr << el}

  new_arr
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
