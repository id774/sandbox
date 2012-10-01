#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def kcluster(rows, k=4, calc_distance=method(:pearson))
  # それぞれのポイントの最小値と最大値を求める
  # == データの各列の最小値と最大値を求める
  len = rows[0].length
  ranges = Array.new(len) do |i|
    r = rows.map{|row| row[i]}
    {:min=>r.min, :max=>r.max}
  end

  # 重心をランダムにk個配置
  clusters = Array.new(k) do |j|
    row = Array.new(len) do |i|
      rand(ranges[i][:max] - ranges[i][:min]).to_i + ranges[i][:min]
    end
    Bicluster.new(:id=>j, :v=>row)  # 相関係数メソッドはBiclusterを取る
  end

  row_clusters = rows.map{|row| Bicluster.new(:v=>row)}
  last_matches = nil

  100.times do |t|
    puts "Iteration #{t}"
    best_matches = Array.new(clusters.length){[]}
    # それぞれの行に対して，最も近い重心を探し出す
    row_clusters.each_index do |row_id|
      best_match_id = 0
      best_match_distance = calc_distance.call(clusters[0], row_clusters[row_id])
      (1...clusters.length).each do |cluster_id|
        d = calc_distance.call(clusters[cluster_id], row_clusters[row_id])
        if d < best_match_distance
          best_match_id = cluster_id
          best_match_distance = d
        end
      end
      best_matches[best_match_id] << row_id
    end

    # 結果が前回と同じであれば完了
    return best_matches if best_matches == last_matches
    last_matches = best_matches

    # 重心をそのメンバーの平均に移動する
    clusters.length.times do |cluster_id|
      next if best_matches[cluster_id].empty?
      avgs = [0.0] * len
      best_matches[cluster_id].each do |row_id|
        rows[row_id].each_with_index{|val, i| avgs[i] += val}
      end
      avgs.map!{|avg| avg / best_matches[cluster_id].length}
      clusters[cluster_id] = Bicluster.new(:v=>avgs)
    end
  end
  nil
end

blognames, words, data = read_file('blogdata.txt')
kclust = kcluster(data)
kclust.length.times do |k|
  clust = kclust[k]
  puts "cluster #{k}"
  clust.each do |i|
    puts "  #{blognames[i]}"
  end
end
