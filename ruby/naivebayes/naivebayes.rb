#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class NaiveBayes
  def initialize(type = "berounoulli")
    @frequency_table = Hash.new
    @word_table = Hash.new
    @instance_count_of = Hash.new(0)
    @total_count = 0
    @type = type
  end

  def train(label, attributes)
    unless @frequency_table.has_key?(label)
      @frequency_table[label] = Hash.new(0)
    end

    attributes.each{|word, frequency|
      if @type == "multinomial"
        @frequency_table[label][word] += frequency  # Multinomial w
      else
        @frequency_table[label][word] += 1   # Multivariate Berounoulli
      end
      @word_table[word] = 1
    }

    @instance_count_of[label] += 1
    @total_count += 1
  end

  def classify(attributes)
    class_prior_of = Hash.new(1)
    likelihood_of = Hash.new(1)
    class_posterior_of = Hash.new(1)
    evidence = 0

    @instance_count_of.each {|label,freq|
      class_prior_of[label] = freq.to_f / @total_count.to_f
    }

    @frequency_table.each_key{|label|
      likelihood_of[label] = 1
      @word_table.each_key{|word|
        laplace_word_likelihood = (@frequency_table[label][word] + 1).to_f /
          (@instance_count_of[label] + @word_table.size()).to_f

        if attributes.has_key?(word) then
          likelihood_of[label] *= laplace_word_likelihood
        else
          likelihood_of[label] *= (1 - laplace_word_likelihood)
        end
      }

      class_posterior_of[label] = class_prior_of[label] * likelihood_of[label]
      evidence += class_posterior_of[label]
    }

    class_posterior_of.each{|label, posterior|
      class_posterior_of[label] = posterior / evidence
    }

    return class_posterior_of
  end
end
