require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @store[bucket_index(hashed_num(num))] << num
    @count += 1
    resize! if @count == num_buckets
  end

  def remove(num)
    @store[bucket_index(hashed_num(num))].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[bucket_index(hashed_num(num))].include?(num)
  end

  def validate(num)
    raise "error" if num < 0
  end

  private

  def bucket_index(num)
    num % num_buckets
  end

  def hashed_num(num)
    num.hash
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0

    old_store.flatten.each { |el| insert(el) unless el.nil?}
  end
end
