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

  def prepare_array(arr)
    arr.sort().reduce([]) {|new_arr, elem| new_arr.none?(elem) ? new_arr << elem : new_arr}
  end

end

tree = Tree.new()
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
