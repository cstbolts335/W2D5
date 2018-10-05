require "byebug"
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_reader :head, :tail
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if head.next == tail
    head.next
  end

  def last
    return nil if tail.prev == head
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    curr_node = first

    unless empty?
      until curr_node == tail
        return curr_node.val if curr_node.key == key
        curr_node = curr_node.next
      end
    end

    nil
  end

  def include?(key)
    curr_node = first

    unless empty?
      until curr_node == tail
        return true if curr_node.key == key
        curr_node = curr_node.next
      end
    end

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    prev_node = tail.prev
    prev_node.next = new_node
    new_node.prev = prev_node
    tail.prev = new_node
    new_node.next = tail
  end

  def update(key, val)
    curr_node = first

    unless empty?
      until curr_node == tail
        curr_node.val = val if curr_node.key == key
        curr_node = curr_node.next
      end
    end
  end

  def remove(key)
    curr_node = first

    unless empty?
      until curr_node == tail
        if curr_node.key == key
          next_node = curr_node.next
          next_node.prev = curr_node.prev
          curr_node.prev.next = next_node
          break
        end
        curr_node = curr_node.next
      end
    end
  end

  def each(&prc)
    curr_node = first

    unless empty?
      until curr_node == tail
        prc.call(curr_node)
        curr_node = curr_node.next
      end
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
