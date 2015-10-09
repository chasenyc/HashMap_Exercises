class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.size && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[bucket_index(num)] << num
  end

  def remove(num)
    @store[bucket_index(num)].delete(num)
  end

  def include?(num)
    @store[bucket_index(num)].include?(num)
  end

  private

  def bucket_index(num)
    num % num_buckets
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @store[bucket_index(num)] << num
    @count += 1
    resize! if @count == num_buckets
  end

  def remove(num)
    @store[bucket_index(num)].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[bucket_index(num)].include?(num)
  end

  def validate(num)
    raise "error" if num < 0
  end

  private

  def bucket_index(num)
    num % num_buckets
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
