require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    @store[key_hash(key)] << key
    @count += 1
  end

  def include?(key)
    store[key_hash(key)].each do |k|
      return true if k == key
    end
    false
  end

  def remove(key)
    store[key_hash(key)].delete(key)
  end

  private

  def key_hash(key)
    key.hash % num_buckets
  end

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    flat_store = store.flatten
    bigger_store = Array.new(num_buckets * 2) { Array.new }
    @store = bigger_store
    @count = 0
    flat_store.each { |el| insert(el) }
  end
end
