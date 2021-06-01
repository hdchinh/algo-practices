class Node
  attr_accessor :value
  attr_accessor :left
  attr_accessor :right

  def initialize(value: nil, left: nil, right: nil)
    @value = value
    @left = left
    @right = right
  end

  def is_leaf?
    @left.nil? && @right.nil?
  end
end

class Tree
  attr_accessor :root

  def initialize(root: nil)
    @root = root
  end

  def add(value)
    new_node = Node.new(value: value)
    return @root = new_node unless @root

    current = @root

    while(true)
      if current.value > value
        return current.left = new_node unless current.left

        current = current.left
      else
        return current.right = new_node unless current.right

        current = current.right
      end
    end
  end

  def print(root = @root)
    return unless root

    puts "Node is: #{root.value}\n"
    print(root.left) if root.left
    print(root.right) if root.right
  end
end

tree = Tree.new
tree.add(8)
tree.add(7)
tree.add(6)
tree.add(9)
tree.add(10)

tree.print()
