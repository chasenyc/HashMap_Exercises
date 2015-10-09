class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, link = nil)
    @key, @val, @next = key, val, link
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index do |link, j|
      return link if i == j
    end
    nil
  end

  def first
  end

  def last
    link = @head
    until link.nil?
      return link if link.next.nil?
      link = link.next
    end
  end

  def empty?
  end

  def get(key)
    idx = get_link_idx(key)
    return nil if idx.nil?
    self[idx].val
  end

  def include?(key)
    idx = get_link_idx(key)
    return false if idx.nil?
    true
  end

  def insert(key, val)
    if @head.val.nil?
      @head = Link.new(key, val)
    else
      last.next = Link.new(key, val)
    end
  end

  def remove(key)
    idx = get_link_idx(key)
    if self[idx] == @head
      if @head.next.nil?
        @head = Link.new
      else
        @head = @head.next
      end
    else
      self[idx - 1].next = self[idx + 1]
    end
    # what to with unlinked link ?!?!? => garbage collection
  end

  def each
    link = @head
    until link.nil?
      yield link
      link = link.next
    end
  end

  def each_with_index
    count = 0
    link = @head

    until link.nil?
      yield link, count
      link = link.next
      count += 1
    end
  end

  def get_link_idx(key)
    idx = nil
    each_with_index {|link,i| idx = i if link.key == key }
    return nil if idx.nil?
    idx
  end
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
