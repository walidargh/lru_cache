require 'byebug'
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :store, :map, :prc
  def initialize(max, prc)
    @map = HashMap.new(max)
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(key)
    elsif count == @max
      eject!
      calc!(key)
    else
      calc!(key)
    end
    @map.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map.set(key, val)
    @store.insert(key, val)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(key)
    @store.remove(key)
    @store.insert(key, @map.get(key))
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    first_key = @store.first.key
    @map.delete(first_key)
    @store.remove(first_key)
  end
end
