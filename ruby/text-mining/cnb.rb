class CNB
  def initialize(smoothing_parameter = 1)
    @frequency_of_word_by_class = {}
    @number_of_training_data_of_class = Hash.new(0)
    @smoothing_parameter = smoothing_parameter
  end

  def training(label, feature)
    @frequency_of_word_by_class[label] = Hash.new(0) unless @frequency_of_word_by_class.has_key?(label)
    feature.each {|k, v|
      @frequency_of_word_by_class[label][k] += v
    }
    @number_of_training_data_of_class[label] += 1
  end

  def total_number_of_word_in_other_class(c)
    all_words = @frequency_of_word_by_class.values.map {|h| h.keys}.flatten.sort.uniq
    other_classes = @frequency_of_word_by_class.keys - [c]
    other_classes.map {|c|
      all_words.map {|w|
        @frequency_of_word_by_class[c][w]
      }
    }.flatten.inject(0) {|s, v| s + v}
  end

  def number_of_word_in_other_class(c, i)
    other_classes = @frequency_of_word_by_class.keys - [c]
    other_classes.map {|c| @frequency_of_word_by_class[c][i]}.inject(0) {|s, v| s + v}
  end

  def classifier(feature)
    all_class = @frequency_of_word_by_class.keys
    all_training_data = @number_of_training_data_of_class.values.inject(0) {|s, v| s + v}
    class_array = all_class.map {|c|
      n_c = total_number_of_word_in_other_class(c)
      alpha = @smoothing_parameter*feature.length
      term2nd = feature.to_a.map {|e|
        k = e[0]
        v = e[1]
        v*Math.log((number_of_word_in_other_class(c, k) + @smoothing_parameter).to_f/(n_c + alpha))
      }.inject(0) {|s, v| s + v}

      theta_c = @number_of_training_data_of_class[c].to_f/all_training_data
      [c, Math.log(theta_c) - term2nd]
    }.sort {|x, y| x[1] <=> y[1]}.flatten
    Hash[*class_array]
  end
end

cnb = CNB.new

label = "A"
feature = {"aaa" => 3, "bbb" => 1, "ccc" => 2}
cnb.training(label, feature)
label = "B"
feature = {"aaa" => 1, "bbb" => 4, "ccc" => 2}
cnb.training(label, feature)
label = "C"
feature = {"aaa" => 2, "bbb" => 3, "ccc" => 5}
cnb.training(label, feature)

puts cnb.classifier({"aaa" => 4, "bbb" => 3, "ccc" => 3})
puts cnb.classifier({"aaa" => 3, "bbb" => 4, "ccc" => 3})
puts cnb.classifier({"aaa" => 3, "bbb" => 3, "ccc" => 5})
