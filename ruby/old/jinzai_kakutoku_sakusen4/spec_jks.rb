require './jks.rb'

describe Map do

  before(:all) do
    @map = Map.load('./q.txt')
  end

  it 'should load map use Map.load' do
    ma = []
    ma << [:wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall]
    ma << [:wall, :start, :wall, :road, :wall, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :wall]
    ma << [:wall, :road, :wall, :road, :wall, :road, :road, :wall, :road, :road, :wall,
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :road, :road, :wall]
    ma << [:wall, :road, :wall, :road, :road, :road, :wall, :road, :road, :road, :road,
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :road, :road, :wall]
    ma << [:wall, :road, :road, :road, :road, :wall, :road, :road, :road, :road, :road,
           :road, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :wall]
    ma << [:wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :road, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall]
    ma << [:wall, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :wall]
    ma << [:wall, :wall, :road, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, 
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall]
    ma << [:wall, :road, :road, :road, :road, :road, :road, :wall, :road, :road, :road,
           :road, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :goal, :road, :road, :wall]
    ma << [:wall, :road, :road, :wall, :road, :road, :road, :road, :road, :road, :wall,
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :road,
           :wall, :road, :road, :wall]
    ma << [:wall, :road, :road, :road, :road, :wall, :road, :road, :road, :road, :road,
           :road, :road, :road, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :road,
           :wall, :road, :road, :wall]
    ma << [:wall, :road, :road, :road, :road, :road, :road, :road, :wall, :road, :road,
           :road, :road, :road, :road, :road, :road, :road, :road, :road, :road, :road,
           :road, :road, :road, :wall]
    ma << [:wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall, :wall,
           :wall, :wall, :wall, :wall]
    @map.m.should == ma
  end
 
  it 'should width is correct' do
    @map.width.should == 26
  end

  it 'should height is correct' do
    @map.height.should == 13
  end

  it 'check each_line method' do
    y = 0
    x = 0
    @map.each_line do |l|
      x = 0
      l.each do |v|
        v.should == @map.m[y][x]
        x += 1
      end
      y += 1
    end
  end

  it 'should [x,y] is equal to m[y][x]' do
    13.times do |y|
      26.times do |x|
        @map[x,y].should == @map.m[y][x]
      end
    end
  end

  it 'check map_line method' do
    a = @map.map_line do |l|
      l.map {|v| :road }
    end

    a.each do |l|
      l.each do |v|
        v.should == :road
      end
    end
  end
end

describe MapGraph do
  before(:all) do
    @graph = MapGraph.new(Map.load('./q.txt'))
  end

  it 'should make graph by Map instance' do
    gm = []
    gm << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none]
    gm << [:none, :start, :none, :line, :none, :vertex, :vertex, :line, :vertex, :vertex, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :vertex, :vertex, :none]
    gm << [:none, :line, :none, :line, :none, :vertex, :vertex, :none, :vertex, :vertex, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :vertex, :vertex, :none]
    gm << [:none, :line, :none, :vertex, :vertex, :vertex, :none, :vertex, :vertex, :vertex, :vertex, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :vertex, :vertex, :none]
    gm << [:none, :vertex, :line, :vertex, :vertex, :none, :vertex, :vertex, :vertex, :vertex, :vertex, :line, :line, :line, :vertex, :line, :line, :line, :line, :line, :line, :line, :line, :vertex, :vertex, :none]
    gm << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :line, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none]
    gm << [:none, :line, :vertex, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :vertex, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :none]
    gm << [:none, :none, :line, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none]
    gm << [:none, :vertex, :vertex, :line, :vertex, :vertex, :vertex, :none, :vertex, :vertex, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :line, :vertex, :goal, :vertex, :vertex, :none]
    gm << [:none, :vertex, :vertex, :none, :vertex, :vertex, :vertex, :vertex, :vertex, :vertex, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :line, :none, :vertex, :vertex, :none]
    gm << [:none, :vertex, :vertex, :vertex, :vertex, :none, :vertex, :vertex, :vertex, :vertex, :vertex, :vertex, :vertex, :vertex, :none, :none, :none, :none, :none, :none, :none, :line, :none, :vertex, :vertex, :none]
    gm << [:none, :vertex, :vertex, :vertex, :vertex, :line, :vertex, :vertex, :none, :vertex, :vertex, :vertex, :vertex, :vertex, :line, :line, :line, :line, :line, :line, :line, :vertex, :line, :vertex, :vertex, :none]
    gm << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none]
    @graph.gm.to_a.should == gm
  end

  it 'check each_line method' do
    y = 0
    @graph.each_line do |l|
      l.should == @graph.g[y]
      y += 1
    end
  end

  it 'should [x,y] is equal to g[y][x]' do
    13.times do |y|
      26.times do |x|
        @graph[x,y].should == @graph.g[y][x]
      end
    end
  end

  it 'should get shortest route' do
    r = []
    r << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :start, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :route, :route, :route, :route, :route, :none, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :route, :end, :none, :none, :none, ]
    r << [:none, :none, :none, :none, :none, :none, :route, :route, :route, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    r << [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, ]
    @graph.shortest_route.should == r
  end
end

describe 'jks.rb' do
  it 'should show usage if not assign any argv'
  it 'question file exist'
  it 'should output correct answer'
  it 'should output to file'
end
