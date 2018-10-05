require 'byebug'

class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max + 1) {false}
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    store[num] == true
  end

  private

  def is_valid?(num)
    num >= 0 && num < store.length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)

    if count == num_buckets
      resize!
    end

    unless include?(num)
      self[num] << num
      self.count += 1
    end
  end

  def remove(num)
    deleted = self[num].delete(num)
    unless deleted.nil?
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
      store[num % num_buckets]
  end

  def num_buckets
    store.length
  end

  def resize!
    new_array = Array.new((num_buckets) * 2) { Array.new }
    store.each do |sub_array|
      sub_array.each do |el|
        new_array[el % new_array.length] << el
      end
    end
    self.store = new_array
  end

end
