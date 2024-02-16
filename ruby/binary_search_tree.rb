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
    p replacement
    deleted.data = replacement.data
    @root.data = deleted.data if @root.data == value
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
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
    if(current.data == deleted || current.data == deleted)
      return current.data
    elsif current.data > deleted
      return if current.left == nil
      find_parent_of_deleted(deleted, current.left)
    else
      return if current.right == nil
      find_parent_of_deleted(deleted, current.right)
    end
  end

  def find_replacement(deleted)

    right_smallest = find_the_smallest_in_right_subtree(deleted.right)
    left_biggest = find_the_biggest_in_left_subtree(deleted.left)

    replacement = right_smallest != nil ? right_smallest : left_biggest

    if right_smallest == replacement
      p "here"
      right_smallest = find_the_smallest_in_right_subtree(deleted.right)
    else
      left_biggest = find_the_biggest_in_left_subtree(right_smallest.left)
    end

    replacement
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

  def prepare_array(arr)
    arr.sort().reduce([]) {|new_arr, elem| new_arr.none?(elem) ? new_arr << elem : new_arr}
  end

end

tree = Tree.new()
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print

tree.insert(6)
tree.pretty_print

tree.delete(8)
tree.pretty_print
