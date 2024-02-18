require_relative ("linked_list")

class Node
  attr_accessor :left, :right, :data

   def initialize(data)
     @data = data
     @left = nil
     @right = nil
   end
end

class Tree
  def initialize
    @root = nil
  end

  def build_tree(arr)
    sorted_arr = self.prepare_array(arr)
    @root = build_subtree(sorted_arr)
    @root
  end

  def insert(value)
    leaf = Node.new(value)
    find_place_for_leaf(leaf, @root)
  end

  def delete(value)
    deleted = @root.data == value ? @root : find_deleted_node(value, @root)
    replacement = find_replacement(deleted)
    deleted.data = replacement
    @root.data = deleted.data if @root.data == value
  end

  def level_order(&block)
    linked_list = LinkedList.new
    linked_list.append(@root)
    result = []
    level_order_traverse(linked_list, result)
    result.reduce([]) do  |accum, item|
      if item == nil
        accum
      elsif block_given?
        accum << block.call(item)
      else
        accum << item
      end
    end
  end

  def inorder(&block)
    result = []
    inorder_traverse(@root, result)
    result.reduce([]) do  |accum, item|
      if block_given?
        accum << block.call(item)
      else
        accum << item
      end
    end
  end

  def preorder(&block)
    result = []
    preorder_traverse(@root, result)
    result.reduce([]) do  |accum, item|
      if block_given?
        accum << block.call(item)
      else
        accum << item
      end
    end
  end

  def postorder(&block)
    result = []
    postorder_traverse(@root, result)
    result.reduce([]) do  |accum, item|
      if block_given?
        accum << block.call(item)
      else
        accum << item
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.data == nil
   pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
   puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
   pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

 private

  def build_subtree(arr)
    return nil if arr == [] || arr == nil
    length = arr.length
    element = arr[length/2]
    node = Node.new(element)

    node.left = build_subtree(arr[0, length/2])
    node.right = build_subtree(arr[length/2+1, length-1])

    node
  end

  def find_place_for_leaf(leaf, node)
    return if leaf.data == node.data
    if node.data > leaf.data
      return node.left = leaf if node.left == nil
      find_place_for_leaf(leaf, node.left)
    else
      return node.right = leaf if node.right == nil
      find_place_for_leaf(leaf, node.right)
    end
  end

  def find_deleted_node(deleted, current)
    if(current.data == deleted)
      return current
    elsif current.data > deleted
      return if current.left == nil
      find_deleted_node(deleted, current.left)
    else
      return if current.right == nil
      find_deleted_node(deleted, current.right)
    end
  end

  def find_replacement(deleted)
    right_smallest = find_the_smallest_in_right_subtree(deleted.right)
    left_biggest = find_the_biggest_in_left_subtree(deleted.left)

    replacement = right_smallest != nil ? right_smallest : left_biggest

    return replacement if replacement == nil
    replacement_val = replacement.data
    replacement.data = find_replacement(replacement)

    replacement_val
  end

  def find_the_biggest_in_left_subtree(node)
    return node if node == nil
    return find_the_biggest_in_left_subtree(node.right) unless node.right == nil
    return node
  end

  def find_the_smallest_in_right_subtree(node)
    return node if node == nil
    return find_the_smallest_in_right_subtree(node.left) unless node.left == nil
    return node
  end

  def level_order_traverse(quee, accamulator)
    return if quee.at(0) == nil
    node = quee.at(0).data
    quee.append(node.right) unless node.right == nil
    quee.append(node.left) unless node.left == nil
    accamulator << node.data
    quee.remove_at(0)
    level_order_traverse(quee, accamulator)
  end

  def inorder_traverse(node, accamulator)
    unless node == nil
      inorder_traverse(node.left, accamulator)
      accamulator << node.data
      inorder_traverse(node.right, accamulator)
    end
    accamulator
  end

  def preorder_traverse(node, accamulator)
    unless node == nil
      accamulator << node.data
      preorder_traverse(node.left, accamulator)
      preorder_traverse(node.right, accamulator)
    end
    accamulator
  end

  def postorder_traverse(node, accamulator)
    unless node == nil
      postorder_traverse(node.right, accamulator)
      accamulator << node.data
      postorder_traverse(node.left, accamulator)
    end
    accamulator
  end

  def prepare_array(arr)
    arr.sort().reduce([]) {|new_arr, elem| new_arr.none?(elem) ? new_arr << elem : new_arr}
  end

end

tree = Tree.new()
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print

# tree.insert(6)
# tree.pretty_print

# tree.delete(3)
# tree.pretty_print

p tree.level_order { |item| item+1}

p tree.inorder { |item| item+1}
p tree.preorder { |item| item+1}
p tree.postorder { |item| item+1}
