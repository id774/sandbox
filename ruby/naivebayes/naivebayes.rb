#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class NaiveBayes
  def initialize
    @frequency_table = Hash.new()       # Frequency table for each class
    @word_table = Hash.new()            # Word feature table
    @instance_count_of = Hash.new(0)    # Instance count of each class
    @total_count = 0                    # Total instance count
  end

  def add_instance(document)
    # If frequency table does NOT have the label hash, add it
    unless @frequency_table.has_key?(document.label) then
      @frequency_table[document.label] = Hash.new(0)
    end

    # Add instance attributes into selected frequency table
    document.attributes.each{|word, frequency|
      @frequency_table[document.label][word] += 1   # Multivariate Berounoulli
      # @frequency_table[document.label][word] += frequency  # Multinomial

      @word_table[word] = 1   # add to word table
    }

    # Add instance count
    @instance_count_of[document.label] += 1
    @total_count += 1
  end

  def classify(attributes)
    # Local variables
    class_prior_of = Hash.new(1)
    likelihood_of = Hash.new(1)
    class_posterior_of = Hash.new(1)
    evidence = 0

    # Calculate class prior for each label
    @instance_count_of.each{|label,freq|
      class_prior_of[label] = freq.to_f / @total_count.to_f
    }

    # Calculate likelihood for each label
    @frequency_table.each_key{|label|

      # Initialize likelihood
      likelihood_of[label] = 1

      @word_table.each_key{|word|

        # Calculate word likelihood by laplace correction
        laplace_word_likelihood = (@frequency_table[label][word] + 1).to_f / (@instance_count_of[label] + @word_table.size()).to_f

        if attributes.has_key?(word) then
          likelihood_of[label] *= laplace_word_likelihood
        else
          likelihood_of[label] *= (1 - laplace_word_likelihood)
        end
      }

      # Calculate likelihood and add to evidence
      class_posterior_of[label] = class_prior_of[label] * likelihood_of[label]
      evidence += class_posterior_of[label]
    }

    # Regularize probability
    class_posterior_of.each{|label, posterior|
      class_posterior_of[label] = posterior / evidence
    }

    # Print result
    p attributes
    class_posterior_of.each{|label, posterior|
      print "#{label}:#{posterior}\n"
    }
    puts "---"
  end
end

class Document
  attr_reader :label
  attr_reader :attributes

  def initialize(label, attributes)
    @label = label           # String
    @attributes = attributes # Hash
  end
end


# Main
classifier = NaiveBayes.new();

# Train
classifier.add_instance(Document.new("positive", {"hoge" => 2, "piyo" => 1}))
classifier.add_instance(Document.new("negative", {"foo" => 2, "bar" => 2}))

# Test
classifier.classify({"hoge" => 1, "piyo" => 1})
classifier.classify({"foo" => 1, "bar" => 1})

