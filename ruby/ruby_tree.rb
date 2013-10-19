# Draw Ruby universe with gviz(graphviz wrapper in Ruby)
# try `gviz build [THIS_FILE]` at terminal

classes = ObjectSpace.each_object(Class)
                     .reject { |k| "#{k}".match /Gem|Thor|Gviz/ }

global layout:'fdp'
nodes style:'filled', colorscheme:'purd6'
edges color:'maroon'

classes.each do |klass|
  tree, mods = klass.ancestors.group_by { |anc| anc.is_a? Class }
                    .map { |_, k| k.reverse }
  next if tree.include?(Exception) && tree[-1] != Exception
  tree = tree.map.with_index { |k, i| [k, i] }
  tree.each_cons(2) do |(a, ai), (b, bi)|
    a_id, b_id = [a, b].map(&:to_id)
    route a_id => b_id
    node a_id, label:a, color:6-ai, fillcolor:6-ai
    node b_id, label:b, color:6-bi, fillcolor:6-bi
  end

  #mods = [] unless mods
  #mods.each do |mod|
  #  mod_id = mod.to_id
  #  route mod_id => klass.to_id
  #  node mod_id, label:mod, shape:'box'
  #end
end

save :ruby_tree, :png
