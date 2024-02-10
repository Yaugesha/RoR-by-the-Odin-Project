def merge_sort arr
  length = arr.length
  if length > 1
    left_arr = merge_sort arr[0..length/2-1]
    right_arr = merge_sort arr[length/2..length-1]
  end

  new_arr = []
  return arr if length == 1
  left_i = 0
  right_i = 0
  while left_i < left_arr.length
    if right_i < right_arr.length && right_arr[right_i] <= left_arr[left_i]
      new_arr << right_arr[right_i]
      right_i += 1
    else
      new_arr << left_arr[left_i]
      left_i += 1
    end
  end
  new_arr.concat(right_arr[right_i..right_arr.length-1]) if right_i < right_arr.length

  new_arr
end

#thanks CS50

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
