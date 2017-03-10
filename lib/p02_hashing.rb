class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |c, i|
      temp = c.hash
      sum += temp ** (i+1)
    end
    (sum ** 2).to_s[1..-1].to_i
  end
end

class String
  def hash
    sum = 0
    self.split("").each_with_index do |c, i|
      sum += (c.ord * (c.ord+3)) ** (i + 1)
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |i, k|
      sum += i.hash + k.hash
    end
    (sum ** 2).to_s[1..-1].to_i
  end
end

def murmur_hash(key, len)
  seed = 12345678
  c1 = "0Xcc9e2d51".to_i(16)
  c2 = "0X1b873593".to_i(16)
  r1 = 15
  r2 = 13
  m = 5
  n = "0Xe6546b64".to_i(16)

  hash = seed
  key.to_s(2).chars.each_slice(4).each do |k|
    k = k.join.to_i(2)
    k *= c1
    k = k.to_s(2).chars.rotate(r1).join.to_i(2)
    k *= c2
    hash = hash ^ k
    hash = hash.to_s(2).chars.rotate(r2).join.to_i(2)
    hash = hash * m * n
  end
  hash ^= len
  hash = hash * "0X85ebca6b".to_i(16)
  hash ^= (hash >> 13)
  hash = hash * "0Xc2b2ae35".to_i(16)
  hash ^= (hash >> 16)
  hash % (2**32)
end

p murmur_hash(89, 41)
p murmur_hash(90, 41)
p murmur_hash(91, 41)
p murmur_hash(92, 41)

# p "hello".hash
# p "helli".hash
# p "goodbye".hash
# p 1.hash
# p 1.hash
# p 1.hash
