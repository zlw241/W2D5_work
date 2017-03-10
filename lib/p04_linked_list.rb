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

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail, :current

  def initialize
    @head = Link.new
    @tail = Link.new
    @current = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    current == head
  end

  def get(key)
    self.each do |link|
      return link.val  if link.key == key
    end
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    # debugger
    new_link = Link.new(key, val)
    new_link.prev = current
    current.next = new_link
    new_link.next = tail
    self.current = new_link
    tail.prev = current
    # debugger
  end

  def update(key, val)
    return "empty" if empty?
    # debugger
    self.each do |link|
      # debugger
      if link.key == key
        link.val = val
      end

    end
    # debugger
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
      end
    end
  end

  def each(&prc)
    idx = head
    # while idx.next != nil
    #   # prc.call(p idk)
    #   prc.call(idx)
    #   idx = idx.next
    #
    # end

    until idx == last
      idx = idx.next
      prc.call(idx)
      # idx = idx.next


    end
    # prc.call(idx)

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
