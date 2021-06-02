require "pry"
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

  def show
    puts "Node is: #{@value}\n"
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

  def exist?(value)
    current = @root

    while current
      return true if current.value == value

      if current.value > value
        current = current.left
      else
        current = current.right
      end
    end

    false
  end

  # 1. breadth first: Level order
  # 2. depth first:
  #   2.1 Pre-order (root, left, right)
  #   2.2 In-order (left, root, right) => sort small to big
  #   2.3 Post-order (left, right, root)
  def pre_order(root = @root)
    return unless root

    root.show()
    pre_order(root.left) if root.left
    pre_order(root.right) if root.right
  end

  def in_order(root = @root)
    return unless root

    in_order(root.left) if root.left
    root.show()
    in_order(root.right) if root.right
  end

  def in_order2(root = @root)
    return unless root

    in_order2(root.right) if root.right
    root.show()
    in_order2(root.left) if root.left
  end

  def post_order(root = @root)
    return unless root

    post_order(root.left) if root.left
    post_order(root.right) if root.right
    root.show()
  end

  def height(root = @root)
    return -1 unless root
    return 0 if root.is_leaf?

    1 + [height(root.left), height(root.right)].max
  end
end

tree = Tree.new
tree.add(8)
tree.add(7)
tree.add(6)
tree.add(9)
tree.add(10)

tree.exist?(10)
tree.in_order()
puts "----\n"
tree.in_order2()
puts "----\n"
tree.post_order

puts "Height: #{tree.height()}"
