#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module My
  class KmeansCluster
    LOOP_MAX = 100

    def initialize(word_counts, user_options = {})
      @word_counts = word_counts
      @min_and_max = {}
      @centroids = {}
      @cluster = Hash.new { |hash, key| hash[key] = [] }
      @options = {
        :centroids => 4
      }.merge(user_options)
    end

    # 重心をランダム値で初期化してから，相関の近いURLを所属させる
    # 相関の近いURLの平均値を新たな重心の値とし，再計算する
    # もし重心が前回と計算した結果と同じになったら，最適解と見なす
    def make_cluster
      @min_and_max = min_and_max_in_word_counts
      @centroids = random_centroids

      loop_counter = 0
      old_centroids = nil
      until (@centroids == old_centroids) or (LOOP_MAX < loop_counter)
        puts "Iteration #{loop_counter}"
        loop_counter += 1
        attach_urls_to_nearest_centroid
        old_centroids = Marshal.load(Marshal.dump(@centroids)) # ディープコピー

        # 重心に所属するURLがない場合は何もしない
        @centroids.each_key do |centroid|
          @centroids[centroid] = average_attached(centroid) if @cluster[centroid].any?
        end
      end
    end

    def print_cluster
      pp @cluster.values
    end

    private

    # 全てのURLにおいて各単語の出現回数のうち最大と最小のものを算出する
    def min_and_max_in_word_counts
      all_counts = Hash.new { |hash, key| hash[key] = [] }
      min_and_max = {}

      @word_counts.each do |url, counts|
        counts.each do |word, count|
          all_counts[word] << count
        end
      end

      all_counts.each do |word, counts|
        min_and_max[word] = Pair.new [counts.min, counts.max]
      end
      min_and_max
    end

    # 各単語の最大値と最小値の間でランダム値を生成する
    def random_centroids
      centroids = {}

      @options[:centroids].times do |centroid|
        random_counts = {}
        @min_and_max.each do |word, counts|
          random_counts[word] = rand(counts.max - counts.min) + counts.min
        end
        centroids[centroid] = random_counts
      end
      centroids
    end

    # 最も相関の近い重心に所属させる
    # 計算前に，一旦クラスタを空にする
    def attach_urls_to_nearest_centroid
      @cluster.clear

      @word_counts.each_key do |url|
        @cluster[nearest_centroid(url)] << url
      end
    end

    # 各重心に対して，URLごとの相関値を計算し，最も相関が高い重心を返す
    # 相関値は0に近い値が最も相関が大きくなるように"1 - ピアソン相関"とする
    def nearest_centroid(url)
      correlations = @centroids.map { |centroid, centroid_word_count|
        # valuesメソッドを使うと順序が保証されないので，別変数にvalueをそれぞれ格納する
        web_counts = []
        centroid_counts = []
        @word_counts[url].each do |word, count|
          web_counts << count
          centroid_counts << centroid_word_count[word]
        end
        1 - Pearson.calc(web_counts, centroid_counts)
      }

      correlations.rindex(correlations.min { |x, y| x.abs <=> y.abs })
    end

    # 任意の重心に属する全URLのword_count平均を計算する
    # URLごとのword_countをtransposeで単語単位に変換している
    def average_attached(centroid)
      average_word_counts = @cluster[centroid].map { |url|
        @centroids[centroid].keys.map { |word| @word_counts[url][word] }
      }.transpose.map { |all_counts|
        all_counts.inject(0) { |sum, count| sum + count }.quo(all_counts.size)
      }

      Hash[*@centroids[centroid].keys.zip(average_word_counts).flatten]
    end
  end
end

require 'pair'
require 'pearson'

cluster = My::KmeansCluster.new(blog_data_from('blogdata.txt'), { :centroids => 4 })
cluster.make_cluster
cluster.print_cluster
