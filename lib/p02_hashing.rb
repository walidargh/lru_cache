class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0.hash if empty?
    hash_array = []
    each_with_index do |el, i|
      hash_array << el.hash + i.hash
    end
    hash_array.inject(:^)
  end
end

class String
  def hash
    chars.map { |el| el.ord * 2393458910345734528458858293 }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    k_v_pair = to_a.map do |x, y|
      x.hash ^ y.hash
    end

    k_v_pair.hash
  end
end
