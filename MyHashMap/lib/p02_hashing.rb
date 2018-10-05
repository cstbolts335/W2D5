class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 1
    each_with_index do |num, i|
      result *= num * (i + 1) + self.rotate[i]
    end

    result
  end
end

class String
  def hash
    result = 1
    each_char.with_index do |char, index|
      result *= char.ord + ((index + 1) + ((char.ord % (index + 1))))
    end

    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 1
    each do |k, v|
      result *= k.object_id + v.ord
    end
    result
  end
end
