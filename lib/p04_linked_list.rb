require 'byebug'
class Link
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

  def inspect
    "key: #{key} val: #{val} next: #{@next} prev: #{@prev}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head_sent, :tail_sent

  def initialize
    @head_sent = Link.new
    @tail_sent = Link.new
    @head_sent.next, @tail_sent.prev = @tail_sent, @head_sent
  end

  # def inspect
  #   "#{@head_sent.next} #{@tail_sent.prev}"
  # end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head_sent.next
  end

  def last
    @tail_sent.prev
  end

  def empty?
    @head_sent.next == @tail_sent
  end

  def get(key)
    node = @head_sent

    until node == @tail_sent
      return node.val if node.key == key
      node = node.next
    end

    nil
  end

  def include?(key)
    node = @head_sent

    until node == @tail_sent
      return true if node.key == key
      node = node.next
    end

    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)

    old_tail = @tail_sent.prev
    old_tail.next = new_link
    new_link.prev = old_tail
    new_link.next = @tail_sent
    @tail_sent.prev = new_link
  end

  def remove(key)
    node = @head_sent
    until node.next.nil?
      if node.key == key
        node.next.prev = node.prev
        node.prev.next = node.next
        node.next, node.prev = nil, nil
        break
      end
      node = node.next
    end
    nil
  end

  def each
    node = @head_sent.next
    until node == @tail_sent
      yield node
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
