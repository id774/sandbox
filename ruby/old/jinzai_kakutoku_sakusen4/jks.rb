class Map
  def initialize(ary)
    @m = ary
    ws = ary.map{ |l| l.length }.uniq.sort
    @width = ws[0]
    @height = ary.size
  end

  def self.load(fn)
    ary = File.read(fn).split(/\r?\n/).map do |l|
            l.split('')
          end
    Map.new(ary.map do |l|
              l.map do |c|
                case c
                when '*'
                  :wall
                when 'S'
                  :start
                when ' '
                  :road
                when 'G'
                  :goal
                else
                  :road
                end
              end
            end)
  end

  def [](x,y)
    @m[y][x] rescue nil
  end

  def []=(x,y,v)
    @m[y][x] = v rescue nil
  end

  def each_line
    @m.each do |l|
      yield l
    end
  end

  def each
    @m.each do |l|
      l.each do |m|
        yield m
      end
    end
  end

  def each_with_index
    @m.each_with_index do |l,y|
      l.each_with_index do |v,x|
        yield x,y,v
      end
    end
  end

  def map_with_index
    @m.each_with_index.map do |l,y|
      l.each_with_index.map do |v,x|
        yield x,y,v
      end
    end
  end

  def map_with_index!
    @m = @m.each_with_index.map do |l,y|
      l.each_with_index.map do |v,x|
        yield x,y,v
      end
    end
  end

  def map_line
    @m.map do |l|
      yield l
    end
  end

  def map_line!
    @m.map! do |l|
      yield l
    end
  end

  def map
    @m.map do |l|
      l.map do |v|
        yield v
      end
    end
  end

  def map!
    @m.map! do |l|
      l.map do |v|
        yield v
      end
    end
  end

  def to_a
    @m
  end
  attr_reader :width, :height, :m
end

class MapGraph
  def initialize(map)
    # Degenerate
    @gm = Map.new(map.to_a)
    @gm.map! do |v|
      case v
      when :wall
        :none
      when :start
        :start
      when :goal
        :goal
      else
        :vertex
      end
    end

    @gm.map_with_index! do |x,y,v|
      if v == :vertex
        ud = @gm[x,y-1] == :vertex || @gm[x,y+1] == :vertex
        lr = @gm[x-1,y] == :vertex || @gm[x+1,y] == :vertex
        unless ud && lr
          :line
        else
          :vertex
        end
      else
        v
      end
    end
  end

  def to_s
    @gm.to_a.map do |l|
      l.map do |v|
        case v
        when :start
          'S'
        when :goal
          'G'
        when :none
          ' '
        when :vertex
          '+'
        when :line
          '*'
        end
      end.join('')
    end.join("\n")
  end
  attr_reader :g,:gm
end


if __FILE__ == $0
  abort 'usage: jks.rb filename' if ARGV.empty?
  map = Map.load(ARGV[0])
  graph = MapGraph.new(map)
  puts graph.to_s
end
