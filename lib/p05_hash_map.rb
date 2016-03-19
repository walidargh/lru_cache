require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count, :store
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if @count == @store.size
    delete(key) if include?(key)
    @store[bucket(key)].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@store.size * 2) { LinkedList.new }
    @count = 0

    old_store.each do |arr|
      arr.each do |el|
        set(el.key, el.val)
      end
    end
  end

  def bucket(key)
    key.hash % num_buckets
    # optional but useful; return the bucket corresponding to `key`
  end
end
