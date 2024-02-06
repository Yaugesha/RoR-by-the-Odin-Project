def bubble_sort arr
    length = arr.length
    while length > 1
        n_length = 0
        index = 1
        while index < length
            if arr[index] < arr[index-1]
                bubble = arr[index-1]
                arr[index-1] = arr[index]
                arr[index] = bubble
                n_length = index
            end
            index += 1
        end
        length = n_length
    end
    return arr
end

puts bubble_sort([4,3,78,2,0,2])
