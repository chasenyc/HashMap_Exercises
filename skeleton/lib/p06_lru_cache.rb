require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :store
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(get_link(key))
      return @map.get(key)

    else
      if @map.count == @max
        eject!
        @map.delete(@store.first)
        @map.set(key, @prc.call(key)) #add key
        return @prc.call(key)
      else
        @map.set(key, @prc.call(key))
        return @prc.call(key)
      end
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def get_link(key)
    @map.each_with_link do |k,v,l|
      return l if k == key
    end
    nil
  end

  def update_link!(link)
    @map.delete(link)
    @map.set(link.key,link.val)
  end

  def eject!
    @store.delete_head
  end
end
