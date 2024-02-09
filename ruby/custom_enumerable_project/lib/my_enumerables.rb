module Enumerable
  # Your code goes here

  def my_each_with_index
    index = 0
    for item in self
      yield(item, index)
      index += 1
    end
  end

  def my_inject initial_value
    accamulator = initial_value
    for item in self
      accamulator = yield(accamulator, item)
    end
    accamulator
  end

  def my_select
    result = []
    for item in self
      result << item if yield(item)
    end
    result
  end

  def my_map
    result = []
    for item in self
      result << yield(item)
    end
    result
  end

  def my_count
    result = 0
    return self.length unless block_given?
    for item in self
      result += 1 if yield(item)
    end
    return result
  end

  def my_none?
    for item in self
      return false if yield(item)
    end
    true
  end

  def my_all?
    for item in self
      return false unless yield(item)
    end
    true
  end

  def my_any?
    for item in self
      return true if yield(item)
    end
    return false
  end

  def my_one?
    flag = false
    for item in self
      flag = !flag if yield(item)
    end
    flag
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array

  def my_each
    for item in self
      yield item
    end
  end
end
