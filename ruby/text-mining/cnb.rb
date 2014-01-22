class CNB
  def initialize(smoothing_parameter = 1)
    @frequency_table = {}
    @instance_count_of = Hash.new(0)
    @smoothing_parameter = smoothing_parameter
  end

  def train(label, feature)
    unless @frequency_table.has_key?(label)
      @frequency_table[label] = Hash.new(0)
    end
    feature.each {|word, frequency|
      @frequency_table[label][word] += frequency
    }
    @instance_count_of[label] += 1
  end

  def total_number_of_word_in_other_class(c)
    all_words = @frequency_table.values.map {|h| h.keys}.flatten.sort.uniq
    other_classes = @frequency_table.keys - [c]
    other_classes.map {|c|
      all_words.map {|w|
        @frequency_table[c][w]
      }
    }.flatten.inject(0) {|s, v| s + v}
  end

  def number_of_word_in_other_class(c, i)
    other_classes = @frequency_table.keys - [c]
    other_classes.map {|c| @frequency_table[c][i]}.inject(0) {|s, v| s + v}
  end

  def classify(feature)
    all_class = @frequency_table.keys
    all_train_data = @instance_count_of.values.inject(0) {|s, v| s + v}
    class_posterior_of = all_class.map {|c|
      n_c = total_number_of_word_in_other_class(c)
      alpha = @smoothing_parameter*feature.length
      term2nd = feature.to_a.map {|e|
        k = e[0]
        v = e[1]
        v*Math.log((number_of_word_in_other_class(c, k) + @smoothing_parameter).to_f/(n_c + alpha))
      }.inject(0) {|s, v| s + v}

      theta_c = @instance_count_of[c].to_f/all_train_data
      [c, Math.log(theta_c) - term2nd]
    }.sort {|x, y| x[1] <=> y[1]}.flatten
    Hash[*class_posterior_of]
  end
end

cnb = CNB.new

label = "A"
feature = {"aaa" => 3, "bbb" => 1, "ccc" => 2}
cnb.train(label, feature)
label = "B"
feature = {"aaa" => 1, "bbb" => 4, "ccc" => 2}
cnb.train(label, feature)
label = "C"
feature = {"aaa" => 2, "bbb" => 3, "ccc" => 5}
cnb.train(label, feature)

puts cnb.classify({"aaa" => 4, "bbb" => 3, "ccc" => 3})
puts cnb.classify({"aaa" => 3, "bbb" => 4, "ccc" => 3})
puts cnb.classify({"aaa" => 3, "bbb" => 3, "ccc" => 5})
