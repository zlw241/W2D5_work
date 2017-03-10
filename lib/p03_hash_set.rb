require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    unless include?(key)
      self[key] << key
      self.count += 1
    end
  end

  def include?(key)
    self[key].each do |k|
      return true if k == key
    end
    false
  end

  def remove(key)
    self[key].delete(key)
    self.count -= 1
  end

  private
  attr_writer :count
  attr_accessor :store

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(num_buckets * 2) { [] }
    old_store.each do |bucket|
      bucket.each do |el|
        self[el] << el
      end
    end
  end
end
