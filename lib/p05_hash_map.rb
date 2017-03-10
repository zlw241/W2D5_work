#require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require "byebug"

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    get(key).nil? ? false : true
  end

  def set(key, val)
    unless include?(key)
      resize! if count >= num_buckets
      @store[key.hash % num_buckets].append(key, val)
      self.count += 1
    else
      @store[key.hash % num_buckets].update(key, val)
    end
  end

  def get(key)
    hash_bucket = @store[key.hash % num_buckets]
    hash_bucket.empty? ? nil : hash_bucket.get(key)
  end

  alias_method :[], :get
  alias_method :[]=, :set

  def delete(key)
    unless self.get(key).nil?
      bucket(key).remove(key)
      self.count -= 1
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  private
  attr_accessor :store

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |bucket|
      bucket.each do |el|
        unless el == nil

          key = el.key
          val = el.val
          set(key, val)
        end
      end

    end
    self.count = 0
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
