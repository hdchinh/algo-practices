require "pry"

class Node
  attr_accessor :value
  attr_accessor :next_node

  def initialize(value: nil, next_node: nil)
    @value = value
    @next_node = next_node
  end

  def print
    puts "Value: #{value} | next: #{next_node}\n"
  end
end

class LinkList
  attr_accessor :head
  attr_accessor :tail
  attr_accessor :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def unshift(value)
    new_node = Node.new(value: value, next_node: head)

    if is_empty?
      @head = @tail = new_node
    else
      @head = new_node
    end

    increse_length()
  end

  def push(value)
    new_node = Node.new(value: value, next_node: nil)

    if is_empty?
      @head = @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end

    increse_length()
  end

  def index_of(value)
    current = @head
    index = 0

    while current
      return index if current.value == value

      current = current.next_node
      index += 1
    end

    return -1;
  end

  def pop
    new_tail = get_previous(@tail)

    if new_tail
      new_tail.next_node = nil
      @tail = new_tail
    else
      @tail = @head = new_tail # set both to be nil
    end

    descrese_length()
  end

  def shift
    return if @head.nil?

    if @head == @tail
      @head = @tail = nil
    else
      second = @head.next_node
      @head = second
    end

    descrese_length()
  end

  def delete_at(index)
    return if index >= @length || index < 0
    return shift() if index == 0
    return pop() if index == @length - 1

    current = @head
    run = 0

    while current
      break if run == index

      run += 1
      current = current.next_node
    end

    previous_of_current = get_previous(current)
    previous_of_current.next_node = current.next_node

    descrese_length()
  end

  def reverse
    previous = nil
    current = @head

    while current
      @tail = current if current == @head

      tmp = current.next_node
      current.next_node = previous
      previous = current
      current = tmp
    end

    @head = previous
  end

  def get_nth_from_the_end(nth)
    return if nth > @length

    fast_node = slow_node = @head

    0.upto(nth - 1) { fast_node = fast_node.next_node }

    while fast_node
      fast_node = fast_node.next_node
      slow_node = slow_node.next_node
    end

    slow_node.value
  end

  def print
    return unless @head

    current = @head
    puts "The length of linklist is: #{@length}\n"
    puts "Head: #{@head&.value}\n"
    puts "Tail: #{@tail&.value}\n\n"

    while current
      puts "Node: #{current.value}\n"
      current = current.next_node
    end
  end

  private

  def is_empty?
    head.nil?
  end

  def increse_length
    @length += 1
  end

  def descrese_length
    @length -= 1 if @length > 0
  end

  def get_previous(node)
    current = @head

    while current
      break if current.next_node == node

      current = current.next_node
    end

    current
  end
end

list = LinkList.new() # this mean we set head = tail = nil, and length = 0

list.unshift(20)
list.unshift(10)
list.push(30)
list.push(40)
list.push(50)
list.push(60)
list.push(70)
list.push(80)
list.push(90)
list.push(100)

list.reverse

puts list.get_nth_from_the_end(10)

list.print()
