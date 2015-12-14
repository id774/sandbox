class Bicluster

  def initialize(vec, left=nil, right=nil, distance=0.0, id=nil)
    @left = left
    @right = right
    @vec = vec
    @id = id
    @distance = distance
  end

  def vec=(value)
    @vec = value
  end

  def vec
    return @vec
  end

  def left
    return @left
  end

  def left=(value)
      @left = value
  end

  def right
    return @right
  end

  def right=(value)
    @right = value
  end

  def id
    return @id
  end

  def id=(value)
    @id = value
  end

  def distance
    return @distance
  end

  def distance=(value)
    @distance = value
  end

end
