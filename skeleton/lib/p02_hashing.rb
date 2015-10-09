class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 12 if empty?

    result = 0

    each_with_index { |el, i| result += i.hash ^ el.hash }

    result
  end

end

class String
  def hash
    return 23 if empty?

    result = 0

    each_char.with_index { |chr, i| result += i ^ chr.ord }

    result
  end
end

class Hash
  def hash
    return 50 if empty?
    # result = 0
    #
    # each { |key, value| result += key.hash + value.hash }
    #
    # result
    (keys + values).map(&:to_s).sort.hash
  end
end
