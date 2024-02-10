class Node

  attr_accessor :value, :next_node

  def initialize value=nil
    @value = value
    @next_node = nil
  end
end

class LinkedList

  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append val
    node = Node.new(val)
    @tail.next_node = node unless @tail == nil
    @tail = node
    @head = node if @head == nil
  end

  def prepend val
    node = Node.new(val)
    node.next_node = self.head unless @head == nil
    @head = node
    @tail = node if @tail == nil
  end

  def size
    size = 0
    node = head
    until node == nil
      node = node.next_node
      size += 1
    end
    return size
  end

  def at index
    i = 0
    node = head
    until i == index
      node = node.next_node
      i += 1
    end
    return node
  end

  def pop
    node = head
    until node.next_node == nil
      node = node.next_node
    end
    @tail = node
    node.next_node = nil
  end

  def contains? val
    node = head
    flag = false
    until node == nil
      return !flag if val == node.value
      node = node.next_node
    end
    return flag
  end

  def find val
    node = head
    i = 0
    until node == nil
      return i if val == node.value
      i += 1
      node = node.next_node
    end
    return nil
  end

  def to_s
    string = ""
    node = head
    until node == nil
      string << "( #{node.value} )->"
      node = node.next_node
    end
    string << "nil"
  end

  def insert_at val, index
    new_node = Node.new(val)
    if index == 0
      new_node.next_node = @head.next_node
      @head = new_node
    elsif index == self.size-1
      @tail.next_node = new_node
      @tail = new_node
    else
      node = self.at(index-1) # gets node which will be before new one
      new_node.next_node = node.next_node
      node.next_node = new_node
    end
  end

  def remove_at index
    if index == 0
      @head = @head.next_node
    elsif index == self.size-1
      node = self.at(index-1) # gets node which will be before new one
      node.next_node = nil
      @tail = node
    else
      node = self.at(index-1)
      node.next_node = node.next_node.next_node
    end
  end

end

array = Array.new(10) { rand(1..100) }

list = LinkedList.new

array.each { |el| list.append(el) }
puts list
list.prepend(0)
puts list
puts list.size
puts list.at(5)
list.pop
puts list
puts list.contains?(array[4])
puts list.find(array[4])
 list.insert_at(101, 0)
 list.insert_at(105, 8)
puts list
  list.remove_at(0)
  list.remove_at(list.size-1)
  list.remove_at(2)
puts list
