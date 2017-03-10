

class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @store = [false] * max
  end

  def insert(el)
    is_valid?(el)
    store[el] = true
  end

  def remove(el)
    is_valid?(el)
    store[el] = false
  end

  def include?(el)
    is_valid?(el)
    store[el]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless (0..store.length).include?(num)
  end

end

class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    index = num % num_buckets
    store[index] << num
  end

  def remove(num)
    index = num % num_buckets
    store[index].delete(num)
  end

  def include?(num)
    index = num % num_buckets
    store[index].each do |item|
      return true if num == item
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count == num_buckets
      resize!
      self[num] << num
    else
      self[num] << num
    end
    self.count += 1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].each do |el|
      return true if el == num
    end
    false
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    flat_store = store.flatten
    bigger_store = Array.new(num_buckets * 2) { Array.new }
    self.store = bigger_store
    self.count = 0
    flat_store.each { |el| insert(el) }
  end
end
