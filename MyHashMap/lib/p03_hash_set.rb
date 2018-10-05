class HashSet

  attr_accessor :store, :count 

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)

    if count == num_buckets
      resize!
    end

    unless include?(key)
      self[key] << key
      self.count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    deleted = self[key].delete(key)
    unless deleted.nil?
      self.count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new((num_buckets) * 2) { Array.new }
    store.each do |sub_array|
      sub_array.each do |el|
        new_array[el.hash % new_array.length] << el
      end
    end
    self.store = new_array
  end

end
